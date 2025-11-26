== 5.1 Estrategia de Pruebas

La estrategia de pruebas adoptada para el Sistema de Pedidos en Línea del Restaurante Bambú sigue el modelo de la Pirámide de Testing (Cohn, 2009), priorizando una base sólida de pruebas unitarias automatizadas, seguidas por pruebas de integración y, finalmente, pruebas de sistema y aceptación manuales.

=== Metodología y Herramientas

Se aplicó una metodología híbrida que combina TDD (Test Driven Development) para componentes críticos del backend y pruebas exploratorias para la interfaz de usuario.

*Herramientas Utilizadas:*
- *Jest:* Framework principal para pruebas unitarias y de integración del backend y lógica de negocio.
- *React Testing Library:* Para pruebas de componentes de interfaz de usuario, asegurando accesibilidad y usabilidad.
- *Postman/Newman:* Para la automatización de pruebas de endpoints de la API REST.
- *Cypress:* Para pruebas end-to-end (E2E) simulando flujos completos de usuario en el navegador.
- *MCP Inspector:* Herramienta específica para depurar y validar la comunicación con los servidores MCP.

=== Entornos de Prueba

Las pruebas se ejecutaron en tres entornos controlados:
1. *Desarrollo:* Pruebas unitarias ejecutadas localmente por los desarrolladores antes de cada commit.
2. *Staging (Pre-producción):* Entorno réplica de producción donde se ejecutan pruebas de integración y sistema con datos anonimizados.
3. *Producción:* Pruebas de humo (smoke tests) y monitoreo sintético post-despliegue.
