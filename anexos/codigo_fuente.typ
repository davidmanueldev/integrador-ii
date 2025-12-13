// Anexo E: Código Fuente del Prototipo
// Sistema de Pedidos en Línea - Restaurante Bambú
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

== E.1 Modelo de Datos - Usuario

El modelo de usuario define la estructura de datos para la autenticación:

```javascript
// src/models/User.js
import {model, models, Schema} from "mongoose";

const UserSchema = new Schema({
  name: {type: String},
  email: {type: String, required: true, unique: true},
  password: {type: String},
  image: {type: String},
}, {timestamps: true});

export const User = models?.User || model('User', UserSchema);
```

*Características:*
- Validación de email único a nivel de base de datos
- Timestamps automáticos (createdAt, updatedAt)
- Compatibilidad con Mongoose ODM

#pagebreak()

== E.2 Modelo de Datos - Pedidos

El modelo Order almacena la información de cada pedido realizado:

```javascript
// src/models/Order.js
import {model, models, Schema} from "mongoose";

const OrderSchema = new Schema({
  userEmail: String,
  phone: String,
  streetAddress: String,
  postalCode: String,
  city: String,
  country: String,
  cartProducts: Object,
  paid: {type: Boolean, default: false},
}, {timestamps: true});

export const Order = models?.Order || model('Order', OrderSchema);
```

*Características:*
- Almacena productos del carrito como objeto JSON flexible
- Flag `paid` para control de estado de pago
- Timestamps para auditoría

#pagebreak()

== E.3 Autenticación con NextAuth

El sistema implementa autenticación dual (credenciales y Google OAuth):

```javascript
// src/app/api/auth/[...nextauth]/route.js
import bcrypt from "bcrypt";
import NextAuth, {getServerSession} from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
import GoogleProvider from "next-auth/providers/google";
import { MongoDBAdapter } from "@auth/mongodb-adapter";

export const authOptions = {
  secret: process.env.SECRET,
  adapter: MongoDBAdapter(clientPromise),
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
    CredentialsProvider({
      name: 'Credentials',
      credentials: {
        username: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        const email = credentials?.email;
        const password = credentials?.password;

        const user = await User.findOne({email});
        const passwordOk = user &&
          bcrypt.compareSync(password, user.password);

        if (passwordOk) return user;
        return null;
      }
    })
  ],
};

// Función helper para verificar rol Admin
export async function isAdmin() {
  const session = await getServerSession(authOptions);
  const userEmail = session?.user?.email;
  if (!userEmail) return false;

  const userInfo = await UserInfo.findOne({email: userEmail});
  return userInfo?.admin || false;
}
```

*Características de Seguridad:*
- Contraseñas hasheadas con bcrypt
- Sesiones manejadas por NextAuth
- Verificación de rol administrador centralizada

#pagebreak()

== E.4 Integración de Pagos con Stripe

El checkout procesa pagos de forma segura mediante Stripe:

```javascript
// src/app/api/checkout/route.js
import {Order} from "@/models/Order";
import {getServerSession} from "next-auth";
const stripe = require('stripe')(process.env.STRIPE_SK);

export async function POST(req) {
  const {cartProducts, address} = await req.json();
  const session = await getServerSession(authOptions);
  const userEmail = session?.user?.email;

  // Crear orden en base de datos (estado: no pagado)
  const orderDoc = await Order.create({
    userEmail,
    ...address,
    cartProducts,
    paid: false,
  });

  // Construir items para Stripe
  const stripeLineItems = [];
  for (const cartProduct of cartProducts) {
    const productInfo = await MenuItem.findById(cartProduct._id);

    let productPrice = productInfo.basePrice;
    // Agregar precio de tamaño
    if (cartProduct.size) {
      const size = productInfo.sizes.find(
        s => s._id.toString() === cartProduct.size._id.toString()
      );
      productPrice += size.price;
    }
    // Agregar precio de extras
    if (cartProduct.extras?.length > 0) {
      for (const extra of cartProduct.extras) {
        const extraInfo = productInfo.extraIngredientPrices.find(
          e => e._id.toString() === extra._id.toString()
        );
        productPrice += extraInfo.price;
      }
    }

    stripeLineItems.push({
      quantity: 1,
      price_data: {
        currency: 'BOB',
        product_data: { name: cartProduct.name },
        unit_amount: productPrice * 100,
      },
    });
  }

  // Crear sesión de checkout en Stripe
  const stripeSession = await stripe.checkout.sessions.create({
    line_items: stripeLineItems,
    mode: 'payment',
    customer_email: userEmail,
    success_url: process.env.NEXTAUTH_URL +
      'orders/' + orderDoc._id.toString() + '?clear-cart=1',
    cancel_url: process.env.NEXTAUTH_URL + 'cart?canceled=1',
    metadata: {orderId: orderDoc._id.toString()},
    shipping_options: [{
      shipping_rate_data: {
        display_name: 'Gastos de envío',
        type: 'fixed_amount',
        fixed_amount: {amount: 500, currency: 'BOB'},
      },
    }],
  });

  return Response.json(stripeSession.url);
}
```

*Flujo de Pago:*
1. Cliente envía carrito y dirección
2. Sistema crea orden con `paid: false`
3. Se calcula precio total (base + tamaño + extras)
4. Se crea sesión de Stripe con líneas de producto
5. Cliente es redirigido a checkout seguro de Stripe
6. Webhook de Stripe actualiza `paid: true` tras pago exitoso

#pagebreak()

== E.5 Conexión a Base de Datos MongoDB

El sistema utiliza un patrón singleton para la conexión a MongoDB:

```javascript
// src/libs/mongoConnect.js
import { MongoClient } from "mongodb";

if (!process.env.MONGO_URL) {
  throw new Error('Invalid/Missing environment variable: "MONGO_URL"');
}

const uri = process.env.MONGO_URL;
const options = {};

let client;
let clientPromise;

if (process.env.NODE_ENV === "development") {
  // En desarrollo: usar variable global para preservar
  // conexión entre recargas HMR (Hot Module Replacement)
  if (!global._mongoClientPromise) {
    client = new MongoClient(uri, options);
    global._mongoClientPromise = client.connect();
  }
  clientPromise = global._mongoClientPromise;
} else {
  // En producción: nueva instancia de cliente
  client = new MongoClient(uri, options);
  clientPromise = client.connect();
}

export default clientPromise;
```

*Características:*
- Patrón singleton para reutilización de conexiones
- Manejo específico para desarrollo (HMR) vs producción
- Validación de variable de entorno

#pagebreak()

== E.6 Estructura del Proyecto

#figure(
  ```
  restaurante-bambu/
  ├── src/
  │   ├── app/                    # App Router (Next.js 14)
  │   │   ├── api/                # API Routes (Backend)
  │   │   │   ├── auth/           # Autenticación NextAuth
  │   │   │   ├── register/       # Registro de usuarios
  │   │   │   ├── profile/        # Gestión de perfil
  │   │   │   ├── categories/     # CRUD categorías
  │   │   │   ├── menu-items/     # CRUD productos
  │   │   │   ├── orders/         # Gestión de pedidos
  │   │   │   ├── checkout/       # Integración Stripe
  │   │   │   ├── webhook/        # Webhook Stripe
  │   │   │   └── upload/         # Upload a AWS S3
  │   │   ├── login/              # Página de login
  │   │   ├── register/           # Página de registro
  │   │   ├── menu/               # Catálogo público
  │   │   ├── cart/               # Carrito de compras
  │   │   └── orders/             # Historial de pedidos
  │   ├── components/             # Componentes React
  │   ├── models/                 # Modelos Mongoose
  │   └── libs/                   # Utilidades
  ├── mcp-server/                 # Servidor MCP para chatbot
  ├── public/                     # Archivos estáticos
  └── .env                        # Variables de entorno
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
    [Archivos JavaScript/JSX], [45+], [Componentes y lógica],
    [API Endpoints], [10], [Rutas de backend],
    [Modelos Mongoose], [5], [Esquemas de BD],
    [Componentes React], [25+], [UI reutilizables],
    [Líneas de código], [~3,500], [Excluyendo dependencias],
  ),
  caption: [Estadísticas del código fuente],
)
