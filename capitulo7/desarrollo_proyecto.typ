== 7.4 Desarrollo del Proyecto

=== 7.4.1 Stack Tecnológico Implementado

*Frontend:*
- *Next.js 14:* Framework de React para SSR y SSG
- *React 18:* Biblioteca de interfaces de usuario
- *TypeScript:* Tipado estático para JavaScript
- *TailwindCSS:* Framework de estilos utility-first
- *Zod:* Validación de esquemas en el cliente
- *React Hook Form:* Gestión de formularios

*Backend:*
- *Node.js v18+:* Runtime de JavaScript
- *Express.js:* Framework web minimalista
- *Mongoose:* ODM para MongoDB
- *JWT:* Autenticación basada en tokens
- *Bcrypt:* Hashing de contraseñas
- *Stripe SDK:* Integración de pagos

*Base de Datos y Almacenamiento:*
- *MongoDB 6:* Base de datos NoSQL
- *MongoDB Atlas:* Servicio cloud de MongoDB
- *AWS S3 / Cloudinary:* Almacenamiento de imágenes

*DevOps y Deployment:*
- *Git:* Control de versiones
- *GitHub:* Repositorio remoto
- *Vercel:* Hosting del frontend
- *Railway:* Hosting del backend
- *GitHub Actions:* CI/CD pipelines

=== 7.4.2 Implementación de Características Principales

*Sistema de Autenticación:*

El sistema implementa autenticación segura mediante:
1. Registro con validación de email único
2. Hashing de contraseñas con bcrypt (10 rounds)
3. Generación de JWT con expiración de 7 días
4. Almacenamiento de tokens en httpOnly cookies
5. Middleware de verificación de autenticación
6. Sistema de roles (client, admin)

*Gestión de Productos:*

Funcionalidades implementadas:
- CRUD completo de productos
- Upload de imágenes a AWS S3
- Filtrado por categoría
- Búsqueda por nombre
- Paginación de resultados
- Productos destacados (featured)
- Control de disponibilidad

*Carrito de Compras:*

Implementación del carrito:
- Almacenamiento en localStorage (persistencia)
- Sincronización con Context API
- Actualización dinámica de cantidades
- Cálculo automático de totales
- Validación de disponibilidad antes de checkout

*Sistema de Pedidos:*

Flujo completo de pedidos:
1. Creación de orden temporal
2. Generación de Stripe Checkout Session
3. Redirección a página de pago
4. Webhook de confirmación de Stripe
5. Actualización de estado del pedido
6. Envío de confirmación al cliente
7. Panel de seguimiento para el cliente

*Panel Administrativo:*

Dashboard con funcionalidades:
- Gestión completa de productos y categorías
- Visualización de todos los pedidos
- Actualización de estados de pedidos
- Estadísticas básicas (ventas, pedidos, productos)
- Gestión de usuarios

=== 7.4.3 Integración con Servicios Externos

*Stripe (Pagos):*

Configuración de la integración:
```javascript
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

// Crear sesión de pago
const session = await stripe.checkout.sessions.create({
  payment_method_types: ['card'],
  line_items: orderItems,
  mode: 'payment',
  success_url: `${process.env.FRONTEND_URL}/orders/{CHECKOUT_SESSION_ID}`,
  cancel_url: `${process.env.FRONTEND_URL}/cart`,
  metadata: { orderId: order._id.toString() }
});

// Webhook de confirmación
app.post('/api/payments/webhook',
  express.raw({type: 'application/json'}),
  async (req, res) => {
    const sig = req.headers['stripe-signature'];
    const event = stripe.webhooks.constructEvent(
      req.body, sig, process.env.STRIPE_WEBHOOK_SECRET
    );

    if (event.type === 'checkout.session.completed') {
      const session = event.data.object;
      await updateOrderStatus(session.metadata.orderId, 'confirmed');
    }
  }
);
```

*AWS S3 (Almacenamiento de Imágenes):*

Configuración de uploads:
```javascript
const AWS = require('aws-sdk');
const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY,
  secretAccessKey: process.env.AWS_SECRET_KEY,
  region: process.env.AWS_REGION
});

const uploadToS3 = async (file) => {
  const params = {
    Bucket: process.env.S3_BUCKET_NAME,
    Key: `products/${Date.now()}_${file.originalname}`,
    Body: file.buffer,
    ContentType: file.mimetype,
    ACL: 'public-read'
  };

  const result = await s3.upload(params).promise();
  return result.Location;
};
```

=== 7.4.4 Seguridad Implementada

*Medidas de Seguridad:*

1. *Autenticación y Autorización:*
  - Contraseñas hasheadas con bcrypt
  - JWT en httpOnly cookies (previene XSS)
  - Verificación de roles en rutas protegidas

2. *Prevención de Inyecciones:*
  - Validación de inputs con express-validator
  - Sanitización de datos con Mongoose
  - Prepared statements implícitos en Mongoose

3. *Protección contra Ataques:*
  - CORS configurado para dominios específicos
  - Helmet para headers de seguridad
  - Rate limiting en endpoints críticos
  - CSRF tokens en formularios

4. *Gestión de Datos Sensibles:*
  - Variables de entorno para credenciales
  - No exposición de stacktraces en producción
  - Logs sanitizados (sin passwords ni tokens)

5. *Validación de Webhooks:*
  - Verificación de firma de Stripe
  - Validación de origen de requests

=== 7.4.5 Optimizaciones de Rendimiento

*Frontend:*
- Code splitting automático (Next.js)
- Lazy loading de imágenes
- Caching de páginas estáticas
- Optimización de imágenes (WebP)
- Minificación de CSS y JS

*Backend:*
- Índices en MongoDB para queries frecuentes
- Caching de productos con Redis (opcional)
- Compresión de respuestas (gzip)
- Paginación de resultados
- Connection pooling de MongoDB

*Base de Datos:*
- Índices compuestos para queries complejas
- Proyecciones para reducir transferencia de datos
- TTL index en sesiones para limpieza automática
