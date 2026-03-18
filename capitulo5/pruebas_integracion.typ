== 5.3 Pruebas de Integración

Las pruebas de integración verificaron la comunicación correcta entre los diferentes módulos del sistema, con especial énfasis en la interacción entre el frontend, las API Routes de Next.js, la base de datos PostgreSQL (Supabase) y los servicios externos (Red Enlace, OpenAI).

=== Integración API REST y Base de Datos

Se realizaron pruebas automatizadas para validar los endpoints de la API. Se ejecutaron 52 casos de prueba de integración, obteniendo un 100% de éxito tras la corrección de 4 defectos iniciales relacionados con validación de esquemas Zod y políticas RLS.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [*Endpoint*], [*Método*], [*Prueba*], [*Resultado*],
    [/api/products], [GET], [Recuperar lista paginada], [EXITOSO],
    [/api/orders], [POST], [Crear pedido presencial], [EXITOSO],
    [/api/reservations], [POST], [Crear reservación], [EXITOSO],
    [/api/chat], [POST], [Consulta al chatbot con RAG], [EXITOSO],
    [/api/recommendations], [GET], [Obtener recomendaciones], [EXITOSO],
  ),
  caption: [Muestra de Pruebas de Integración de API],
)

=== Integración con Supabase Auth

Se validó el flujo completo de autenticación:

*Caso de Prueba PI-AUTH-01:*
- *Entrada:* Registro de nuevo usuario con email y contraseña.
- *Comportamiento Esperado:* Creación de usuario en Supabase Auth, envío de email de confirmación, creación de perfil en tabla `users`.
- *Resultado Observado:* Usuario creado correctamente, email recibido en menos de 10 segundos, perfil sincronizado mediante trigger de PostgreSQL.
- *Estado:* APROBADO.

=== Integración con Búsqueda Semántica (pgvector)

Se validó la funcionalidad de búsqueda por embeddings:

*Caso de Prueba PI-VECTOR-01:*
- *Entrada:* Consulta "algo con pollo que no sea muy picante".
- *Comportamiento Esperado:* El sistema genera embedding de la consulta, busca los 5 platillos más similares, filtra por nivel de picante.
- *Resultado Observado:* Retornó correctamente "Pollo a la Plancha", "Milanesa de Pollo" y "Fricasé de Pollo" con scores de similitud > 0.75.
- *Estado:* APROBADO.

=== Integración con Pasarela de Pagos

Se realizaron pruebas con el ambiente de sandbox de Red Enlace CyberSource:

*Caso de Prueba PI-PAGO-01:*
- *Entrada:* Pago con tarjeta de prueba VISA (4111111111111111).
- *Comportamiento Esperado:* Transacción procesada, respuesta con código de autorización, registro en tabla `payments`.
- *Resultado Observado:* Transacción aprobada en 1.8 segundos, código de autorización recibido, pago registrado con referencia CyberSource.
- *Estado:* APROBADO.

*Caso de Prueba PI-QR-01:*
- *Entrada:* Generación de código QR Simple para pago de Bs. 150.
- *Comportamiento Esperado:* Generación de QR válido, verificación de pago mediante polling.
- *Resultado Observado:* QR generado correctamente, pago simulado detectado en la siguiente consulta de estado.
- *Estado:* APROBADO.
