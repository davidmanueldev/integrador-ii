== 2.2 Conceptos Fundamentales

=== 2.2.1 Sistemas de Información

Un sistema de información es un conjunto integrado de componentes para recopilar, almacenar, procesar y distribuir información con el propósito de facilitar la planificación, el control, la coordinación, el análisis y la toma de decisiones en una organización (Laudon & Laudon, 2012). Los sistemas de información modernos típicamente constan de:

- *Hardware*: Infraestructura física que soporta el sistema (servidores, dispositivos de almacenamiento, redes)
- *Software*: Programas y aplicaciones que procesan datos y proveen funcionalidad
- *Datos*: Información almacenada y procesada por el sistema
- *Procedimientos*: Reglas y políticas que gobiernan el uso del sistema
- *Personas*: Usuarios y administradores que interactúan con el sistema

En el contexto de este proyecto, el Sistema de Pedidos en Línea constituye un sistema de información transaccional que automatiza el proceso de venta del restaurante, reemplazando métodos manuales con flujos digitales eficientes.

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
- *Servidor*: API Routes de Next.js (serverless functions) procesando lógica de negocio
- *Base de datos*: MongoDB actuando como capa de persistencia de datos

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
- Cada recurso tiene una URL única (ej: `/api/productos/123`)
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

El sistema implementa endpoints RESTful para gestión de productos:

```
GET    /api/productos          # Listar todos los productos
GET    /api/productos/:id      # Obtener un producto específico
POST   /api/productos          # Crear nuevo producto
PUT    /api/productos/:id      # Actualizar producto
DELETE /api/productos/:id      # Eliminar producto
```

== Bases de Datos NoSQL

Las bases de datos NoSQL (Not Only SQL) son sistemas de gestión de datos que no utilizan el modelo relacional tradicional. MongoDB, la base de datos utilizada en este proyecto, es una base de datos orientada a documentos.

=== Características de MongoDB

*Modelo de Documentos*
- Datos almacenados como documentos JSON/BSON
- Estructura flexible sin esquema rígido predefinido
- Documentos pueden tener campos diferentes dentro de la misma colección

*Escalabilidad Horizontal*
- Diseñado para distribuirse en múltiples servidores (sharding)
- Replicación automática para alta disponibilidad
- Manejo eficiente de grandes volúmenes de datos

*Consultas Flexibles*
- Lenguaje de consulta expresivo con soporte para filtros complejos
- Índices para optimización de rendimiento
- Agregaciones para análisis de datos

=== Comparación: SQL vs NoSQL

| Aspecto | SQL (Relacional) | NoSQL (Documentos) |
|---------|------------------|-------------------|
| Esquema | Rígido, definido previamente | Flexible, dinámico |
| Escalabilidad | Vertical (más recursos) | Horizontal (más servidores) |
| Relaciones | Joins entre tablas | Documentos anidados o referencias |
| Casos de uso | Transacciones complejas, datos estructurados | Datos semi-estructurados, alta escalabilidad |

=== Justificación para el Proyecto

MongoDB es apropiado para este sistema porque:

- El modelo de productos puede variar (diferentes campos según categoría)
- Los pedidos contienen arreglos de productos con cantidades variables
- Requerimientos de escalabilidad para crecimiento futuro
- Integración nativa con JavaScript mediante Mongoose ODM

== Autenticación y Autorización

La seguridad es fundamental en sistemas web que manejan información sensible de usuarios y transacciones financieras.

=== Autenticación

La autenticación verifica la identidad del usuario. Métodos comunes incluyen:

- *Credenciales*: Usuario/contraseña (hasheadas con bcrypt)
- *OAuth*: Autenticación delegada mediante servicios externos (Google, Facebook)
- *Multi-factor*: Combinación de múltiples métodos de verificación

=== Autorización

La autorización determina qué acciones puede realizar un usuario autenticado. Se implementa mediante:

- *Roles*: Conjuntos de permisos asignados a usuarios (Cliente, Administrador)
- *Políticas de acceso*: Reglas que definen acceso a recursos específicos
- *Middleware*: Componentes de software que verifican permisos antes de ejecutar operaciones

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

Este conjunto de conceptos fundamentales establece la base técnica necesaria para comprender las decisiones arquitectónicas y de implementación del Sistema de Pedidos en Línea, que serán desarrolladas en las siguientes secciones del marco teórico.
