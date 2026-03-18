== 2.2 Conceptos Fundamentales

=== 2.2.1 Sistemas de Información

Un sistema de información es un conjunto integrado de componentes para recopilar, almacenar, procesar y distribuir información con el propósito de facilitar la planificación, el control, la coordinación, el análisis y la toma de decisiones en una organización (Laudon & Laudon, 2012). Los sistemas de información modernos típicamente constan de:

- *Hardware*: Infraestructura física que soporta el sistema (servidores, dispositivos de almacenamiento, redes)
- *Software*: Programas y aplicaciones que procesan datos y proveen funcionalidad
- *Datos*: Información almacenada y procesada por el sistema
- *Procedimientos*: Reglas y políticas que gobiernan el uso del sistema
- *Personas*: Usuarios y administradores que interactúan con el sistema

En el contexto de este proyecto, el Sistema Integral de Gestión constituye un sistema de información que automatiza múltiples procesos operativos del restaurante: reservaciones, toma de pedidos, control de caja, pagos y análisis de datos.

=== 2.2.2 Arquitectura Cliente-Servidor

La arquitectura cliente-servidor es un modelo de diseño de software distribuido donde las tareas se dividen entre proveedores de recursos o servicios (servidores) y solicitantes de servicios (clientes) (Pressman & Maxim, 2020).

=== Características Principales

*Separación de Responsabilidades*
- El cliente maneja la interfaz de usuario y la presentación de datos
- El servidor gestiona la lógica de negocio, procesamiento de datos y almacenamiento
- Esta separación permite desarrollo, testing y escalamiento independientes

*Comunicación mediante Protocolos*
- Cliente y servidor se comunican a través de protocolos estandarizados (HTTP/HTTPS)
- Las solicitudes del cliente se envían al servidor, que procesa y retorna respuestas
- La comunicación es típicamente stateless (sin estado persistente entre solicitudes)

*Escalabilidad*
- Múltiples clientes pueden conectarse simultáneamente a un servidor
- Los servidores pueden distribuirse horizontalmente para manejar mayor carga
- Caching y balanceo de carga optimizan el rendimiento del sistema

=== Aplicación en el Proyecto

El sistema implementa una arquitectura cliente-servidor moderna:
- *Cliente*: Aplicación Next.js/React ejecutándose en navegadores web
- *Servidor*: API Routes de Next.js (serverless functions) y Supabase
- *Base de datos*: PostgreSQL gestionado por Supabase con extensiones (pgvector)

=== 2.2.3 Aplicaciones Web Modernas

Las aplicaciones web han evolucionado desde páginas estáticas renderizadas exclusivamente en el servidor hacia aplicaciones dinámicas e interactivas que combinan renderizado en servidor (SSR), generación estática (SSG) y renderizado en el cliente (CSR).

=== Single Page Applications (SPA)

Las SPAs son aplicaciones web que cargan una única página HTML y dinámicamente actualizan el contenido conforme el usuario interactúa con la aplicación, sin recargar la página completa. Ventajas incluyen:

- Experiencia de usuario fluida y rápida
- Menor consumo de ancho de banda (solo se transmiten datos, no HTML completo)
- Interfaz de usuario reactiva similar a aplicaciones nativas

=== Server-Side Rendering (SSR)

El renderizado del lado del servidor genera HTML dinámicamente en el servidor antes de enviarlo al cliente. Beneficios:

- Mejor optimización para motores de búsqueda (SEO)
- Tiempo de carga inicial más rápido
- Contenido visible incluso con JavaScript deshabilitado

=== Enfoque Híbrido: Next.js

Next.js combina lo mejor de ambos mundos, permitiendo elegir la estrategia de renderizado apropiada para cada página:

- Generación estática para contenido que no cambia frecuentemente
- SSR para contenido dinámico que requiere optimización SEO
- Renderizado en cliente para interacciones altamente dinámicas

=== 2.2.4 APIs RESTful

REST (Representational State Transfer) es un estilo arquitectónico para diseñar servicios web que utilizan HTTP como protocolo de comunicación. Una API RESTful expone recursos (datos u objetos) mediante URLs y permite operaciones sobre ellos usando métodos HTTP estándar.

=== Principios REST

*Recursos Identificables*
- Cada recurso tiene una URL única (ej: `/api/products/123`)
- Los recursos se representan típicamente en formato JSON

*Métodos HTTP Estándar*
- `GET`: Recuperar un recurso o colección
- `POST`: Crear un nuevo recurso
- `PUT/PATCH`: Actualizar un recurso existente
- `DELETE`: Eliminar un recurso

*Stateless (Sin Estado)*
- Cada solicitud contiene toda la información necesaria para procesarla
- El servidor no mantiene estado de sesión entre solicitudes
- La autenticación se maneja mediante tokens (JWT)

*Respuestas con Códigos de Estado HTTP*
- `200 OK`: Solicitud exitosa
- `201 Created`: Recurso creado exitosamente
- `400 Bad Request`: Solicitud malformada
- `401 Unauthorized`: Autenticación requerida
- `404 Not Found`: Recurso no encontrado
- `500 Internal Server Error`: Error del servidor

=== Ejemplo en el Proyecto

El sistema implementa endpoints RESTful para gestión de recursos:

```
GET    /api/products           # Listar todos los productos
GET    /api/products/:id       # Obtener un producto específico
POST   /api/products           # Crear nuevo producto
PUT    /api/products/:id       # Actualizar producto
DELETE /api/products/:id       # Eliminar producto

GET    /api/reservations       # Listar reservaciones
POST   /api/reservations       # Crear nueva reservación
GET    /api/reservations/availability  # Consultar disponibilidad

POST   /api/orders             # Crear nuevo pedido
PATCH  /api/orders/:id/status  # Actualizar estado del pedido
```

== Bases de Datos Relacionales

Las bases de datos relacionales organizan datos en tablas con filas y columnas, donde las relaciones entre tablas se establecen mediante claves primarias y foráneas. PostgreSQL, utilizado en este proyecto a través de Supabase, es una de las bases de datos relacionales más avanzadas y de código abierto.

=== Características de PostgreSQL

*Modelo Relacional con Extensiones*
- Datos organizados en tablas normalizadas
- Soporte completo para transacciones ACID
- Extensiones para funcionalidades avanzadas (pgvector, PostGIS)

*Integridad Referencial*
- Claves foráneas garantizan consistencia entre tablas
- Restricciones (constraints) previenen datos inválidos
- Triggers para lógica de negocio en base de datos

*Consultas Avanzadas*
- SQL estándar con extensiones PostgreSQL
- CTEs (Common Table Expressions) para consultas complejas
- Window functions para análisis de datos

=== Ventajas sobre Bases NoSQL para este Proyecto

| Aspecto | PostgreSQL (Relacional) | NoSQL (Documentos) |
|---------|-------------------------|-------------------|
| Integridad de datos | ACID completo | Eventual consistency |
| Relaciones complejas | Joins eficientes | Denormalización requerida |
| Transacciones | Soporte completo | Limitado |
| Extensiones IA | pgvector nativo | Requiere servicios externos |

=== Justificación para el Proyecto

PostgreSQL con Supabase es apropiado porque:

- Las transacciones de pago requieren consistencia ACID
- Las relaciones entre reservaciones, mesas, pedidos y pagos son complejas
- pgvector permite almacenar embeddings directamente en la base de datos
- Row Level Security (RLS) proporciona seguridad granular
- Supabase ofrece autenticación y APIs automáticas integradas

== Autenticación y Autorización

La seguridad es fundamental en sistemas web que manejan información sensible de usuarios y transacciones financieras.

=== Autenticación

La autenticación verifica la identidad del usuario. Supabase Auth proporciona:

- *Credenciales*: Email/contraseña con hash bcrypt
- *OAuth*: Autenticación delegada mediante Google, Facebook, etc.
- *Magic Links*: Acceso mediante enlace enviado por email
- *Multi-factor*: Verificación adicional para mayor seguridad

=== Autorización

La autorización determina qué acciones puede realizar un usuario autenticado. Se implementa mediante:

- *Roles*: Conjuntos de permisos asignados a usuarios (Cliente, Mesero, Administrador)
- *Row Level Security (RLS)*: Políticas en PostgreSQL que controlan acceso a nivel de fila
- *Middleware*: Verificación de permisos en API Routes antes de ejecutar operaciones

=== JSON Web Tokens (JWT)

JWT es un estándar abierto para transmitir información de forma segura entre partes como un objeto JSON. Estructura:

```
Header.Payload.Signature
```

*Header*: Tipo de token y algoritmo de firma
*Payload*: Datos del usuario (id, rol, expiración)
*Signature*: Firma digital para verificar autenticidad

Ventajas de JWT:
- Stateless: No requiere almacenar sesiones en el servidor
- Escalable: Funciona eficientemente con múltiples servidores
- Estándar: Compatible con múltiples lenguajes y frameworks

Este conjunto de conceptos fundamentales establece la base técnica necesaria para comprender las decisiones arquitectónicas y de implementación del Sistema Integral de Gestión, que serán desarrolladas en las siguientes secciones del marco teórico.
