== Bases de Datos y APIs

=== PostgreSQL y Supabase

PostgreSQL es un sistema de gestión de bases de datos relacional de código abierto, reconocido por su robustez, extensibilidad y cumplimiento con estándares SQL. A diferencia de bases de datos NoSQL como MongoDB, PostgreSQL ofrece transacciones ACID completas, integridad referencial y un sistema de tipos rico que garantiza la consistencia de los datos críticos del negocio.

Supabase proporciona una plataforma Backend-as-a-Service (BaaS) construida sobre PostgreSQL, ofreciendo:

- *Base de datos PostgreSQL gestionada:* Instancias dedicadas con backups automáticos, réplicas de lectura y escalado vertical.
- *Autenticación integrada:* Sistema completo de auth con soporte para email/password, OAuth (Google, Facebook) y magic links.
- *APIs automáticas:* Generación instantánea de endpoints REST y GraphQL basados en el esquema de la base de datos.
- *Almacenamiento de archivos:* Sistema de storage para imágenes de platillos y otros assets.
- *Extensiones PostgreSQL:* Soporte nativo para pgvector (búsqueda semántica), PostGIS (geolocalización) y otras extensiones.

=== Modelo de Datos Relacional

El esquema de base de datos se diseña siguiendo principios de normalización para eliminar redundancias y garantizar integridad. Las entidades principales del sistema incluyen:

*Gestión de Usuarios y Autenticación:*
- `users`: Perfiles de usuarios sincronizados con Supabase Auth, incluyendo nombre, teléfono y preferencias.
- `roles`: Definición de roles del sistema (administrador, mesero, cocina, cliente).
- `user_roles`: Relación muchos-a-muchos entre usuarios y roles.

*Catálogo de Productos:*
- `categories`: Categorías jerárquicas del menú (entradas, platos principales, bebidas, postres).
- `products`: Platillos con nombre, descripción, precio, imagen, tiempo de preparación y estado de disponibilidad.
- `product_embeddings`: Vectores de embeddings para búsqueda semántica, almacenados con pgvector.

*Sistema de Reservaciones:*
- `tables`: Registro de mesas físicas con capacidad y ubicación.
- `reservations`: Reservaciones con fecha, hora, mesa asignada, número de comensales y estado.
- `reservation_notifications`: Historial de notificaciones enviadas (confirmación, recordatorio).

*Punto de Venta y Pedidos:*
- `orders`: Pedidos con tipo (mesa/para llevar), estado, mesa asociada y totales.
- `order_items`: Items individuales de cada pedido con producto, cantidad, precio unitario y modificaciones.
- `order_status_history`: Registro temporal de cambios de estado para trazabilidad.

*Pagos y Transacciones:*
- `payments`: Transacciones de pago con método (efectivo, tarjeta, QR), monto y referencia externa.
- `cash_registers`: Sesiones de caja con apertura, cierre y totales.
- `cash_movements`: Movimientos de efectivo (ventas, retiros, fondos iniciales).

*Análisis e IA:*
- `reviews`: Reseñas de clientes con calificación, comentario y análisis de sentimiento.
- `recommendations_log`: Historial de recomendaciones generadas para análisis de efectividad.
- `demand_predictions`: Predicciones de demanda por día/hora generadas por el modelo.

=== Prisma ORM

Prisma es un ORM (Object-Relational Mapping) moderno para Node.js y TypeScript que proporciona una capa de abstracción type-safe sobre la base de datos. Sus componentes principales son:

*Prisma Schema:* Archivo declarativo que define el modelo de datos, relaciones y configuración de conexión. El esquema sirve como fuente única de verdad para la estructura de la base de datos.

```prisma
model Product {
  id          String   @id @default(cuid())
  name        String
  description String?
  price       Decimal  @db.Decimal(10, 2)
  categoryId  String
  category    Category @relation(fields: [categoryId], references: [id])
  orderItems  OrderItem[]
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}
```

*Prisma Client:* Cliente de base de datos auto-generado con tipos TypeScript completos, proporcionando autocompletado y detección de errores en tiempo de compilación.

*Prisma Migrate:* Sistema de migraciones que versiona cambios en el esquema y los aplica de manera controlada en diferentes ambientes.

Las ventajas de Prisma sobre queries SQL directas incluyen:

- *Type Safety:* Errores de tipos detectados antes de ejecutar el código.
- *Autocompletado:* IntelliSense completo para modelos, campos y relaciones.
- *Prevención de N+1:* APIs declarativas para eager loading de relaciones.
- *Migraciones versionadas:* Control de cambios en el esquema con rollback.

=== Diseño de API con Next.js App Router

Next.js 14 introduce el App Router con Route Handlers, un sistema moderno para construir APIs que aprovecha las capacidades de React Server Components. Los endpoints se definen como archivos en la estructura de carpetas:

```
app/
  api/
    products/
      route.ts          # GET /api/products, POST /api/products
      [id]/
        route.ts        # GET/PUT/DELETE /api/products/:id
    orders/
      route.ts
    reservations/
      route.ts
      availability/
        route.ts        # GET /api/reservations/availability
```

Cada Route Handler exporta funciones nombradas según el método HTTP:

```typescript
export async function GET(request: Request) {
  const products = await prisma.product.findMany({
    include: { category: true }
  })
  return Response.json(products)
}

export async function POST(request: Request) {
  const body = await request.json()
  const product = await prisma.product.create({ data: body })
  return Response.json(product, { status: 201 })
}
```

=== Seguridad y Validación

La API implementa múltiples capas de seguridad:

- *Autenticación:* Verificación de tokens JWT de Supabase Auth en cada request protegida mediante middleware.
- *Autorización:* Control de acceso basado en roles (RBAC) que verifica permisos antes de ejecutar operaciones sensibles.
- *Validación de entrada:* Esquemas Zod para validar y sanitizar datos de entrada, previniendo inyecciones y datos malformados.
- *Rate Limiting:* Limitación de requests por IP/usuario para prevenir abuso y ataques de denegación de servicio.
- *Auditoría:* Registro de operaciones críticas (pagos, modificaciones de pedidos) para trazabilidad.

=== Row Level Security (RLS)

Supabase implementa Row Level Security de PostgreSQL, permitiendo definir políticas de acceso a nivel de fila directamente en la base de datos. Esto proporciona una capa adicional de seguridad que se aplica independientemente de cómo se acceda a los datos:

```sql
-- Los usuarios solo pueden ver sus propias reservaciones
CREATE POLICY "Users can view own reservations" ON reservations
  FOR SELECT USING (auth.uid() = user_id);

-- Solo administradores pueden modificar productos
CREATE POLICY "Admins can modify products" ON products
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM user_roles 
      WHERE user_id = auth.uid() AND role = 'admin'
    )
  );
```

Esta arquitectura de defensa en profundidad garantiza que los datos del restaurante permanezcan seguros incluso ante vulnerabilidades en capas superiores de la aplicación.
