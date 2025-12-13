// Anexos del Proyecto - Sistema de Pedidos Restaurante Bambú
// Estructura según formato Lazcano

#import "../config/diagramas.typ": *

= ANEXOS

== Anexo A: Esquema de Base de Datos

La base de datos MongoDB del sistema está compuesta por 5 colecciones principales:

=== A.1 Colección `users`

Almacena la información de autenticación de los usuarios.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`_id`], [ObjectId], [PK, auto], [Identificador único],
    [`name`], [String], [required], [Nombre completo],
    [`email`], [String], [unique, required], [Correo electrónico],
    [`password`], [String], [hashed], [Contraseña (bcrypt 10 rounds)],
    [`image`], [String], [opcional], [URL de foto de perfil],
    [`createdAt`], [Date], [auto], [Fecha de creación],
    [`updatedAt`], [Date], [auto], [Última modificación],
  ),
  caption: [Esquema de la colección `users`],
)

=== A.2 Colección `userinfos`

Almacena información adicional del perfil y permisos.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e8f5e9") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`_id`], [ObjectId], [PK, auto], [Identificador único],
    [`email`], [String], [FK → users.email], [Referencia al usuario],
    [`streetAddress`], [String], [opcional], [Dirección de entrega],
    [`postalCode`], [String], [opcional], [Código postal],
    [`city`], [String], [opcional], [Ciudad],
    [`country`], [String], [opcional], [País],
    [`phone`], [String], [opcional], [Teléfono de contacto],
    [`admin`], [Boolean], [default: false], [Rol de administrador],
  ),
  caption: [Esquema de la colección `userinfos`],
)

#pagebreak()

=== A.3 Colección `categories`

Organización de productos del menú por categorías.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fff3e0") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`_id`], [ObjectId], [PK, auto], [Identificador único],
    [`name`], [String], [required, unique], [Nombre de la categoría],
    [`createdAt`], [Date], [auto], [Fecha de creación],
    [`updatedAt`], [Date], [auto], [Última modificación],
  ),
  caption: [Esquema de la colección `categories`],
)

=== A.4 Colección `menuitems`

Catálogo de productos disponibles en el menú.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fce4ec") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`_id`], [ObjectId], [PK, auto], [Identificador único],
    [`name`], [String], [required], [Nombre del producto],
    [`description`], [String], [opcional], [Descripción detallada],
    [`basePrice`], [Number], [required], [Precio base en Bs],
    [`image`], [String], [URL S3], [Imagen del producto],
    [`category`], [ObjectId], [FK → categories], [Categoría del producto],
    [`sizes`], [Array], [subdocumentos], [Tamaños disponibles],
    [`extraIngredientPrices`], [Array], [subdocumentos], [Extras opcionales],
  ),
  caption: [Esquema de la colección `menuitems`],
)

*Subdocumento `sizes`:*
```json
{ "name": "Mediano", "price": 5 }
```

*Subdocumento `extraIngredientPrices`:*
```json
{ "name": "Extra carne", "price": 8 }
```

*Cálculo de precio total:*
$ "precioTotal" = "basePrice" + "size.price" + sum("extras.price") $

#pagebreak()

=== A.5 Colección `orders`

Registro de pedidos realizados por los clientes.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e1bee7") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`_id`], [ObjectId], [PK, auto], [Identificador único],
    [`userEmail`], [String], [FK → users.email], [Email del cliente],
    [`phone`], [String], [required], [Teléfono de contacto],
    [`streetAddress`], [String], [required], [Dirección de entrega],
    [`city`], [String], [required], [Ciudad],
    [`cartProducts`], [Object], [JSON], [Productos del pedido],
    [`paid`], [Boolean], [default: false], [Estado de pago],
    [`createdAt`], [Date], [auto], [Fecha del pedido],
  ),
  caption: [Esquema de la colección `orders`],
)

#pagebreak()

== Anexo B: Documentación de API REST

El sistema expone 10 endpoints principales organizados por módulo:

=== B.1 Endpoints de Autenticación

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [POST], [`/api/register`], [Registro de nuevo usuario], [No],
    [POST], [`/api/auth/[...nextauth]`], [Login (credenciales/OAuth)], [No],
  ),
  caption: [Endpoints de Autenticación],
)

=== B.2 Endpoints de Perfil y Usuarios

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e8f5e9") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [GET], [`/api/profile`], [Obtener información del perfil], [Sí],
    [PUT], [`/api/profile`], [Actualizar perfil], [Sí],
    [GET], [`/api/users`], [Listar todos los usuarios], [Admin],
    [PUT], [`/api/users`], [Actualizar rol de usuario], [Admin],
  ),
  caption: [Endpoints de Perfil y Usuarios],
)

=== B.3 Endpoints de Categorías

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fff3e0") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [GET], [`/api/categories`], [Listar categorías], [No],
    [POST], [`/api/categories`], [Crear categoría], [Admin],
    [PUT], [`/api/categories`], [Actualizar categoría], [Admin],
    [DELETE], [`/api/categories`], [Eliminar categoría], [Admin],
  ),
  caption: [Endpoints de Categorías],
)

#pagebreak()

=== B.4 Endpoints de Productos del Menú

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fce4ec") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [GET], [`/api/menu-items`], [Listar productos], [No],
    [POST], [`/api/menu-items`], [Crear producto], [Admin],
    [PUT], [`/api/menu-items`], [Actualizar producto], [Admin],
    [DELETE], [`/api/menu-items`], [Eliminar producto], [Admin],
  ),
  caption: [Endpoints de Productos],
)

=== B.5 Endpoints de Checkout y Pedidos

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e1bee7") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [POST], [`/api/checkout`], [Crear sesión de pago Stripe], [Sí],
    [POST], [`/api/webhook`], [Webhook de confirmación Stripe], [Firma],
    [GET], [`/api/orders`], [Listar pedidos], [Sí],
  ),
  caption: [Endpoints de Checkout y Pedidos],
)

=== B.6 Endpoint de Upload

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#b2dfdb") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [POST], [`/api/upload`], [Subir imagen a AWS S3], [Sí],
  ),
  caption: [Endpoint de Upload],
)

#pagebreak()

== Anexo C: Manual de Instalación

=== C.1 Requisitos del Sistema

#figure(
  table(
    columns: (auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Componente*], [*Versión Mínima*],
    [Node.js], [v18.0.0 o superior],
    [npm / pnpm], [v8.0.0 / v7.0.0],
    [MongoDB], [v6.0 o MongoDB Atlas],
    [Git], [v2.30.0],
  ),
  caption: [Requisitos del Sistema],
)

=== C.2 Pasos de Instalación

```bash
# 1. Clonar repositorio
git clone <url-repositorio>
cd restaurante-bambu

# 2. Instalar dependencias
npm install

# 3. Configurar variables de entorno
cp .env.example .env
# Editar .env con credenciales reales

# 4. Ejecutar en desarrollo
npm run dev

# 5. Acceder al sistema
# http://localhost:3000
```

=== C.3 Variables de Entorno Requeridas

```env
# MongoDB
MONGO_URL="mongodb+srv://user:pass@cluster/db"

# NextAuth
NEXTAUTH_URL="http://localhost:3000"
SECRET="nextauth-secret-key"

# Google OAuth
GOOGLE_CLIENT_ID="google-client-id"
GOOGLE_CLIENT_SECRET="google-client-secret"

# AWS S3
MY_AWS_ACCESS_KEY="aws-access-key"
MY_AWS_SECRET_KEY="aws-secret-key"

# Stripe
STRIPE_SK="sk_test_..."
STRIPE_PK="pk_test_..."
```

#pagebreak()

== Anexo D: Datos de Prueba

=== D.1 Usuarios de Prueba

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Rol*], [*Email*], [*Contraseña*], [*Nombre*],
    [Admin], [`admin@restaurantebambu.com`], [`Admin123!`], [Administrador Test],
    [Cliente], [`cliente@example.com`], [`Cliente123!`], [Cliente Test],
  ),
  caption: [Usuarios de Prueba],
)

=== D.2 Categorías de Prueba

- Platos Principales
- Bebidas
- Postres
- Entradas

=== D.3 Producto de Ejemplo

```json
{
  "name": "Arroz Chaufa",
  "description": "Arroz frito estilo chino con pollo y verduras",
  "basePrice": 25,
  "category": "Platos Principales",
  "sizes": [
    { "name": "Pequeño", "price": 0 },
    { "name": "Mediano", "price": 5 },
    { "name": "Grande", "price": 10 }
  ],
  "extraIngredientPrices": [
    { "name": "Extra carne", "price": 8 },
    { "name": "Extra verduras", "price": 4 }
  ]
}
```

=== D.4 Tarjeta de Prueba Stripe

#figure(
  table(
    columns: (auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e1bee7") } else { white },
    [*Campo*], [*Valor*],
    [Número], [4242 4242 4242 4242],
    [Expiración], [12/25],
    [CVC], [123],
    [Código Postal], [12345],
  ),
  caption: [Tarjeta de Prueba para Stripe],
)
