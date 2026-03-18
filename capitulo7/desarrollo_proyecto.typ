== 7.4 Desarrollo del Proyecto

=== 7.4.1 Stack Tecnológico Implementado

*Frontend:*
- *Next.js 14:* Framework de React con App Router para SSR y SSG
- *React 18:* Biblioteca de interfaces de usuario con Server Components
- *TypeScript:* Tipado estático para JavaScript
- *TailwindCSS:* Framework de estilos utility-first
- *shadcn/ui:* Componentes accesibles construidos sobre Radix UI
- *Zod:* Validación de esquemas en cliente y servidor
- *React Hook Form:* Gestión de formularios con validación

*Backend:*
- *Next.js API Routes:* Endpoints serverless integrados
- *Prisma ORM:* ORM type-safe para PostgreSQL
- *Supabase Auth:* Autenticación y autorización
- *Vercel AI SDK:* Integración con modelos de lenguaje
- *Resend:* Envío de emails transaccionales

*Base de Datos y Almacenamiento:*
- *Supabase (PostgreSQL):* Base de datos relacional en la nube
- *pgvector:* Extensión para almacenar embeddings vectoriales
- *Supabase Storage:* Almacenamiento de imágenes

*DevOps y Deployment:*
- *Git:* Control de versiones
- *GitHub:* Repositorio remoto
- *Vercel:* Hosting fullstack (frontend + API routes)
- *GitHub Actions:* CI/CD pipelines

=== 7.4.2 Implementación de Características Principales

*Sistema de Autenticación (Supabase Auth):*

El sistema implementa autenticación segura mediante Supabase:
1. Registro con validación de email único
2. Confirmación de email mediante enlace seguro
3. Autenticación con JWT manejada automáticamente
4. Sesiones persistentes con refresh tokens
5. Middleware de verificación en rutas protegidas
6. Sistema de roles (cliente, mesero, admin) mediante Row Level Security

*Sistema de Reservaciones:*

Funcionalidades implementadas:
- Calendario interactivo para selección de fecha/hora
- Gestión de mesas con capacidad y disponibilidad
- Validación de conflictos de horarios
- Confirmación automática por email (Resend)
- Estados: pendiente, confirmada, cancelada, completada
- Panel de administración para gestionar reservaciones

*Punto de Venta (POS):*

Implementación del módulo POS:
- Interfaz optimizada para pantallas táctiles
- Selección rápida de productos por categoría
- Asignación de mesa al pedido
- Estados de orden: pendiente, en_preparacion, listo, entregado
- Notificaciones en tiempo real a cocina
- Control de caja y cierre diario

*Sistema de Pedidos Presenciales:*

Flujo completo de pedidos:
1. Mesero selecciona mesa ocupada
2. Agrega productos al pedido
3. Envía orden a cocina
4. Cocina actualiza estado a "en preparación"
5. Cocina marca como "listo"
6. Mesero entrega y marca como "entregado"
7. Cliente solicita cuenta y realiza pago

*Panel Administrativo:*

Dashboard con funcionalidades:
- Gestión completa de productos y categorías
- Gestión de mesas y su disponibilidad
- Visualización de pedidos en tiempo real
- Gestión de reservaciones
- Estadísticas y reportes (ventas, productos populares)
- Gestión de usuarios y roles

=== 7.4.3 Integración con Servicios Externos

*Red Enlace / CyberSource (Pagos con Tarjeta):*

Configuración de la integración para pagos en Bolivia:
```typescript
// Configuración de CyberSource para Red Enlace
import CyberSource from 'cybersource-rest-client';

const configObject = {
  authenticationType: 'http_signature',
  runEnvironment: 'apitest.cybersource.com', // Producción: api.cybersource.com
  merchantID: process.env.CYBERSOURCE_MERCHANT_ID,
  merchantKeyId: process.env.CYBERSOURCE_KEY_ID,
  merchantsecretKey: process.env.CYBERSOURCE_SECRET_KEY,
};

// Procesar pago
export async function procesarPagoTarjeta(datos: DatosPago) {
  const clientReferenceInfo = {
    code: `BAMBU-${datos.orderId}`
  };
  
  const amountDetails = {
    totalAmount: datos.monto.toString(),
    currency: 'BOB' // Bolivianos
  };
  
  const orderInformation = {
    amountDetails,
    billTo: {
      firstName: datos.cliente.nombre,
      lastName: datos.cliente.apellido,
      email: datos.cliente.email
    }
  };

  // Crear pago mediante API de CyberSource
  const response = await paymentsApi.createPayment(requestObj);
  return response;
}
```

*QR Simple (Pagos QR Bolivia):*

Integración con sistema de pagos QR boliviano:
```typescript
// Generación de QR Simple para pagos
export async function generarQRSimple(monto: number, orderId: string) {
  const qrData = {
    comercio: process.env.QR_SIMPLE_COMERCIO_ID,
    monto: monto,
    moneda: 'BOB',
    referencia: orderId,
    concepto: `Pedido Restaurante Bambú #${orderId}`,
    vigencia: 30 // minutos
  };
  
  const response = await fetch(process.env.QR_SIMPLE_API_URL, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${process.env.QR_SIMPLE_API_KEY}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(qrData)
  });
  
  return response.json(); // Retorna imagen QR y datos de verificación
}
```

*Supabase Storage (Imágenes de Productos):*

Configuración de uploads:
```typescript
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

export async function uploadProductImage(file: File, productId: string) {
  const fileName = `products/${productId}/${Date.now()}_${file.name}`;
  
  const { data, error } = await supabase.storage
    .from('product-images')
    .upload(fileName, file, {
      cacheControl: '3600',
      upsert: false
    });
  
  if (error) throw error;
  
  // Obtener URL pública
  const { data: { publicUrl } } = supabase.storage
    .from('product-images')
    .getPublicUrl(fileName);
  
  return publicUrl;
}
```

*Resend (Emails Transaccionales):*

Configuración para envío de confirmaciones:
```typescript
import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);

export async function enviarConfirmacionReservacion(
  reservacion: Reservacion
) {
  const { data, error } = await resend.emails.send({
    from: 'Restaurante Bambú <reservas@bambu.bo>',
    to: reservacion.cliente.email,
    subject: 'Confirmación de Reservación - Restaurante Bambú',
    react: EmailConfirmacionReservacion({ reservacion })
  });
  
  return { data, error };
}
```

=== 7.4.4 Funcionalidades de Inteligencia Artificial

*Chatbot con RAG y pgvector:*

Implementación de búsqueda semántica:
```typescript
import { OpenAI } from 'openai';
import { createClient } from '@supabase/supabase-js';

const openai = new OpenAI();
const supabase = createClient(/*...*/);

export async function busquedaSemantica(consulta: string) {
  // 1. Generar embedding de la consulta
  const embeddingResponse = await openai.embeddings.create({
    model: 'text-embedding-3-small',
    input: consulta
  });
  const queryEmbedding = embeddingResponse.data[0].embedding;
  
  // 2. Buscar productos similares en pgvector
  const { data: productos } = await supabase.rpc('match_productos', {
    query_embedding: queryEmbedding,
    match_threshold: 0.7,
    match_count: 5
  });
  
  return productos;
}

// Función SQL en Supabase
/*
CREATE OR REPLACE FUNCTION match_productos(
  query_embedding vector(1536),
  match_threshold float,
  match_count int
)
RETURNS TABLE (id uuid, nombre text, descripcion text, precio decimal, similarity float)
AS $$
  SELECT 
    id, nombre, descripcion, precio,
    1 - (embedding <=> query_embedding) as similarity
  FROM productos
  WHERE 1 - (embedding <=> query_embedding) > match_threshold
  ORDER BY embedding <=> query_embedding
  LIMIT match_count;
$$ LANGUAGE sql STABLE;
*/
```

*Sistema de Recomendaciones:*

Recomendaciones basadas en historial:
```typescript
export async function obtenerRecomendaciones(userId: string) {
  // Obtener historial de pedidos del usuario
  const { data: historial } = await supabase
    .from('order_items')
    .select('producto_id, productos(categoria_id)')
    .eq('orders.user_id', userId);
  
  // Analizar categorías preferidas
  const categoriasPreferidas = analizarPreferencias(historial);
  
  // Obtener productos populares en esas categorías
  const { data: recomendaciones } = await supabase
    .from('productos')
    .select('*')
    .in('categoria_id', categoriasPreferidas)
    .order('veces_pedido', { ascending: false })
    .limit(5);
  
  return recomendaciones;
}
```

=== 7.4.5 Seguridad Implementada

*Medidas de Seguridad:*

1. *Autenticación y Autorización:*
  - Supabase Auth con JWT seguros
  - Row Level Security (RLS) en PostgreSQL
  - Verificación de roles en cada operación
  - Sesiones con refresh tokens automáticos

2. *Prevención de Inyecciones:*
  - Prisma ORM con queries parametrizadas
  - Validación de inputs con Zod
  - Sanitización automática de datos

3. *Protección contra Ataques:*
  - CORS configurado para dominios específicos
  - Headers de seguridad (Vercel Edge)
  - Rate limiting en endpoints críticos
  - Protección CSRF en formularios

4. *Gestión de Datos Sensibles:*
  - Variables de entorno en Vercel
  - Claves de API nunca expuestas al cliente
  - Logs sanitizados (sin datos sensibles)
  - Cumplimiento con normativas ASFI para pagos

5. *Validación de Pagos:*
  - Verificación de firma en callbacks de Red Enlace
  - Validación de montos antes de procesar
  - Registro de auditoría de transacciones

=== 7.4.6 Optimizaciones de Rendimiento

*Frontend:*
- Server Components de Next.js 14 (reducción de JavaScript al cliente)
- Streaming de componentes con Suspense
- Code splitting automático
- Lazy loading de imágenes con next/image
- Caching de páginas estáticas (ISR)
- Optimización de imágenes (WebP/AVIF)

*Backend:*
- Edge Functions de Vercel para baja latencia
- Connection pooling con Supabase
- Queries optimizadas con índices PostgreSQL
- Caching de respuestas frecuentes
- Paginación con cursores

*Base de Datos:*
- Índices compuestos para queries frecuentes
- Índice HNSW para búsquedas vectoriales rápidas
- Materialización de vistas para reportes
- Políticas RLS optimizadas
