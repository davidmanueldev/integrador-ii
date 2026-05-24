== Chatbots y Modelos de Lenguaje

=== Evolución de los Asistentes Virtuales

Los chatbots han experimentado una transformación radical en la última década. Los sistemas tradicionales, basados en árboles de decisión y reglas predefinidas, ofrecían respuestas limitadas y frecuentemente frustraban a los usuarios al no comprender variaciones en el lenguaje natural. Estos sistemas requerían anticipar cada posible consulta del usuario, resultando en experiencias rígidas e insatisfactorias.

La aparición de los Grandes Modelos de Lenguaje (LLMs) como GPT-4, Claude 3 y Gemini ha revolucionado este campo. Estos modelos, entrenados con billones de tokens de texto, demuestran una comprensión profunda del contexto, la intención y las sutilezas del lenguaje humano. Para el sector gastronómico, esto significa poder atender consultas complejas como "¿tienen algo vegetariano que no sea muy picante?" o "quiero algo similar al plato que pedí la semana pasada", interpretando correctamente las preferencias implícitas del cliente.

=== Generación Aumentada por Recuperación (RAG)

A pesar de sus capacidades, los LLMs presentan limitaciones importantes: su conocimiento está congelado en la fecha de entrenamiento y no tienen acceso a datos privados o específicos del negocio. La técnica de Generación Aumentada por Recuperación (RAG) resuelve estas limitaciones combinando la capacidad generativa del modelo con información actualizada recuperada de fuentes externas.

El proceso RAG consta de tres etapas fundamentales:

1. *Indexación:* Los documentos del negocio (menú, políticas, descripciones de platillos) se procesan mediante un modelo de embeddings que convierte el texto en vectores numéricos de alta dimensionalidad. Estos vectores capturan el significado semántico del contenido.

2. *Recuperación:* Cuando el usuario realiza una consulta, esta se convierte al mismo espacio vectorial y se buscan los documentos más similares utilizando métricas como similitud coseno. La extensión pgvector de PostgreSQL permite realizar estas búsquedas de manera eficiente directamente en la base de datos.

3. *Generación:* Los documentos recuperados se incluyen como contexto en el prompt enviado al LLM, permitiéndole generar respuestas precisas y fundamentadas en información actualizada del restaurante.

=== Embeddings y Búsqueda Semántica

Los embeddings son representaciones vectoriales densas que capturan relaciones semánticas entre palabras y frases. A diferencia de la búsqueda por palabras clave, la búsqueda semántica mediante embeddings comprende que "pollo a la parrilla" está relacionado con "aves asadas" aunque no compartan términos exactos.

Para este proyecto se utilizan embeddings de OpenAI (modelo `text-embedding-3-small`) que generan vectores de 1536 dimensiones. Estos vectores se almacenan en PostgreSQL utilizando la extensión pgvector, integrada nativamente en Supabase. Esta arquitectura permite:

- *Búsqueda por similitud:* Encontrar platillos semánticamente relacionados con la consulta del usuario.
- *Recomendaciones personalizadas:* Identificar platillos similares a los preferidos históricamente por el cliente.
- *Respuestas contextuales:* Proporcionar al chatbot información precisa sobre ingredientes, precios y disponibilidad.

=== Vercel AI SDK

El Vercel AI SDK proporciona una abstracción unificada para trabajar con múltiples proveedores de IA (OpenAI, Anthropic, Google) en aplicaciones React y Next.js. Sus características principales incluyen:

- *Streaming de respuestas:* Las respuestas del modelo se transmiten token por token, mejorando la experiencia de usuario al mostrar el texto progresivamente.
- *Hooks de React:* Componentes como `useChat` y `useCompletion` simplifican la integración del chatbot en la interfaz.
- *Gestión de herramientas:* Soporte para function calling, permitiendo que el LLM ejecute acciones como consultar disponibilidad de mesas o agregar items al carrito.
- *Middleware de IA:* Capacidad de interceptar y modificar requests/responses para logging, rate limiting o validación.

=== Implementación en el Contexto del Restaurante

El chatbot del Restaurante Bambú se implementa como un asistente especializado con conocimiento profundo del menú, políticas de reservación y servicios disponibles. Su arquitectura combina:

- *Base de conocimiento vectorizada:* Descripciones detalladas de cada platillo, incluyendo ingredientes, alérgenos, tiempo de preparación y maridajes sugeridos.
- *Contexto de sesión:* Historial de la conversación actual y preferencias del usuario autenticado.
- *Acciones disponibles:* Capacidad de consultar disponibilidad de mesas, verificar horarios y proporcionar recomendaciones personalizadas.

Esta implementación permite interacciones naturales como:

- "¿Qué me recomiendas si me gustó el lomo saltado?"
- "¿Tienen opciones sin gluten para el almuerzo del domingo?"
- "¿A qué hora tienen mesa disponible para 4 personas este sábado?"

El sistema responde con información precisa y actualizada, mejorando significativamente la experiencia del cliente y reduciendo la carga operativa del personal de atención.
