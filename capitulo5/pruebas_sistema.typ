== 5.4 Pruebas de Sistema

Las pruebas de sistema validaron el comportamiento de la aplicación completa en un entorno similar a producción, cubriendo flujos de trabajo de extremo a extremo (E2E), rendimiento y seguridad.

=== Pruebas End-to-End (E2E)

Utilizando Playwright, se automatizaron los flujos críticos de usuario. A continuación se detallan los resultados de los flujos principales:

*Escenario 1: Reservación de Mesa*
1. Cliente ingresa a la página de reservaciones.
2. Selecciona fecha (sábado próximo) y hora (20:00).
3. Indica 4 comensales y solicita mesa cerca de la ventana.
4. Sistema muestra disponibilidad y permite confirmar.
5. Cliente completa datos de contacto y confirma reservación.
6. Sistema envía email de confirmación vía Resend.

*Resultado:* Flujo completado en 45 segundos. Email recibido correctamente. Reservación visible en panel administrativo.

*Escenario 2: Pedido Presencial con POS*
1. Mesero selecciona mesa 5 en el sistema POS.
2. Agrega "Lomo Saltado" y consulta al chatbot: "¿Qué bebida recomiendas con carne?".
3. Chatbot sugiere "Vino Tinto de la Casa" basado en búsqueda semántica de maridajes.
4. Mesero agrega la bebida sugerida al pedido.
5. Envía pedido a cocina, estado cambia a "En preparación".
6. Cocina marca pedido como "Listo para servir".
7. Mesero cierra la cuenta y procesa pago con QR Simple.

*Resultado:* Flujo completado en 2 minutos 15 segundos. Estados actualizados en tiempo real. Pago registrado correctamente.

*Escenario 3: Panel Administrativo*
1. Administrador ingresa con credenciales válidas.
2. Accede al dashboard con métricas del día.
3. Revisa predicción de demanda para el fin de semana.
4. Consulta análisis de sentimiento de reseñas recientes.
5. Genera reporte de ventas del mes.

*Resultado:* Dashboard carga en 1.2 segundos. Predicciones y análisis de sentimiento disponibles. Reporte exportado en formato PDF.

=== Pruebas de Rendimiento

Se utilizó k6 para simular carga concurrente en el servidor.

- *Usuarios Concurrentes:* 200 usuarios virtuales.
- *Tiempo de Rampa:* 60 segundos.
- *Endpoints Probados:* Consulta de menú, búsqueda semántica, creación de pedidos.

*Resultados:*
- *Tiempo de Respuesta Promedio:* 180 ms (API REST), 320 ms (búsqueda semántica).
- *Tasa de Error:* 0.1% (timeouts esporádicos en búsqueda vectorial bajo carga extrema).
- *Throughput:* 150 peticiones/segundo.
- *P95 Latency:* 450 ms.

El sistema demostró estabilidad bajo cargas superiores al tráfico esperado (estimado en 30 usuarios concurrentes en hora pico).

=== Pruebas de Seguridad

Se realizaron escaneos de vulnerabilidades utilizando OWASP ZAP y análisis manual.

- *Inyección SQL:* No se detectaron vulnerabilidades. Prisma utiliza prepared statements por defecto.
- *XSS (Cross-Site Scripting):* React escapa automáticamente el contenido. No se encontraron vectores de ataque.
- *Autenticación:* Las rutas administrativas (`/admin/*`) rechazan peticiones sin token JWT válido de Supabase Auth.
- *Row Level Security:* Verificado que usuarios no pueden acceder a datos de otros usuarios mediante manipulación de requests.
- *Datos Sensibles:* Las claves de API (OpenAI, Red Enlace) están correctamente almacenadas en variables de entorno y no se exponen al cliente.
