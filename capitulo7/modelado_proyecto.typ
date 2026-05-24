== Modelado o Mapeo General del Proyecto

=== Arquitectura General del Sistema

El proyecto implementa una arquitectura moderna basada en serverless y servicios cloud:

*Capa de Presentación (Frontend):*
- Framework: Next.js 14 con App Router
- Biblioteca UI: React 18 con Server Components
- Componentes: shadcn/ui basado en Radix UI
- Estado Global: React Context + TanStack Query
- Estilos: TailwindCSS
- Validación: Zod para schemas de datos
- Chat: Vercel AI SDK para interfaz de chatbot

*Capa de Lógica de Negocio (Backend):*
- API Routes: Route Handlers de Next.js
- ORM: Prisma para acceso type-safe a datos
- Autenticación: Supabase Auth con JWT
- IA: Vercel AI SDK + OpenAI API
- Validación: Zod para request/response
- Emails: Resend para notificaciones

*Capa de Datos (Database):*
- Base de Datos: PostgreSQL (Supabase)
- Extensiones: pgvector para embeddings
- Almacenamiento: Supabase Storage para imágenes
- Seguridad: Row Level Security (RLS)

=== Esquema de API REST

La API del sistema expone los siguientes endpoints:

*Autenticación (Supabase Auth):*
```
POST   /api/auth/register       - Registro de usuario
POST   /api/auth/login          - Inicio de sesión
POST   /api/auth/logout         - Cierre de sesión
GET    /api/auth/me             - Obtener usuario actual
```

*Productos:*
```
GET    /api/products            - Listar productos con filtros
GET    /api/products/:id        - Obtener producto por ID
POST   /api/products            - Crear producto (Admin)
PUT    /api/products/:id        - Actualizar producto (Admin)
DELETE /api/products/:id        - Eliminar producto (Admin)
GET    /api/products/search     - Búsqueda semántica con embeddings
```

*Reservaciones:*
```
GET    /api/reservations                - Listar reservaciones del usuario
GET    /api/reservations/availability   - Consultar disponibilidad
POST   /api/reservations                - Crear reservación
PUT    /api/reservations/:id            - Modificar reservación
DELETE /api/reservations/:id            - Cancelar reservación
```

*Pedidos (POS):*
```
GET    /api/orders              - Listar pedidos
GET    /api/orders/:id          - Obtener pedido específico
POST   /api/orders              - Crear nuevo pedido
PATCH  /api/orders/:id/status   - Actualizar estado
GET    /api/orders/kitchen      - Pedidos para cocina
```

*Pagos:*
```
POST   /api/payments/card       - Procesar pago con tarjeta (Red Enlace)
POST   /api/payments/qr         - Generar QR Simple
POST   /api/payments/qr/verify  - Verificar pago QR
POST   /api/payments/cash       - Registrar pago en efectivo
```

*IA y Chatbot:*
```
POST   /api/chat                - Conversación con chatbot
GET    /api/recommendations     - Obtener recomendaciones
GET    /api/predictions         - Predicción de demanda
POST   /api/reviews             - Crear reseña con análisis de sentimiento
```

=== Esquema de Base de Datos (Prisma)

*Modelo: User*
```prisma
model User {
  id            String        @id @default(cuid())
  email         String        @unique
  name          String
  phone         String?
  role          Role          @default(CLIENT)
  reservations  Reservation[]
  orders        Order[]
  reviews       Review[]
  createdAt     DateTime      @default(now())
  updatedAt     DateTime      @updatedAt
}

enum Role {
  CLIENT
  WAITER
  KITCHEN
  CASHIER
  ADMIN
}
```

*Modelo: Category y Product*
```prisma
model Category {
  id          String    @id @default(cuid())
  name        String    @unique
  description String?
  image       String?
  products    Product[]
}

model Product {
  id          String      @id @default(cuid())
  name        String
  description String?
  price       Decimal     @db.Decimal(10, 2)
  categoryId  String
  category    Category    @relation(fields: [categoryId], references: [id])
  image       String?
  available   Boolean     @default(true)
  prepTime    Int?        // minutos
  embedding   Unsupported("vector(1536)")?
  orderItems  OrderItem[]
  createdAt   DateTime    @default(now())
  updatedAt   DateTime    @updatedAt
}
```

*Modelo: Table y Reservation*
```prisma
model Table {
  id           String        @id @default(cuid())
  number       Int           @unique
  capacity     Int
  location     String?
  reservations Reservation[]
  orders       Order[]
}

model Reservation {
  id          String            @id @default(cuid())
  userId      String
  user        User              @relation(fields: [userId], references: [id])
  tableId     String
  table       Table             @relation(fields: [tableId], references: [id])
  date        DateTime
  partySize   Int
  status      ReservationStatus @default(PENDING)
  notes       String?
  createdAt   DateTime          @default(now())
  updatedAt   DateTime          @updatedAt
}

enum ReservationStatus {
  PENDING
  CONFIRMED
  CANCELLED
  COMPLETED
  NO_SHOW
}
```

*Modelo: Order y OrderItem*
```prisma
model Order {
  id          String        @id @default(cuid())
  orderNumber String        @unique
  userId      String?
  user        User?         @relation(fields: [userId], references: [id])
  tableId     String?
  table       Table?        @relation(fields: [tableId], references: [id])
  type        OrderType
  status      OrderStatus   @default(PENDING)
  items       OrderItem[]
  subtotal    Decimal       @db.Decimal(10, 2)
  tax         Decimal       @db.Decimal(10, 2)
  total       Decimal       @db.Decimal(10, 2)
  payments    Payment[]
  notes       String?
  createdAt   DateTime      @default(now())
  updatedAt   DateTime      @updatedAt
}

enum OrderType {
  DINE_IN
  TAKEOUT
}

enum OrderStatus {
  PENDING
  CONFIRMED
  PREPARING
  READY
  SERVED
  PAID
  CANCELLED
}
```

*Modelo: Payment*
```prisma
model Payment {
  id              String        @id @default(cuid())
  orderId         String
  order           Order         @relation(fields: [orderId], references: [id])
  method          PaymentMethod
  amount          Decimal       @db.Decimal(10, 2)
  status          PaymentStatus @default(PENDING)
  externalRef     String?       // Referencia Red Enlace o QR
  createdAt       DateTime      @default(now())
}

enum PaymentMethod {
  CASH
  CARD
  QR_SIMPLE
}

enum PaymentStatus {
  PENDING
  COMPLETED
  FAILED
  REFUNDED
}
```

=== Row Level Security (RLS)

Políticas de seguridad implementadas en Supabase:

```sql
-- Usuarios solo ven sus propias reservaciones
CREATE POLICY "Users view own reservations" ON reservations
  FOR SELECT USING (auth.uid() = user_id);

-- Usuarios pueden crear sus propias reservaciones
CREATE POLICY "Users create reservations" ON reservations
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Solo staff puede ver todos los pedidos
CREATE POLICY "Staff view all orders" ON orders
  FOR SELECT USING (
    auth.jwt() ->> 'role' IN ('WAITER', 'KITCHEN', 'CASHIER', 'ADMIN')
  );

-- Solo admin puede modificar productos
CREATE POLICY "Admin manages products" ON products
  FOR ALL USING (auth.jwt() ->> 'role' = 'ADMIN');
```

=== Mapa de Navegación

*Rutas Públicas:*
- `/` - Página de inicio
- `/menu` - Catálogo de productos
- `/reservations` - Sistema de reservaciones
- `/login` - Inicio de sesión
- `/register` - Registro de usuario

*Rutas de Cliente:*
- `/my-reservations` - Mis reservaciones
- `/profile` - Perfil de usuario

*Rutas de Staff (POS):*
- `/pos` - Punto de venta
- `/pos/tables` - Vista de mesas
- `/kitchen` - Pantalla de cocina

*Rutas Administrativas:*
- `/admin` - Dashboard con métricas
- `/admin/products` - Gestión de productos
- `/admin/categories` - Gestión de categorías
- `/admin/reservations` - Gestión de reservaciones
- `/admin/orders` - Historial de pedidos
- `/admin/users` - Gestión de usuarios
- `/admin/reports` - Reportes y análisis
- `/admin/predictions` - Predicción de demanda
- `/admin/sentiment` - Análisis de sentimiento
