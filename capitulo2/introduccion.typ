== 2.1 Introducción

El desarrollo de sistemas de información web ha experimentado una evolución acelerada en las últimas décadas, transformando radicalmente la forma en que las organizaciones interactúan con sus clientes y gestionan sus operaciones. En el contexto de la industria gastronómica, los sistemas de gestión integral representan una convergencia de múltiples disciplinas tecnológicas: arquitectura de software, bases de datos, interfaces de usuario, procesamiento de pagos, inteligencia artificial y análisis de datos.

Este capítulo establece el marco teórico que fundamenta el desarrollo del Sistema Integral de Gestión para el Restaurante Bambú, proporcionando una revisión exhaustiva de los conceptos, tecnologías y metodologías empleadas en el proyecto. La exposición se estructura en secciones principales que abordan desde los fundamentos de sistemas web hasta las técnicas de inteligencia artificial aplicada.

*Propósito del Marco Teórico*

El marco teórico cumple varios propósitos esenciales en este proyecto:

*Fundamentación Conceptual*
- Establece definiciones precisas de términos técnicos y conceptos clave utilizados a lo largo del documento
- Proporciona contexto histórico sobre la evolución de sistemas de gestión para restaurantes
- Sitúa el proyecto dentro del panorama actual de transformación digital en el sector gastronómico boliviano

*Justificación de Decisiones Tecnológicas*
- Explica las características y ventajas de cada tecnología seleccionada (Next.js, React, Supabase, Prisma)
- Fundamenta la elección de Red Enlace como pasarela de pagos para el contexto boliviano
- Presenta comparativas con alternativas tecnológicas consideradas

*Soporte para la Innovación: Inteligencia Artificial*
- Introduce los conceptos de embeddings, búsqueda semántica y RAG (Retrieval-Augmented Generation)
- Explica los fundamentos de sistemas de recomendación y predicción de demanda
- Establece las bases para comprender el análisis de sentimiento aplicado a reseñas

*Contextualización de Metodologías*
- Describe metodologías de desarrollo ágil aplicables a proyectos de software
- Proporciona fundamentos de ingeniería de software que guían el proceso de implementación

*Organización del Capítulo*

La estructura de este capítulo sigue una progresión lógica desde conceptos generales hacia aspectos específicos del proyecto:

1. *Conceptos Fundamentales*: Presenta los fundamentos de sistemas de información web, arquitecturas cliente-servidor, APIs RESTful y bases de datos relacionales. Estos conceptos establecen el vocabulario técnico común necesario para comprender el resto del documento.

2. *Tecnologías del Stack*: Describe en detalle cada una de las tecnologías principales utilizadas en el proyecto: Next.js 14 para el framework web, React 18 para interfaces de usuario, Supabase para backend y autenticación, Prisma para acceso a datos, y Red Enlace para procesamiento de pagos en Bolivia.

3. *Inteligencia Artificial Aplicada*: Dedica una sección completa a explicar las técnicas de IA utilizadas: embeddings y búsqueda semántica con pgvector, sistemas de recomendación, predicción de demanda y análisis de sentimiento.

4. *Chatbots y Asistentes Virtuales*: Explora la evolución de chatbots desde sistemas basados en reglas hasta asistentes conversacionales con RAG (Retrieval-Augmented Generation), que combinan capacidades de LLMs con acceso a datos actualizados mediante búsqueda semántica.

*Enfoque de la Revisión Teórica*

La revisión bibliográfica realizada para este marco teórico combina:

- *Fuentes académicas*: Artículos de investigación, proyectos de grado y publicaciones científicas sobre arquitectura de software, sistemas distribuidos e inteligencia artificial
- *Documentación técnica oficial*: Documentación de desarrolladores de Next.js, React, Supabase, Prisma y Vercel AI SDK
- *Normativas locales*: Documentación de Red Enlace, ASFI y regulaciones de pagos electrónicos en Bolivia
- *Literatura de ingeniería de software*: Libros de referencia clásicos como _Ingeniería del Software_ de Pressman y Maxim (2020)

Este enfoque híbrido asegura que el marco teórico esté fundamentado tanto en principios académicos sólidos como en prácticas actuales de la industria del desarrollo de software.

== Relevancia para el Proyecto

Cada componente del marco teórico tiene una conexión directa con decisiones de diseño e implementación del sistema:

- Los conceptos de arquitectura cliente-servidor fundamentan la separación entre frontend (Next.js/React) y backend (API Routes, Supabase)
- La comprensión de bases de datos relacionales con PostgreSQL justifica el diseño del esquema con Prisma
- El conocimiento de embeddings y pgvector permite diseñar una integración efectiva entre el chatbot y la búsqueda semántica
- La comprensión de Red Enlace permite implementar pagos adaptados al contexto boliviano
- Los principios de desarrollo ágil guían la metodología de implementación iterativa del proyecto

En las siguientes secciones se desarrollan estos temas con el nivel de detalle necesario para comprender las decisiones técnicas y apreciar las contribuciones innovadoras del proyecto, particularmente en lo referente a la integración de múltiples funcionalidades de IA en un sistema de producción real para el contexto boliviano.
