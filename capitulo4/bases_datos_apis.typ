== 4.4 Bases de Datos y APIs

=== 4.4.1 Diseño de Base de Datos NoSQL

El modelo de datos se implementa en MongoDB utilizando colecciones diseñadas para eficiencia y escalabilidad:

- *Productos:* Almacena detalles del menú, incluyendo precio, descripción, categoría, imagen y estado de disponibilidad.
- *Usuarios:* Gestiona perfiles de clientes y administradores, con información de autenticación y preferencias.
- *Pedidos:* Registra transacciones completas, incluyendo lista de items, totales, estado del pago y estado de preparación.
- *Categorías:* Estructura jerárquica para organizar el menú.

=== 4.4.2 Diseño de API REST

La comunicación entre el frontend y el backend se realiza a través de una API RESTful que sigue las mejores prácticas de diseño:

- *Endpoints Claros:* Uso de sustantivos y verbos HTTP estándar (e.g., `GET /api/productos`, `POST /api/pedidos`).
- *Códigos de Estado:* Respuestas HTTP semánticas (200 OK, 201 Created, 400 Bad Request, 401 Unauthorized).
- *Seguridad:* Validación de tokens de sesión en cada petición protegida y sanitización de entradas para prevenir inyecciones.
- *Paginación y Filtrado:* Optimización de respuestas para listas extensas de productos o pedidos.
