== 2.1 Introducción

El desarrollo de sistemas de información web ha experimentado una evolución acelerada en las últimas décadas, transformando radicalmente la forma en que las organizaciones interactúan con sus clientes y gestionan sus operaciones. En el contexto de la industria gastronómica, los sistemas de pedidos en línea representan una convergencia de múltiples disciplinas tecnológicas: arquitectura de software, bases de datos, interfaces de usuario, procesamiento de pagos y, más recientemente, inteligencia artificial conversacional.

Este capítulo establece el marco teórico que fundamenta el desarrollo del Sistema de Pedidos en Línea para el Restaurante Bambú, proporcionando una revisión exhaustiva de los conceptos, tecnologías y metodologías empleadas en el proyecto. La exposición se estructura en cinco secciones principales que abordan desde los fundamentos de sistemas web hasta las tecnologías emergentes de integración con modelos de lenguaje.

*Propósito del Marco Teórico*

El marco teórico cumple varios propósitos esenciales en este proyecto:

*Fundamentación Conceptual*
- Establece definiciones precisas de términos técnicos y conceptos clave utilizados a lo largo del documento
- Proporciona contexto histórico sobre la evolución de sistemas de pedidos en línea
- Sitúa el proyecto dentro del panorama actual de transformación digital en restaurantes

*Justificación de Decisiones Tecnológicas*
- Explica las características y ventajas de cada tecnología seleccionada (Next.js, React, MongoDB, Stripe)
- Fundamenta la elección de arquitecturas y patrones de diseño implementados
- Presenta comparativas con alternativas tecnológicas consideradas

*Soporte para la Innovación: Model Context Protocol*
- Introduce el concepto de Model Context Protocol (MCPs) como protocolo emergente
- Explica los fundamentos teóricos que permiten la integración de sistemas de IA con fuentes de datos dinámicas
- Establece las bases para comprender las ventajas arquitectónicas de MCPs frente a enfoques tradicionales

*Contextualización de Metodologías*
- Describe metodologías de desarrollo ágil aplicables a proyectos de software
- Proporciona fundamentos de ingeniería de software que guían el proceso de implementación

*Organización del Capítulo*

La estructura de este capítulo sigue una progresión lógica desde conceptos generales hacia aspectos específicos del proyecto:

1. *Conceptos Fundamentales*: Presenta los fundamentos de sistemas de información web, arquitecturas cliente-servidor, APIs RESTful y bases de datos NoSQL. Estos conceptos establecen el vocabulario técnico común necesario para comprender el resto del documento.

2. *Tecnologías del Stack*: Describe en detalle cada una de las tecnologías principales utilizadas en el proyecto: Next.js para el framework web, React para interfaces de usuario, MongoDB para almacenamiento de datos, Stripe para procesamiento de pagos y NextAuth para autenticación. Para cada tecnología se explican sus características distintivas, ventajas y casos de uso apropiados.

3. *Model Context Protocol (MCPs)*: Dedica una sección completa a explicar este protocolo emergente desarrollado por Anthropic. Se abordan sus fundamentos teóricos, arquitectura, mecanismos de comunicación, ventajas sobre enfoques tradicionales y aplicaciones prácticas en sistemas de información.

4. *Chatbots y Asistentes Virtuales*: Explora la evolución de chatbots desde sistemas basados en reglas hasta asistentes conversacionales con procesamiento de lenguaje natural. Se comparan arquitecturas tradicionales (con información estática) versus arquitecturas modernas con acceso a datos dinámicos mediante protocolos como MCPs.

*Enfoque de la Revisión Teórica*

La revisión bibliográfica realizada para este marco teórico combina:

- *Fuentes académicas*: Artículos de investigación, tesis y publicaciones científicas sobre arquitectura de software, sistemas distribuidos e inteligencia artificial
- *Documentación técnica oficial*: Documentación de desarrolladores de Next.js, React, MongoDB, Stripe y otros frameworks utilizados
- *Especificaciones de protocolos*: Documentación oficial de Model Context Protocol publicada por Anthropic
- *Literatura de ingeniería de software*: Libros de referencia clásicos como _Ingeniería del Software_ de Pressman y Maxim (2020), que establecen metodologías y mejores prácticas

Este enfoque híbrido asegura que el marco teórico esté fundamentado tanto en principios académicos sólidos como en prácticas actuales de la industria del desarrollo de software.

== Relevancia para el Proyecto

Cada componente del marco teórico tiene una conexión directa con decisiones de diseño e implementación del sistema:

- Los conceptos de arquitectura cliente-servidor fundamentan la separación entre frontend (Next.js/React) y backend (API Routes)
- La comprensión de bases de datos NoSQL justifica la elección de MongoDB para manejar esquemas flexibles de productos y pedidos
- El conocimiento de MCPs permite diseñar una integración efectiva entre el chatbot y las fuentes de datos del restaurante
- Los principios de desarrollo ágil guían la metodología de implementación iterativa del proyecto

En las siguientes secciones se desarrollan estos temas con el nivel de detalle necesario para comprender las decisiones técnicas y apreciar las contribuciones innovadoras del proyecto, particularmente en lo referente a la integración de Model Context Protocol en un sistema de producción real.
