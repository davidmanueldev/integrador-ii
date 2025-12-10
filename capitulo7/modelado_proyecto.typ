== 7.3 Modelado o Mapeo General del Proyecto

=== 7.3.1 Arquitectura General del Sistema

El proyecto implementa una arquitectura de tres capas (3-tier architecture):

*Capa de Presentación (Frontend):*
- Framework: Next.js 14 con React
- Rendering: Server-Side Rendering (SSR) y Static Site Generation (SSG)
- Estado Global: Context API de React
- Estilos: CSS Modules + TailwindCSS
- Validación: Zod para schemas de datos

*Capa de Lógica de Negocio (Backend):*
- Runtime: Node.js v18+
- Framework: Express.js
- API: RESTful con 10 endpoints principales
- Autenticación: JWT (JSON Web Tokens) con httpOnly cookies
- Validación: Express-validator
- Seguridad: Helmet, CORS, Rate Limiting

*Capa de Datos (Database):*
- Base de Datos: MongoDB 6+ (NoSQL)
- ODM: Mongoose para modelado de datos
- Almacenamiento de Imágenes: AWS S3 / Cloudinary
- Índices: Optimizados para queries frecuentes

=== 7.3.2 Esquema de API REST

La API del sistema expone los siguientes endpoints:

*Autenticación:*
```
POST   /api/auth/register       - Registro de usuario
POST   /api/auth/login          - Inicio de sesión
POST   /api/auth/logout         - Cierre de sesión
GET    /api/auth/me             - Obtener usuario actual
```

*Productos:*
```
GET    /api/products            - Listar todos los productos
GET    /api/products/:id        - Obtener producto por ID
POST   /api/products            - Crear producto (Admin)
PUT    /api/products/:id        - Actualizar producto (Admin)
DELETE /api/products/:id        - Eliminar producto (Admin)
```

*Categorías:*
```
GET    /api/categories          - Listar categorías
GET    /api/categories/:id      - Obtener categoría con productos
POST   /api/categories          - Crear categoría (Admin)
PUT    /api/categories/:id      - Actualizar categoría (Admin)
DELETE /api/categories/:id      - Eliminar categoría (Admin)
```

*Pedidos:*
```
GET    /api/orders              - Listar pedidos del usuario
GET    /api/orders/all          - Listar todos (Admin)
GET    /api/orders/:id          - Obtener pedido específico
POST   /api/orders              - Crear nuevo pedido
PUT    /api/orders/:id/status   - Actualizar estado (Admin)
```

*Pagos:*
```
POST   /api/payments/checkout   - Crear sesión de Stripe
POST   /api/payments/webhook    - Webhook de confirmación
```

=== 7.3.3 Esquema de Base de Datos

*Colección: users*
```javascript
{
  _id: ObjectId,
  email: String (unique, required),
  password: String (hashed, required),
  name: String (required),
  phone: String,
  address: {
    street: String,
    city: String,
    zipCode: String,
    references: String
  },
  role: String (enum: ['client', 'admin']),
  createdAt: Date,
  updatedAt: Date
}
```

*Colección: categories*
```javascript
{
  _id: ObjectId,
  name: String (required, unique),
  description: String,
  image: String (URL),
  active: Boolean (default: true),
  createdAt: Date,
  updatedAt: Date
}
```

*Colección: products*
```javascript
{
  _id: ObjectId,
  name: String (required),
  description: String,
  price: Number (required, min: 0),
  category: ObjectId (ref: 'Category'),
  image: String (S3 URL),
  available: Boolean (default: true),
  featured: Boolean (default: false),
  createdAt: Date,
  updatedAt: Date
}
```

*Colección: orders*
```javascript
{
  _id: ObjectId,
  orderNumber: String (unique, auto-generated),
  user: ObjectId (ref: 'User'),
  items: [{
    product: ObjectId (ref: 'Product'),
    name: String,
    price: Number,
    quantity: Number,
    subtotal: Number
  }],
  total: Number (required),
  status: String (enum: [
    'pending', 'confirmed', 'preparing',
    'ready', 'delivering', 'delivered', 'cancelled'
  ]),
  paymentId: String (Stripe Payment Intent),
  paymentStatus: String (enum: ['pending', 'paid', 'failed']),
  deliveryAddress: {
    street: String,
    city: String,
    zipCode: String,
    phone: String,
    references: String
  },
  notes: String,
  createdAt: Date,
  updatedAt: Date
}
```

*Colección: sessions*
```javascript
{
  _id: ObjectId,
  userId: ObjectId (ref: 'User'),
  token: String (hashed),
  expiresAt: Date,
  createdAt: Date
}
```

=== 7.3.4 Índices de Base de Datos

Para optimizar el rendimiento, se crean los siguientes índices:

```javascript
// users
db.users.createIndex({ email: 1 }, { unique: true })

// products
db.products.createIndex({ category: 1 })
db.products.createIndex({ available: 1, featured: -1 })

// orders
db.orders.createIndex({ user: 1, createdAt: -1 })
db.orders.createIndex({ orderNumber: 1 }, { unique: true })
db.orders.createIndex({ status: 1, createdAt: -1 })

// sessions
db.sessions.createIndex({ userId: 1 })
db.sessions.createIndex({ expiresAt: 1 }, { expireAfterSeconds: 0 })
```

=== 7.3.5 Mapa de Navegación

*Rutas Públicas:*
- `/` - Página de inicio
- `/menu` - Catálogo de productos
- `/menu/:category` - Productos por categoría
- `/product/:id` - Detalle de producto
- `/login` - Inicio de sesión
- `/register` - Registro de usuario

*Rutas Protegidas (Cliente):*
- `/cart` - Carrito de compras
- `/checkout` - Proceso de pago
- `/orders` - Historial de pedidos
- `/orders/:id` - Detalle de pedido
- `/profile` - Perfil de usuario

*Rutas Administrativas:*
- `/admin` - Dashboard administrativo
- `/admin/products` - Gestión de productos
- `/admin/categories` - Gestión de categorías
- `/admin/orders` - Gestión de pedidos
- `/admin/users` - Gestión de usuarios
- `/admin/analytics` - Reportes y estadísticas
