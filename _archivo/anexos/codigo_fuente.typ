// Anexo E: Código Fuente del Prototipo
// Sistema Integral de Gestión - Restaurante Bambú
// Repositorio: https://github.com/davidmanueldev/restaurante-bambu

= ANEXO E: CÓDIGO FUENTE DEL PROTOTIPO

El código fuente completo del sistema está disponible en el repositorio GitHub:

#align(center)[
  #box(
    fill: rgb("#e3f2fd"),
    inset: 1em,
    radius: 5pt,
  )[
    *Repositorio:* https://github.com/davidmanueldev/restaurante-bambu
  ]
]

A continuación se presentan los fragmentos más relevantes del código fuente que implementan las funcionalidades principales del sistema.

== E.1 Esquema de Datos - Prisma

El esquema Prisma define la estructura de datos para PostgreSQL/Supabase:

```prisma
// prisma/schema.prisma
generator client {
  provider        = "prisma-client-js"
  previewFeatures = ["postgresqlExtensions"]
}

datasource db {
  provider   = "postgresql"
  url        = env("DATABASE_URL")
  extensions = [vector]
}

model User {
  id            String        @id @default(uuid())
  email         String        @unique
  nombre        String
  rol           Rol           @default(CLIENTE)
  telefono      String?
  createdAt     DateTime      @default(now())
  updatedAt     DateTime      @updatedAt
  reservaciones Reservacion[]
  pedidos       Pedido[]      @relation("MeseroPedidos")
}

enum Rol {
  CLIENTE
  MESERO
  ADMIN
}

model Mesa {
  id            String        @id @default(uuid())
  numero        Int           @unique
  capacidad     Int
  ubicacion     String?
  estado        EstadoMesa    @default(DISPONIBLE)
  activa        Boolean       @default(true)
  reservaciones Reservacion[]
  pedidos       Pedido[]
}

enum EstadoMesa {
  DISPONIBLE
  OCUPADA
  RESERVADA
}

model Producto {
  id                 String       @id @default(uuid())
  nombre             String
  descripcion        String?
  precio             Decimal      @db.Decimal(10, 2)
  imagenUrl          String?
  categoriaId        String
  categoria          Categoria    @relation(fields: [categoriaId], references: [id])
  disponible         Boolean      @default(true)
  tiempoPreparacion  Int?
  embedding          Unsupported("vector(1536)")?
  pedidoItems        PedidoItem[]
}
```

*Características:*
- Soporte para pgvector mediante extensión PostgreSQL
- Enums para estados tipados
- Relaciones con integridad referencial

#pagebreak()

== E.2 Modelo de Reservaciones

El modelo Reservacion gestiona las reservas de mesas:

```prisma
model Reservacion {
  id        String             @id @default(uuid())
  userId    String
  user      User               @relation(fields: [userId], references: [id])
  mesaId    String
  mesa      Mesa               @relation(fields: [mesaId], references: [id])
  fecha     DateTime           @db.Date
  hora      DateTime           @db.Time
  personas  Int
  estado    EstadoReservacion  @default(PENDIENTE)
  notas     String?
  createdAt DateTime           @default(now())
}

enum EstadoReservacion {
  PENDIENTE
  CONFIRMADA
  CANCELADA
  COMPLETADA
}
```

*Características:*
- Tipos de fecha y hora separados para mejor manejo
- Estados con enum para type-safety
- Relaciones bidireccionales con User y Mesa

#pagebreak()

== E.3 Autenticación con Supabase

El sistema implementa autenticación mediante Supabase Auth:

```typescript
// src/lib/supabase/server.ts
import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'

export async function createClient() {
  const cookieStore = await cookies()

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value, options }) =>
            cookieStore.set(name, value, options)
          )
        },
      },
    }
  )
}

// Función helper para verificar rol
export async function verificarRol(rolesPermitidos: string[]) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  if (!user) return false
  
  const { data: userData } = await supabase
    .from('users')
    .select('rol')
    .eq('id', user.id)
    .single()
  
  return rolesPermitidos.includes(userData?.rol)
}
```

*Características de Seguridad:*
- Manejo de cookies server-side
- Verificación de roles centralizada
- Integración con Next.js App Router

#pagebreak()

== E.4 Integración de Pagos con Red Enlace

El sistema procesa pagos mediante CyberSource (Red Enlace Bolivia):

```typescript
// src/app/api/pagos/tarjeta/route.ts
import { NextResponse } from 'next/server'
import CyberSource from 'cybersource-rest-client'
import { prisma } from '@/lib/prisma'

const configObject = {
  authenticationType: 'http_signature',
  runEnvironment: process.env.NODE_ENV === 'production' 
    ? 'api.cybersource.com' 
    : 'apitest.cybersource.com',
  merchantID: process.env.CYBERSOURCE_MERCHANT_ID,
  merchantKeyId: process.env.CYBERSOURCE_KEY_ID,
  merchantsecretKey: process.env.CYBERSOURCE_SECRET_KEY,
}

export async function POST(req: Request) {
  const { pedidoId, datosTarjeta } = await req.json()
  
  // Obtener pedido de la base de datos
  const pedido = await prisma.pedido.findUnique({
    where: { id: pedidoId },
    include: { items: true }
  })
  
  if (!pedido) {
    return NextResponse.json(
      { error: 'Pedido no encontrado' },
      { status: 404 }
    )
  }

  // Construir request para CyberSource
  const requestObj = {
    clientReferenceInformation: {
      code: `BAMBU-${pedidoId}`
    },
    paymentInformation: {
      card: {
        number: datosTarjeta.numero,
        expirationMonth: datosTarjeta.mesExp,
        expirationYear: datosTarjeta.anioExp,
        securityCode: datosTarjeta.cvv
      }
    },
    orderInformation: {
      amountDetails: {
        totalAmount: pedido.total.toString(),
        currency: 'BOB'
      }
    }
  }

  // Procesar pago
  const apiClient = new CyberSource.ApiClient()
  const instance = new CyberSource.PaymentsApi(configObject, apiClient)
  
  const response = await instance.createPayment(requestObj)
  
  if (response.status === 'AUTHORIZED') {
    // Actualizar pedido como pagado
    await prisma.pedido.update({
      where: { id: pedidoId },
      data: { 
        pagado: true, 
        metodoPago: 'TARJETA',
        estado: 'PAGADO'
      }
    })
    
    return NextResponse.json({ success: true, transactionId: response.id })
  }
  
  return NextResponse.json(
    { error: 'Pago rechazado' },
    { status: 400 }
  )
}
```

*Flujo de Pago:*
1. Mesero solicita cobro desde POS
2. Sistema consulta total del pedido
3. Se envía solicitud a CyberSource/Red Enlace
4. CyberSource procesa con el banco emisor
5. Si es exitoso, se actualiza estado a PAGADO
6. Se genera comprobante para el cliente

#pagebreak()

== E.5 Chatbot con RAG y pgvector

El sistema implementa búsqueda semántica para el chatbot:

```typescript
// src/app/api/chat/route.ts
import { OpenAI } from 'openai'
import { createClient } from '@/lib/supabase/server'
import { streamText } from 'ai'
import { openai } from '@ai-sdk/openai'

const openaiClient = new OpenAI()

export async function POST(req: Request) {
  const { messages } = await req.json()
  const ultimoMensaje = messages[messages.length - 1].content

  // 1. Generar embedding de la consulta
  const embeddingResponse = await openaiClient.embeddings.create({
    model: 'text-embedding-3-small',
    input: ultimoMensaje
  })
  const queryEmbedding = embeddingResponse.data[0].embedding

  // 2. Buscar productos similares en pgvector
  const supabase = await createClient()
  const { data: productos } = await supabase.rpc('match_productos', {
    query_embedding: queryEmbedding,
    match_threshold: 0.7,
    match_count: 5
  })

  // 3. Construir contexto para el LLM
  const contexto = productos?.map(p => 
    `- ${p.nombre}: ${p.descripcion} (Bs ${p.precio})`
  ).join('\n') || 'No se encontraron productos relacionados.'

  // 4. Generar respuesta con Vercel AI SDK
  const result = await streamText({
    model: openai('gpt-4o-mini'),
    system: `Eres el asistente virtual del Restaurante Bambú en El Alto, Bolivia.
Usa la siguiente información del menú para responder:

${contexto}

Responde de forma amable y concisa en español.
Si te preguntan por precios, menciona que están en Bolivianos (Bs).`,
    messages
  })

  return result.toDataStreamResponse()
}
```

*Función SQL para búsqueda vectorial:*
```sql
-- Crear función en Supabase
CREATE OR REPLACE FUNCTION match_productos(
  query_embedding vector(1536),
  match_threshold float,
  match_count int
)
RETURNS TABLE (
  id uuid,
  nombre text,
  descripcion text,
  precio decimal,
  similarity float
)
LANGUAGE sql STABLE
AS $$
  SELECT 
    id,
    nombre,
    descripcion,
    precio,
    1 - (embedding <=> query_embedding) as similarity
  FROM productos
  WHERE 1 - (embedding <=> query_embedding) > match_threshold
  ORDER BY embedding <=> query_embedding
  LIMIT match_count;
$$;
```

#pagebreak()

== E.6 Estructura del Proyecto

#figure(
  ```
  restaurante-bambu/
  ├── src/
  │   ├── app/                    # App Router (Next.js 14)
  │   │   ├── api/                # API Routes (Backend)
  │   │   │   ├── auth/           # Callbacks Supabase Auth
  │   │   │   ├── reservaciones/  # CRUD reservaciones
  │   │   │   ├── productos/      # CRUD productos
  │   │   │   ├── pedidos/        # Gestión POS
  │   │   │   ├── pagos/          # Red Enlace, QR, Efectivo
  │   │   │   ├── chat/           # Chatbot con RAG
  │   │   │   └── upload/         # Upload a Supabase Storage
  │   │   ├── (public)/           # Rutas públicas
  │   │   │   ├── menu/           # Catálogo público
  │   │   │   └── reservar/       # Formulario reservación
  │   │   ├── (auth)/             # Rutas autenticadas
  │   │   │   ├── pos/            # Punto de Venta
  │   │   │   ├── cocina/         # Vista cocina
  │   │   │   └── mis-reservas/   # Historial cliente
  │   │   └── admin/              # Panel administrador
  │   ├── components/             # Componentes React
  │   │   ├── ui/                 # shadcn/ui components
  │   │   ├── chat/               # Widget chatbot
  │   │   └── pos/                # Componentes POS
  │   ├── lib/                    # Utilidades
  │   │   ├── prisma.ts           # Cliente Prisma
  │   │   └── supabase/           # Clientes Supabase
  │   └── hooks/                  # Custom hooks
  ├── prisma/
  │   └── schema.prisma           # Esquema de BD
  ├── public/                     # Archivos estáticos
  └── .env.local                  # Variables de entorno
  ```,
  caption: [Estructura de directorios del proyecto],
)

== E.7 Estadísticas del Código

#figure(
  table(
    columns: (auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Métrica*], [*Cantidad*], [*Descripción*],
    [Archivos TypeScript/TSX], [60+], [Componentes y lógica],
    [API Endpoints], [15], [Rutas de backend],
    [Modelos Prisma], [8], [Esquemas de BD],
    [Componentes React], [35+], [UI reutilizables (shadcn/ui)],
    [Líneas de código], [~5,000], [Excluyendo dependencias],
  ),
  caption: [Estadísticas del código fuente],
)
