== 2.3 Tecnologías del Stack Tecnológico

El desarrollo del Sistema de Pedidos en Línea para el Restaurante Bambú se fundamenta en un stack tecnológico moderno conocido como MERN modificado (MongoDB, Express implícito en Next.js, React, Node.js). A continuación se describen las características, ventajas y justificación de cada tecnología empleada.

=== 2.3.1 Next.js: Framework de React para Producción

Next.js es un framework de React desarrollado por Vercel que proporciona funcionalidades esenciales para aplicaciones web de producción, incluyendo renderizado híbrido, optimización automática y routing basado en el sistema de archivos (Vercel, 2023).

*Características Principales*

_Renderizado Híbrido_

Next.js soporta múltiples estrategias de renderizado según las necesidades de cada página:

- *Static Site Generation (SSG)*: Genera HTML en tiempo de compilación, ideal para contenido que no cambia frecuentemente (páginas de información, catálogo estático)
- *Server-Side Rendering (SSR)*: Genera HTML dinámicamente en cada petición, apropiado para contenido personalizado o que cambia frecuentemente
- *Incremental Static Regeneration (ISR)*: Permite actualizar páginas estáticas sin reconstruir todo el sitio
- *Client-Side Rendering (CSR)*: Renderizado en el navegador para interacciones dinámicas

*API Routes*

Next.js permite crear endpoints de API dentro del mismo proyecto mediante archivos en la carpeta `/pages/api` o `/app/api`:

```javascript
// pages/api/productos.js
export default async function handler(req, res) {
  if (req.method === 'GET') {
    const productos = await obtenerProductos();
    res.status(200).json(productos);
  }
}
```

Ventajas:
- Backend y frontend en un mismo repositorio (monorepo)
- Serverless functions que escalan automáticamente
- Type-safe API routes con TypeScript

*Optimizaciones Automáticas*

- Compresión automática de imágenes mediante `next/image`
- Code splitting automático (solo JavaScript necesario se carga para cada página)
- Prefetching de páginas linkadas para navegación instantánea
- Bundle optimization mediante tree-shaking

*Routing Basado en Archivos*

La estructura de carpetas define automáticamente las rutas:

```
pages/
  index.js           → /
  menu.js            → /menu
  pedidos/
    [id].js          → /pedidos/:id (ruta dinámica)
  admin/
    productos.js     → /admin/productos
```

*Justificación de Uso en el Proyecto*

Next.js fue seleccionado por las siguientes razones:

1. *SEO Optimizado*: SSR mejora indexación del catálogo de productos por motores de búsqueda
2. *Rendimiento Superior*: Optimizaciones automáticas resultan en tiempos de carga mínimos
3. *Developer Experience*: Hot reloading, TypeScript integrado, debugging simplificado
4. *Despliegue Simplificado*: Integración nativa con plataformas como Vercel, fácil configuración en AWS, Azure
5. *Escalabilidad*: API Routes serverless escalan automáticamente con demanda

=== 2.3.2 React: Biblioteca para Interfaces de Usuario

React es una biblioteca JavaScript de código abierto desarrollada por Meta (Facebook) para construir interfaces de usuario mediante componentes reutilizables (Meta Open Source, 2023). Es la biblioteca de UI más popular actualmente con un ecosistema extenso.

*Conceptos Clave de React*

_Componentes_

React divide la interfaz en componentes independientes y reutilizables:

```jsx
function TarjetaProducto({ nombre, precio, imagen }) {
  return (
    <div className="tarjeta">
      <img src={imagen} alt={nombre} />
      <h3>{nombre}</h3>
      <p>${precio}</p>
      <button>Agregar al Carrito</button>
    </div>
  );
}
```

Beneficios:
- Reutilización de código
- Testing más sencillo
- Mantenimiento simplificado
- Separación de responsabilidades

*Virtual DOM*

React utiliza un Virtual DOM (representación en memoria del DOM real) para optimizar actualizaciones:

1. Cuando cambia el estado, React crea un nuevo Virtual DOM
2. Compara con la versión anterior (diffing)
3. Calcula la forma más eficiente de actualizar el DOM real
4. Aplica solo los cambios necesarios (reconciliation)

Resultado: Actualizaciones rápidas incluso con interfaces complejas

*Hooks*

Los Hooks permiten usar estado y otras características de React en componentes funcionales:

```jsx
function CarritoCompras() {
  const [productos, setProductos] = useState([]);
  const [total, setTotal] = useState(0);
  
  useEffect(() => {
    // Calcular total cuando productos cambian
    const nuevoTotal = productos.reduce((sum, p) => sum + p.precio, 0);
    setTotal(nuevoTotal);
  }, [productos]);
  
  return <div>Total: ${total}</div>;
}
```

Hooks principales utilizados en el proyecto:
- `useState`: Gestión de estado local
- `useEffect`: Efectos secundarios (llamadas a API, suscripciones)
- `useContext`: Compartir datos entre componentes sin prop drilling
- `useReducer`: Estado complejo con lógica de actualización definida

*Flujo de Datos Unidireccional*

Los datos fluyen de componentes padres a hijos mediante props, garantizando:
- Comportamiento predecible
- Debugging facilitado
- Menos bugs relacionados con estado inconsistente

*Ecosistema React Utilizado*

_React Hook Form_
- Gestión eficiente de formularios con validación
- Mejor rendimiento (menos re-renders)
- Integración con validadores como Yup o Zod

*React Query / TanStack Query*
- Gestión de estado asíncrono (fetching, caching, sync con servidor)
- Actualizaciones optimistas
- Retry automático en caso de errores

*React Context API*
- Gestión de estado global sin librerías externas
- Ideal para autenticación, tema, carrito de compras

=== 2.3.3 MongoDB con Mongoose

MongoDB es una base de datos NoSQL documental de código abierto que almacena datos en formato JSON similar (BSON). Mongoose es una librería ODM (Object-Document Mapper) para Node.js que proporciona modelado de datos con esquemas.

*Características de MongoDB*

_Modelo de Documentos_

Los datos se almacenan como documentos JSON flexibles:

```javascript
{
  "_id": ObjectId("..."),
  "nombre": "Sushi Roll California",
  "precio": 15.99,
  "categoria": "Sushi",
  "ingredientes": ["cangrejo", "aguacate", "pepino"],
  "disponible": true,
  "valoracionPromedio": 4.7,
  "reviews": [
    { "usuario": "María", "rating": 5, "comentario": "Delicioso!" }
  ]
}
```

Ventajas:
- Esquema flexible (agregar campos sin modificar estructura completa)
- Documentos anidados (reviews dentro del producto)
- Arrays nativos (ingredientes)

*Consultas Expresivas*

MongoDB proporciona un lenguaje de consultas rico:

```javascript
// Buscar productos de categoría "Sushi" con precio < $20
db.productos.find({
  categoria: "Sushi",
  precio: { $lt: 20 },
  disponible: true
}).sort({ valoracionPromedio: -1 });

// Agregaciones para análisis
db.pedidos.aggregate([
  { $match: { estado: "completado" } },
  { $group: { _id: "$usuario", totalGastado: { $sum: "$total" } } },
  { $sort: { totalGastado: -1 } },
  { $limit: 10 }
]);
```

*Índices para Rendimiento*

```javascript
// Índice para búsquedas frecuentes por categoría
db.productos.createIndex({ categoria: 1, precio: 1 });
```

*Mongoose: ODM para Node.js*

Mongoose añade estructura y validación sobre MongoDB:

```javascript
const productoSchema = new mongoose.Schema({
  nombre: {
    type: String,
    required: [true, 'Nombre es requerido'],
    trim: true,
    maxlength: 100
  },
  precio: {
    type: Number,
    required: true,
    min: [0, 'Precio no puede ser negativo']
  },
  categoria: {
    type: String,
    enum: ['Entradas', 'Platos Principales', 'Postres', 'Bebidas'],
    required: true
  },
  ingredientes: [String],
  disponible: { type: Boolean, default: true },
  creadoEn: { type: Date, default: Date.now }
});

const Producto = mongoose.model('Producto', productoSchema);
```

Beneficios de Mongoose:
- Validación de datos declarativa
- Middleware (hooks) para lógica pre/post operaciones
- Population para resolver referencias entre documentos
- Virtuals para campos calculados

*Justificación para el Proyecto*

MongoDB + Mongoose son apropiados porque:

1. *Flexibilidad*: Productos pueden tener atributos variables (información nutricional optional, variantes de tamaño)
2. *Desarrollo Ágil*: Esquema evoluciona fácilmente sin migraciones complejas
3. *Escalabilidad*: Crece horizontalmente conforme aumenta demanda
4. *Integración*: JSON nativo funciona perfectamente con JavaScript/Node.js
5. *Consultas Complejas*: Agregaciones permiten análisis de ventas, productos populares, patrones de compra

=== 2.3.4 Stripe: Plataforma de Procesamiento de Pagos

Stripe es una plataforma de infraestructura de pagos en línea que permite a negocios aceptar pagos, gestionar suscripciones y manejar flujos financieros complejos (Stripe, 2023).

*Características Principales*

_API Completa y Moderna_

Stripe proporciona APIs RESTful bien documentadas para todas las operaciones:

```javascript
// Crear Payment Intent
const paymentIntent = await stripe.paymentIntents.create({
  amount: 2599, // En centavos (25.99 USD)
  currency: 'usd',
  payment_method_types: ['card'],
  metadata: { numeroPedido: 'ORD-2025-001' }
});
```

*Stripe Elements*

Componentes de UI pre-construidos para captura segura de información de pago:

```javascript
import { CardElement, useStripe, useElements } from '@stripe/react-stripe-js';

function FormularioPago() {
  const stripe = useStripe();
  const elements = useElements();
  
  const manejarSubmit = async (event) => {
    event.preventDefault();
    const { error, paymentIntent } = await stripe.confirmCardPayment(
      clientSecret,
      { payment_method: { card: elements.getElement(CardElement) } }
    );
  };
}
```

Ventajas:
- Cumplimiento PCI-DSS automático (Stripe maneja datos sensibles)
- Customizable con CSS
- Validación integrada

*Webhooks para Confirmación Segura*

Los webhooks notifican al sistema cuando eventos ocurren en Stripe:

```javascript
// pages/api/webhooks/stripe.js
export default async function handler(req, res) {
  const sig = req.headers['stripe-signature'];
  const event = stripe.webhooks.constructEvent(req.body, sig, webhookSecret);
  
  if (event.type === 'payment_intent.succeeded') {
    const paymentIntent = event.data.object;
    await actualizarPedidoComoPagado(paymentIntent.metadata.numeroPedido);
  }
  
  res.json({ received: true });
}
```

Importancia:
- Evita race conditions (usuario cierra navegador antes de confirmación)
- Fuente confiable de verdad (usuario no puede falsificar confirmación)
- Permite procesar pagos asíncronos

*Dashboard Completo*

Panel administrativo de Stripe proporciona:
- Visualización de todas las transacciones
- Reportes financieros automáticos
- Gestión de disputas y chargebacks
- Exportación de datos para contabilidad

*Ventajas de Stripe sobre Alternativas*

| Característica | Stripe | PayPal | Mercado Pago |
|---------------|--------|---------|--------------|
| API Developer-Friendly | Excelente | Buena | Buena |
| Documentación | Muy completa | Moderada | Moderada |
| Fees por Transacción | 2.9% + 0.30 | ~3.5% | ~3.4% |
| Cumplimiento PCI | Nivel 1 | Nivel 1 | Nivel 1 |
| Customización UI | Alta | Media | Media |
| Cobertura Global | 135+ países | 200+ países | América Latina |

*Justificación para el Proyecto*

Stripe fue seleccionado por:

1. *Experiencia del Desarrollador*: Documentación excepcional, SDKs modernos, sandbox de pruebas robusto
2. *Seguridad*: Cumplimiento PCI-DSS nivel 1 sin esfuerzo adicional
3. *Transparencia*: Fees claros, sin costos ocultos
4. *Integración*: Librerías oficiales para React (`@stripe/react-stripe-js`)
5. *Escalabilidad*: Maneja desde pequeñas transacciones hasta volúmenes empresariales

== NextAuth.js: Autenticación para Next.js

NextAuth.js es una solución completa de autenticación diseñada específicamente para aplicaciones Next.js, proporcionando soporte para múltiples proveedores y estrategias de autenticación (NextAuth.js, 2023).

*Características Principales*

_Múltiples Proveedores_

Soporta autenticación mediante:
- Credenciales (email/password)
- OAuth (Google, GitHub, Facebook, etc.)
- Email mágico (link de acceso)
- Web3 (wallets de criptomonedas)

*Configuración Simple*

```javascript
// pages/api/auth/[...nextauth].js
import NextAuth from 'next-auth';
import CredentialsProvider from 'next-auth/providers/credentials';

export default NextAuth({
  providers: [
    CredentialsProvider({
      name: 'Credentials',
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" }
      },
      async authorize(credentials) {
        const usuario = await verificarCredenciales(credentials);
        if (usuario) return usuario;
        return null;
      }
    })
  ],
  session: { strategy: 'jwt' },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.rol = user.rol;
      }
      return token;
    },
    async session({ session, token }) {
      session.user.rol = token.rol;
      return session;
    }
  }
});
```

*Hooks y Utilidades*

```jsx
import { useSession, signIn, signOut } from 'next-auth/react';

function ComponenteProtegido() {
  const { data: session, status } = useSession();
  
  if (status === 'loading') return <Cargando />;
  if (status === 'unauthenticated') return <IniciarSesion />;
  
  return <div>Bienvenido, {session.user.name}</div>;
}
```

*Seguridad Integrada*

- Tokens JWT firmados
- Cookies HTTP-only (no accesibles desde JavaScript del cliente)
- Protección CSRF automática
- Refresh tokens para sesiones de larga duración

*Justificación para el Proyecto*

NextAuth.js es ideal porque:

1. *Integración Nativa*: Diseñado específicamente para Next.js
2. *Flexibilidad*: Fácil agregar nuevos proveedores de autenticación en el futuro
3. *Seguridad*: Mejores prácticas implementadas por defecto
4. *Simplicidad*: Menos código boilerplate comparado con implementar autenticación manualmente
5. *Comunidad*: Ampliamente adoptado con extensa documentación y ejemplos

Este conjunto de tecnologías forma un stack moderno, robusto y escalable que proporciona una base sólida para el desarrollo del Sistema de Pedidos en Línea, equilibrando rendimiento, seguridad, experiencia del desarrollador y capacidad de evolución futura.
