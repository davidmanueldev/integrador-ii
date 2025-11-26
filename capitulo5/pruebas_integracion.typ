== 5.3 Pruebas de Integración

Las pruebas de integración verificaron la comunicación correcta entre los diferentes módulos del sistema, con especial énfasis en la interacción entre el frontend, la API REST, la base de datos MongoDB y los servidores MCP.

=== Integración API REST y Base de Datos

Se realizaron pruebas automatizadas utilizando Supertest para validar los endpoints de la API. Se ejecutaron 45 casos de prueba de integración, obteniendo un 100% de éxito tras la corrección de 3 defectos iniciales relacionados con la validación de esquemas Mongoose.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [*Endpoint*], [*Método*], [*Prueba*], [*Resultado*],
    [/api/productos], [GET], [Recuperar lista paginada], [EXITOSO],
    [/api/pedidos], [POST], [Crear pedido con stock], [EXITOSO],
    [/api/auth/login], [POST], [Login credenciales válidas], [EXITOSO],
    [/api/mcps/query], [POST], [Consulta a MCP Menú], [EXITOSO],
  ),
  caption: [Muestra de Pruebas de Integración de API],
)

=== Integración con Servidores MCP

Un componente crítico fue la validación de la comunicación entre el Chatbot y los servidores MCP. Se simularon consultas complejas para verificar que el orquestador seleccionara la herramienta correcta.

*Caso de Prueba PI-MCP-05:*
- *Entrada:* "¿Tienen opciones vegetarianas disponibles hoy?"
- *Comportamiento Esperado:* El sistema debe invocar la herramienta `consultar_menu` con el filtro `categoria: vegetariano` y `disponible: true`.
- *Resultado Observado:* El servidor MCP recibió la petición correcta y retornó 3 items (Ensalada César, Pasta Primavera, Pizza Margarita). El chatbot formuló una respuesta natural listando estas opciones.
- *Estado:* APROBADO.
