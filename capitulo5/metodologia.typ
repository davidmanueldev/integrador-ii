// Portada del Capítulo V
#set page(numbering: none)
#place(top, hide[= CAPÍTULO V: DISEÑO METODOLÓGICO])
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO V: \
    DISEÑO METODOLÓGICO
  ]
]

#pagebreak()
#set page(numbering: "1", number-align: right + top)


== 5.1 Enfoque de Investigación

El presente proyecto adopta un enfoque de investigación aplicada, orientado a la resolución de problemas prácticos mediante el desarrollo de un Sistema Integral de Gestión para el Restaurante Bambú. El enfoque es predominantemente cuantitativo, utilizando métricas de rendimiento, usabilidad y calidad para evaluar la efectividad de la solución propuesta, complementado con elementos cualitativos derivados del análisis de sentimiento y la satisfacción del usuario.

== 5.2 Tipo de Investigación

Este proyecto se clasifica como investigación aplicada y tecnológica, ya que se centra en la creación de una solución concreta utilizando tecnologías web modernas, bases de datos PostgreSQL con capacidades vectoriales, y técnicas de inteligencia artificial. El objetivo es generar un producto funcional que resuelva necesidades identificadas en la gestión operativa de restaurantes en el contexto boliviano.

== 5.3 Diseño de la Investigación

El diseño de investigación adopta la metodología ágil *AUP (Agile Unified Process)*, un marco de trabajo iterativo e incremental que simplifica el Proceso Unificado, ideal para desarrollos ágiles e individuales. Asimismo, la ejecución técnica se guio por un enfoque *FDD (Feature-Driven Development)* o Desarrollo Basado en Funcionalidades, permitiendo construir, probar y entregar cada módulo del sistema de manera independiente.

El ciclo de vida del proyecto se estructuró en las cuatro fases de AUP:

- *Fase 1 - Incepción:* Identificación de requisitos funcionales y no funcionales, estudio del contexto regulatorio boliviano (Red Enlace, ASFI) y análisis de viabilidad técnica del sistema.
- *Fase 2 - Elaboración:* Definición de la arquitectura del sistema, modelado de datos relacional (Prisma), diseño de interfaces de usuario y especificación de los componentes de Inteligencia Artificial.
- *Fase 3 - Construcción:* Desarrollo iterativo guiado por funcionalidades (FDD). Implementación de módulos independientes (reservaciones, POS, pagos, chatbot, recomendaciones) y ejecución de pruebas unitarias y de integración continuas.
- *Fase 4 - Transición:* Despliegue del sistema en entorno de producción (Vercel), validación con usuarios finales, pruebas de aceptación (E2E) y monitoreo continuo.

== 5.4 Métodos de Investigación

Los métodos de investigación empleados incluyen:

*Investigación Documental:* Revisión de literatura sobre arquitecturas web modernas (Next.js, React), bases de datos con extensiones vectoriales (pgvector), técnicas de inteligencia artificial aplicada (embeddings, RAG, análisis de sentimiento) y normativas de pagos electrónicos en Bolivia.

*Prototipado:* Creación de prototipos funcionales para validar conceptos de interacción con el chatbot, flujos de reservación y procesos de pago con Red Enlace.

*Experimentación Técnica:* Pruebas de rendimiento de búsqueda semántica, evaluación de precisión en recomendaciones, y validación de predicciones de demanda contra datos históricos.

== 5.5 Técnicas e Instrumentos de Investigación

Las técnicas e instrumentos utilizados son:

*Observación Directa:* Análisis del proceso actual de gestión en el Restaurante Bambú para identificar puntos de mejora en reservaciones, toma de pedidos y control de caja.

*Análisis de Requisitos:* Especificación de requisitos funcionales mediante casos de uso y user stories, alineados con los 9 objetivos específicos del proyecto.

*Herramientas de Monitoreo:* Uso de herramientas como Lighthouse, k6 y OWASP ZAP para medir rendimiento, carga y seguridad.

*Pruebas de Usuario:* Validación de usabilidad mediante criterios WCAG nivel AA y feedback de usuarios reales (personal del restaurante y clientes).

*Evaluación de Modelos de IA:* Métricas específicas para evaluar la calidad de embeddings (similitud coseno), precisión de recomendaciones (hit rate) y exactitud de predicciones (MAE, RMSE).

*Documentación Técnica:* Especificación de APIs mediante OpenAPI/Swagger, diagramas UML, esquemas Prisma y documentación de componentes React.
