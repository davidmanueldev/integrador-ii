== 2.3 Tecnologías del Stack Tecnológico

El desarrollo del Sistema Integral de Gestión para el Restaurante Bambú se fundamenta en un stack tecnológico moderno basado en el ecosistema de React y servicios cloud. A continuación se describen las características, ventajas y justificación de cada tecnología empleada.

=== 2.3.1 Next.js 14: Framework de React para Producción

Next.js es un framework de React desarrollado por Vercel que proporciona funcionalidades esenciales para aplicaciones web de producción, incluyendo renderizado híbrido, optimización automática y routing basado en el sistema de archivos (Vercel, 2024).

*Características Principales*

_App Router (Next.js 14)_

La versión 14 introduce el App Router como arquitectura principal:

- *Server Components*: Componentes que se ejecutan en el servidor, reduciendo JavaScript enviado al cliente
- *Streaming*: Renderizado progresivo de la página mientras se cargan datos
- *Layouts anidados*: Estructura de UI que persiste entre navegaciones
- *Route Handlers*: API endpoints definidos junto a las páginas

*API Routes con Route Handlers*

Next.js permite crear endpoints de API mediante archivos en la carpeta `/app/api`:

```typescript
// app/api/products/route.ts
export async function GET(request: Request) {
  const products = await prisma.product.findMany();
  return Response.json(products);
}

export async function POST(request: Request) {
  const data = await request.json();
  const product = await prisma.product.create({ data });
  return Response.json(product, { status: 201 });
}
```

Ventajas:
- Backend y frontend en un mismo repositorio (monorepo)
- Serverless functions que escalan automáticamente en Vercel
- Type-safe con TypeScript integrado

*Optimizaciones Automáticas*

- Compresión automática de imágenes mediante `next/image`
- Code splitting automático
- Prefetching de páginas linkadas
- Bundle optimization mediante tree-shaking

*Justificación de Uso en el Proyecto*

Next.js 14 fue seleccionado por:

1. *Server Components*: Reducen JavaScript del cliente, mejorando rendimiento
2. *Streaming*: Mejora percepción de velocidad en páginas con datos de IA
3. *Vercel AI SDK*: Integración nativa para funcionalidades de IA
4. *Despliegue Simplificado*: Integración nativa con Vercel
5. *Escalabilidad*: Serverless functions escalan automáticamente

=== 2.3.2 React 18: Biblioteca para Interfaces de Usuario

React es una biblioteca JavaScript de código abierto desarrollada por Meta para construir interfaces de usuario mediante componentes reutilizables (Meta Open Source, 2024).

*Conceptos Clave de React 18*

_Concurrent Features_

React 18 introduce renderizado concurrente:

- *Suspense*: Manejo declarativo de estados de carga
- *Transitions*: Marcar actualizaciones como no urgentes
- *Automatic Batching*: Agrupación automática de actualizaciones de estado

```tsx
function ProductList() {
  return (
    <Suspense fallback={<Loading />}>
      <Products />
    </Suspense>
  );
}
```

*Hooks Principales*

```tsx
function ShoppingCart() {
  const [items, setItems] = useState([]);
  const [total, setTotal] = useState(0);
  
  useEffect(() => {
    const newTotal = items.reduce((sum, item) => sum + item.price, 0);
    setTotal(newTotal);
  }, [items]);
  
  return <div>Total: Bs. {total}</div>;
}
```

*Ecosistema React Utilizado*

- *React Hook Form + Zod*: Formularios con validación type-safe
- *TanStack Query*: Gestión de estado asíncrono y caché
- *shadcn/ui*: Componentes accesibles basados en Radix UI

=== 2.3.3 Supabase: Backend como Servicio

Supabase es una plataforma Backend-as-a-Service (BaaS) de código abierto construida sobre PostgreSQL, que proporciona base de datos, autenticación, almacenamiento y APIs automáticas.

*Características Principales*

_PostgreSQL Gestionado_

```sql
-- Tabla de productos con soporte para búsqueda vectorial
CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  category_id UUID REFERENCES categories(id),
  embedding VECTOR(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

*Supabase Auth*

Sistema completo de autenticación:

```typescript
// Registro de usuario
const { user, error } = await supabase.auth.signUp({
  email: 'cliente@example.com',
  password: 'securepassword'
});

// Login
const { session } = await supabase.auth.signInWithPassword({
  email, password
});
```

*Row Level Security (RLS)*

Políticas de seguridad a nivel de fila:

```sql
-- Usuarios solo ven sus propias reservaciones
CREATE POLICY "Users view own reservations" ON reservations
  FOR SELECT USING (auth.uid() = user_id);

-- Solo admin puede modificar productos
CREATE POLICY "Admin manages products" ON products
  FOR ALL USING (
    auth.jwt() ->> 'role' = 'admin'
  );
```

*Justificación para el Proyecto*

Supabase fue seleccionado por:

1. *PostgreSQL completo*: No es una versión limitada, acceso SQL total
2. *pgvector integrado*: Soporte nativo para embeddings sin servicios externos
3. *Auth completo*: Autenticación lista para producción
4. *RLS*: Seguridad robusta a nivel de base de datos
5. *Plan gratuito generoso*: Adecuado para MVPs y proyectos de grado

=== 2.3.4 Prisma: ORM Type-Safe

Prisma es un ORM (Object-Relational Mapping) moderno para Node.js y TypeScript que proporciona una capa de abstracción type-safe sobre la base de datos.

*Prisma Schema*

```prisma
model Product {
  id          String      @id @default(cuid())
  name        String
  description String?
  price       Decimal     @db.Decimal(10, 2)
  categoryId  String
  category    Category    @relation(fields: [categoryId], references: [id])
  orderItems  OrderItem[]
  createdAt   DateTime    @default(now())
  updatedAt   DateTime    @updatedAt
}

model Reservation {
  id          String   @id @default(cuid())
  userId      String
  tableId     String
  date        DateTime
  partySize   Int
  status      ReservationStatus @default(PENDING)
  table       Table    @relation(fields: [tableId], references: [id])
}
```

*Prisma Client*

```typescript
// Consultas type-safe con autocompletado
const products = await prisma.product.findMany({
  where: { 
    category: { name: 'Platos Principales' },
    price: { lte: 50 }
  },
  include: { category: true },
  orderBy: { price: 'asc' }
});

// Crear con relaciones
const order = await prisma.order.create({
  data: {
    tableId: 'table-5',
    items: {
      create: [
        { productId: 'prod-1', quantity: 2, unitPrice: 35 },
        { productId: 'prod-2', quantity: 1, unitPrice: 15 }
      ]
    }
  },
  include: { items: true }
});
```

*Ventajas de Prisma*

- *Type Safety*: Errores detectados en compilación
- *Autocompletado*: IntelliSense completo para modelos
- *Migraciones*: Control de versiones del esquema
- *Prevención de N+1*: APIs declarativas para eager loading

=== 2.3.5 Red Enlace: Pasarela de Pagos Boliviana

Red Enlace es la principal red de pagos electrónicos en Bolivia, supervisada por la Autoridad de Supervisión del Sistema Financiero (ASFI). Proporciona procesamiento de transacciones con tarjetas de débito y crédito emitidas en Bolivia.

*Características Principales*

_CyberSource API_

Red Enlace utiliza CyberSource (Visa) como procesador:

- API REST para integraciones modernas
- Tokenización de tarjetas para pagos recurrentes
- 3D Secure para autenticación adicional
- Reportes y conciliación automatizada

*QR Simple*

Modalidad de pago mediante código QR regulada por BCB:

- Estándar interoperable entre bancos bolivianos
- Sin necesidad de tarjeta física
- Confirmación en tiempo real
- Comisiones menores que tarjetas

*Justificación para el Proyecto*

Red Enlace fue seleccionado por:

1. *Contexto local*: Única opción para tarjetas bolivianas
2. *Regulación*: Cumplimiento con normativas ASFI
3. *QR Simple*: Modalidad popular en Bolivia
4. *Cobertura*: Acepta todas las tarjetas bancarias del país

=== 2.3.6 Vercel AI SDK

El Vercel AI SDK proporciona una abstracción unificada para integrar modelos de IA en aplicaciones Next.js.

*Características Principales*

```typescript
import { useChat } from 'ai/react';

function Chatbot() {
  const { messages, input, handleInputChange, handleSubmit } = useChat({
    api: '/api/chat'
  });

  return (
    <div>
      {messages.map(m => (
        <div key={m.id}>{m.role}: {m.content}</div>
      ))}
      <form onSubmit={handleSubmit}>
        <input value={input} onChange={handleInputChange} />
      </form>
    </div>
  );
}
```

*Streaming de Respuestas*

```typescript
// app/api/chat/route.ts
import { streamText } from 'ai';
import { openai } from '@ai-sdk/openai';

export async function POST(req: Request) {
  const { messages } = await req.json();
  
  const result = await streamText({
    model: openai('gpt-4o-mini'),
    messages,
    system: 'Eres el asistente del Restaurante Bambú...'
  });

  return result.toDataStreamResponse();
}
```

Este conjunto de tecnologías forma un stack moderno, robusto y escalable que proporciona una base sólida para el desarrollo del Sistema Integral de Gestión, equilibrando rendimiento, seguridad, experiencia del desarrollador y adaptación al contexto boliviano.
