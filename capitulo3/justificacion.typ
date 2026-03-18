== 3.1 Justificación

=== 3.1.1 Justificación Técnica

La implementación de este sistema se justifica técnicamente por la necesidad de modernizar la infraestructura tecnológica del Restaurante Bambú, adoptando una arquitectura basada en tecnologías modernas y servicios cloud. La integración de funcionalidades de inteligencia artificial representa una innovación significativa para el sector gastronómico boliviano:

- *Búsqueda semántica mediante embeddings:* Permite al chatbot comprender consultas en lenguaje natural, superando las limitaciones de los sistemas basados en palabras clave.
- *Sistema de recomendación personalizada:* Mejora la experiencia del cliente al sugerir platillos basados en preferencias e historial.
- *Predicción de demanda:* Optimiza la planificación de recursos humanos e inventario mediante análisis de datos históricos.
- *Análisis de sentimiento:* Automatiza la identificación de áreas de mejora a partir del feedback de clientes.

La selección de Supabase (PostgreSQL) como base de datos permite aprovechar pgvector para almacenamiento de embeddings, eliminando la necesidad de servicios de vectores externos y simplificando la arquitectura.

=== 3.1.2 Justificación Social

Desde una perspectiva social, el proyecto mejora la calidad de servicio ofrecida a la comunidad de El Alto, proporcionando:

- Un sistema de reservaciones accesible 24/7 que democratiza el acceso al servicio
- Un asistente virtual que responde consultas inmediatas sin esperas telefónicas
- Recomendaciones personalizadas que mejoran la experiencia gastronómica
- Múltiples opciones de pago que se adaptan a las preferencias de los clientes

Además, el proyecto sirve como modelo de transformación digital para otras PYMES del sector gastronómico en Bolivia, demostrando la viabilidad de implementar tecnologías de IA en negocios locales.

=== 3.1.3 Justificación Económica

Económicamente, el sistema genera beneficios tangibles:

- *Optimización de recursos:* La predicción de demanda permite planificar personal e inventario, reduciendo desperdicios y costos laborales innecesarios.
- *Incremento de ventas:* Las recomendaciones personalizadas y la disponibilidad 24/7 del sistema de reservaciones aumentan las oportunidades de negocio.
- *Reducción de errores:* El punto de venta digital elimina errores de cálculo y registro manual.
- *Mejora continua:* El análisis de sentimiento identifica problemas antes de que afecten significativamente al negocio.
- *Integración local:* El uso de Red Enlace como pasarela de pagos evita comisiones internacionales y permite liquidación directa en cuenta bancaria boliviana.

=== 3.1.4 Justificación Ambiental y Legal

El proyecto contribuye a la sostenibilidad ambiental al reducir el uso de papel mediante:

- Menús digitales accesibles vía web
- Tickets y comprobantes electrónicos
- Reportes digitales en dashboard administrativo
- Confirmaciones de reservación por correo electrónico

Legalmente, el sistema se adhiere a las normativas vigentes:

- Cumplimiento de regulaciones de ASFI a través de Red Enlace
- Estándares PCI DSS para procesamiento de pagos con tarjeta
- Autenticación 3D Secure para transacciones seguras
- Protección de datos personales de usuarios
