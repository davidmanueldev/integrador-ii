== 5.1 Estrategia de Pruebas

La estrategia de pruebas adoptada para el Sistema Integral de Gestión del Restaurante Bambú sigue el modelo de la Pirámide de Testing (Cohn, 2009), priorizando una base sólida de pruebas unitarias automatizadas, seguidas por pruebas de integración y, finalmente, pruebas de sistema y aceptación.

=== Metodología y Herramientas

Se aplicó una metodología híbrida que combina TDD (Test Driven Development) para componentes críticos del backend y pruebas exploratorias para la interfaz de usuario.

*Herramientas Utilizadas:*
- *Vitest:* Framework principal para pruebas unitarias y de integración, compatible con el ecosistema de Vite y Next.js.
- *React Testing Library:* Para pruebas de componentes de interfaz de usuario, asegurando accesibilidad y usabilidad.
- *Playwright:* Para pruebas end-to-end (E2E) simulando flujos completos de usuario en el navegador.
- *Supabase CLI:* Para pruebas locales de la base de datos y funciones de autenticación.
- *k6:* Para pruebas de carga y rendimiento de la API.

=== Entornos de Prueba

Las pruebas se ejecutaron en tres entornos controlados:
1. *Desarrollo:* Pruebas unitarias ejecutadas localmente por los desarrolladores antes de cada commit, utilizando Supabase local con Docker.
2. *Staging (Pre-producción):* Entorno réplica de producción en Vercel Preview donde se ejecutan pruebas de integración y sistema con datos de prueba.
3. *Producción:* Pruebas de humo (smoke tests) y monitoreo sintético post-despliegue mediante Vercel Analytics.

=== Consideraciones Especiales para IA

Los componentes de inteligencia artificial requieren estrategias de prueba adicionales:

- *Pruebas de embeddings:* Validación de que vectores similares corresponden a platillos relacionados semánticamente.
- *Pruebas de chatbot:* Escenarios predefinidos para verificar respuestas contextuales y precisión de información.
- *Pruebas de recomendaciones:* Comparación de sugerencias con preferencias históricas conocidas.
- *Pruebas de predicción:* Validación cruzada con datos históricos para medir precisión de pronósticos.
