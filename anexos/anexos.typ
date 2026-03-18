// Anexos del Proyecto - Sistema Integral de Gestión Restaurante Bambú
// Estructura según formato Lazcano

#import "../config/diagramas.typ": *

= ANEXOS

== Anexo A: Esquema de Base de Datos

La base de datos PostgreSQL (Supabase) del sistema está compuesta por las siguientes tablas principales:

=== A.1 Tabla `users`

Almacena la información de autenticación de los usuarios (gestionada por Supabase Auth).

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`id`], [UUID], [PK, auto], [Identificador único],
    [`email`], [VARCHAR], [unique, not null], [Correo electrónico],
    [`nombre`], [VARCHAR], [not null], [Nombre completo],
    [`rol`], [ENUM], [default: 'cliente'], [cliente/mesero/admin],
    [`telefono`], [VARCHAR], [opcional], [Teléfono de contacto],
    [`created_at`], [TIMESTAMPTZ], [auto], [Fecha de creación],
    [`updated_at`], [TIMESTAMPTZ], [auto], [Última modificación],
  ),
  caption: [Esquema de la tabla `users`],
)

=== A.2 Tabla `mesas`

Almacena la configuración de las mesas del restaurante.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e8f5e9") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`id`], [UUID], [PK, auto], [Identificador único],
    [`numero`], [INTEGER], [unique, not null], [Número de mesa],
    [`capacidad`], [INTEGER], [not null], [Capacidad de personas],
    [`ubicacion`], [VARCHAR], [opcional], [Interior/Terraza/VIP],
    [`estado`], [ENUM], [default: 'disponible'], [disponible/ocupada/reservada],
    [`activa`], [BOOLEAN], [default: true], [Mesa habilitada],
  ),
  caption: [Esquema de la tabla `mesas`],
)

#pagebreak()

=== A.3 Tabla `categorias`

Organización de productos del menú por categorías.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fff3e0") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`id`], [UUID], [PK, auto], [Identificador único],
    [`nombre`], [VARCHAR], [not null, unique], [Nombre de la categoría],
    [`descripcion`], [TEXT], [opcional], [Descripción de la categoría],
    [`orden`], [INTEGER], [default: 0], [Orden de visualización],
    [`activa`], [BOOLEAN], [default: true], [Categoría visible],
  ),
  caption: [Esquema de la tabla `categorias`],
)

=== A.4 Tabla `productos`

Catálogo de productos disponibles en el menú.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fce4ec") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`id`], [UUID], [PK, auto], [Identificador único],
    [`nombre`], [VARCHAR], [not null], [Nombre del producto],
    [`descripcion`], [TEXT], [opcional], [Descripción detallada],
    [`precio`], [DECIMAL(10,2)], [not null], [Precio en Bs],
    [`imagen_url`], [VARCHAR], [URL Storage], [Imagen del producto],
    [`categoria_id`], [UUID], [FK → categorias], [Categoría del producto],
    [`disponible`], [BOOLEAN], [default: true], [Disponibilidad],
    [`tiempo_preparacion`], [INTEGER], [minutos], [Tiempo estimado],
    [`embedding`], [VECTOR(1536)], [pgvector], [Embedding para IA],
  ),
  caption: [Esquema de la tabla `productos`],
)

*Cálculo de embedding:*
El campo `embedding` almacena el vector de 1536 dimensiones generado por OpenAI `text-embedding-3-small` para búsquedas semánticas.

#pagebreak()

=== A.5 Tabla `reservaciones`

Registro de reservaciones de mesas.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#c8e6c9") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`id`], [UUID], [PK, auto], [Identificador único],
    [`user_id`], [UUID], [FK → users], [Cliente que reserva],
    [`mesa_id`], [UUID], [FK → mesas], [Mesa reservada],
    [`fecha`], [DATE], [not null], [Fecha de reservación],
    [`hora`], [TIME], [not null], [Hora de reservación],
    [`personas`], [INTEGER], [not null], [Número de personas],
    [`estado`], [ENUM], [default: 'pendiente'], [pendiente/confirmada/cancelada/completada],
    [`notas`], [TEXT], [opcional], [Notas especiales],
    [`created_at`], [TIMESTAMPTZ], [auto], [Fecha de creación],
  ),
  caption: [Esquema de la tabla `reservaciones`],
)

=== A.6 Tabla `pedidos`

Registro de pedidos presenciales del restaurante.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e1bee7") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`id`], [UUID], [PK, auto], [Identificador único],
    [`mesa_id`], [UUID], [FK → mesas], [Mesa del pedido],
    [`mesero_id`], [UUID], [FK → users], [Mesero que atiende],
    [`total`], [DECIMAL(10,2)], [not null], [Total del pedido],
    [`estado`], [ENUM], [default: 'pendiente'], [pendiente/preparacion/listo/entregado/pagado],
    [`metodo_pago`], [ENUM], [nullable], [tarjeta/qr/efectivo],
    [`pagado`], [BOOLEAN], [default: false], [Estado de pago],
    [`created_at`], [TIMESTAMPTZ], [auto], [Fecha del pedido],
  ),
  caption: [Esquema de la tabla `pedidos`],
)

#pagebreak()

=== A.7 Tabla `pedido_items`

Detalle de productos en cada pedido.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#b2dfdb") } else { white },
    [*Campo*], [*Tipo*], [*Restricciones*], [*Descripción*],
    [`id`], [UUID], [PK, auto], [Identificador único],
    [`pedido_id`], [UUID], [FK → pedidos], [Pedido padre],
    [`producto_id`], [UUID], [FK → productos], [Producto ordenado],
    [`cantidad`], [INTEGER], [not null], [Cantidad solicitada],
    [`precio_unitario`], [DECIMAL(10,2)], [not null], [Precio al momento],
    [`notas`], [TEXT], [opcional], [Instrucciones especiales],
  ),
  caption: [Esquema de la tabla `pedido_items`],
)

#pagebreak()

== Anexo B: Documentación de API REST

El sistema expone endpoints organizados por módulo:

=== B.1 Endpoints de Autenticación (Supabase Auth)

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [POST], [`/auth/signup`], [Registro de nuevo usuario], [No],
    [POST], [`/auth/signin`], [Login con email/password], [No],
    [POST], [`/auth/signout`], [Cerrar sesión], [Sí],
    [GET], [`/auth/user`], [Obtener usuario actual], [Sí],
  ),
  caption: [Endpoints de Autenticación (Supabase)],
)

=== B.2 Endpoints de Reservaciones

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#c8e6c9") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [GET], [`/api/reservaciones`], [Listar reservaciones], [Sí],
    [POST], [`/api/reservaciones`], [Crear reservación], [Sí],
    [PUT], [`/api/reservaciones/[id]`], [Actualizar reservación], [Sí],
    [DELETE], [`/api/reservaciones/[id]`], [Cancelar reservación], [Sí],
    [GET], [`/api/mesas/disponibles`], [Mesas disponibles por fecha], [No],
  ),
  caption: [Endpoints de Reservaciones],
)

=== B.3 Endpoints de Productos y Categorías

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fff3e0") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [GET], [`/api/categorias`], [Listar categorías], [No],
    [POST], [`/api/categorias`], [Crear categoría], [Admin],
    [GET], [`/api/productos`], [Listar productos], [No],
    [POST], [`/api/productos`], [Crear producto], [Admin],
    [PUT], [`/api/productos/[id]`], [Actualizar producto], [Admin],
    [DELETE], [`/api/productos/[id]`], [Eliminar producto], [Admin],
  ),
  caption: [Endpoints de Productos],
)

#pagebreak()

=== B.4 Endpoints de Pedidos (POS)

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e1bee7") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [GET], [`/api/pedidos`], [Listar pedidos activos], [Mesero/Admin],
    [POST], [`/api/pedidos`], [Crear pedido], [Mesero],
    [PUT], [`/api/pedidos/[id]`], [Actualizar estado], [Mesero/Admin],
    [POST], [`/api/pedidos/[id]/items`], [Agregar items], [Mesero],
    [DELETE], [`/api/pedidos/[id]/items/[itemId]`], [Quitar item], [Mesero],
  ),
  caption: [Endpoints de Pedidos],
)

=== B.5 Endpoints de Pagos

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#f3e5f5") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [POST], [`/api/pagos/tarjeta`], [Procesar pago Red Enlace], [Mesero],
    [POST], [`/api/pagos/qr`], [Generar QR Simple], [Mesero],
    [POST], [`/api/pagos/efectivo`], [Registrar pago efectivo], [Mesero],
    [POST], [`/api/pagos/webhook`], [Webhook Red Enlace], [Firma],
  ),
  caption: [Endpoints de Pagos],
)

=== B.6 Endpoints de IA

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#b2dfdb") } else { white },
    [*Método*], [*Endpoint*], [*Descripción*], [*Auth*],
    [POST], [`/api/chat`], [Chatbot con RAG], [No],
    [GET], [`/api/recomendaciones`], [Recomendaciones personalizadas], [Sí],
    [GET], [`/api/prediccion/demanda`], [Predicción de demanda], [Admin],
  ),
  caption: [Endpoints de IA],
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
    [npm / pnpm], [v8.0.0 / v8.0.0],
    [Cuenta Supabase], [Plan Free o superior],
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
cp .env.example .env.local
# Editar .env.local con credenciales reales

# 4. Generar cliente Prisma
npx prisma generate

# 5. Aplicar migraciones a Supabase
npx prisma db push

# 6. Ejecutar en desarrollo
npm run dev

# 7. Acceder al sistema
# http://localhost:3000
```

=== C.3 Variables de Entorno Requeridas

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL="https://xxx.supabase.co"
NEXT_PUBLIC_SUPABASE_ANON_KEY="eyJ..."
SUPABASE_SERVICE_ROLE_KEY="eyJ..."

# Base de datos (Prisma)
DATABASE_URL="postgresql://postgres:pass@db.xxx.supabase.co:5432/postgres"

# Red Enlace / CyberSource
CYBERSOURCE_MERCHANT_ID="bambu_rest"
CYBERSOURCE_KEY_ID="key-id"
CYBERSOURCE_SECRET_KEY="secret-key"

# QR Simple
QR_SIMPLE_COMERCIO_ID="comercio-id"
QR_SIMPLE_API_KEY="api-key"

# OpenAI (para embeddings y chatbot)
OPENAI_API_KEY="sk-..."

# Resend (emails)
RESEND_API_KEY="re_..."
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
    [Admin], [`admin@restaurantebambu.com`], [`Admin123!`], [Administrador],
    [Mesero], [`mesero@restaurantebambu.com`], [`Mesero123!`], [Carlos Mamani],
    [Cliente], [`cliente@example.com`], [`Cliente123!`], [María López],
  ),
  caption: [Usuarios de Prueba],
)

=== D.2 Mesas de Prueba

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e8f5e9") } else { white },
    [*Número*], [*Capacidad*], [*Ubicación*], [*Estado*],
    [1], [2], [Interior], [Disponible],
    [2], [4], [Interior], [Disponible],
    [3], [4], [Interior], [Disponible],
    [4], [6], [Terraza], [Disponible],
    [5], [8], [VIP], [Disponible],
  ),
  caption: [Mesas de Prueba],
)

=== D.3 Categorías de Prueba

- Platos Principales
- Bebidas
- Postres
- Entradas

=== D.4 Producto de Ejemplo

```json
{
  "nombre": "Arroz Chaufa",
  "descripcion": "Arroz frito estilo chino con pollo y verduras",
  "precio": 25.00,
  "categoria_id": "uuid-platos-principales",
  "disponible": true,
  "tiempo_preparacion": 15
}
```

=== D.5 Datos de Prueba para Pagos

*Tarjeta de Prueba (Red Enlace/CyberSource):*
#figure(
  table(
    columns: (auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e1bee7") } else { white },
    [*Campo*], [*Valor*],
    [Número], [4111 1111 1111 1111],
    [Expiración], [12/25],
    [CVV], [123],
  ),
  caption: [Tarjeta de Prueba para Red Enlace],
)

*Nota:* Los datos de prueba de QR Simple se obtienen del portal de desarrolladores.
