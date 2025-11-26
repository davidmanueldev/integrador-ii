== 5.4 Pruebas de Sistema

Las pruebas de sistema validaron el comportamiento de la aplicación completa en un entorno similar a producción, cubriendo flujos de trabajo de extremo a extremo (E2E), rendimiento y seguridad.

=== Pruebas End-to-End (E2E)

Utilizando Cypress, se automatizaron los flujos críticos de usuario. A continuación se detallan los resultados del flujo principal de compra:

*Escenario: Compra de Almuerzo Completo*
1. Usuario ingresa a la landing page.
2. Navega al menú y filtra por "Platos Fuertes".
3. Agrega "Lomo Saltado" al carrito.
4. Interactúa con el chatbot para preguntar: "¿Qué bebida combina con carne?".
5. Chatbot sugiere "Vino Tinto de la Casa" (basado en MCP).
6. Usuario agrega la bebida sugerida.
7. Procede al checkout y paga con tarjeta de prueba Stripe.
8. Recibe confirmación de pedido \#ORD-9988.

*Resultado:* El flujo se completó en 1 minuto 45 segundos sin errores. La orden se registró correctamente en la base de datos y el estado del inventario se actualizó automáticamente.

=== Pruebas de Rendimiento

Se utilizó Apache JMeter para simular carga concurrente en el servidor.

- *Usuarios Concurrentes:* 500 usuarios virtuales.
- *Tiempo de Rampa:* 60 segundos.
- *Endpoint Probado:* Consulta de menú completo (operación de lectura intensiva).

*Resultados:*
- *Tiempo de Respuesta Promedio:* 245 ms.
- *Tasa de Error:* 0.2% (timeouts bajo carga máxima).
- *Throughput:* 120 peticiones/segundo.

El sistema demostró estabilidad bajo cargas superiores al tráfico esperado (estimado en 50 usuarios concurrentes pico).

=== Pruebas de Seguridad

Se realizaron escaneos de vulnerabilidades utilizando OWASP ZAP.
- *Inyección SQL/NoSQL:* No se detectaron vulnerabilidades (protección por Mongoose).
- *XSS (Cross-Site Scripting):* React escapa automáticamente el contenido, mitigando el riesgo.
- *Autenticación:* Se verificó que las rutas administrativas (`/admin/*`) rechazan peticiones sin token JWT válido con rol de administrador.
