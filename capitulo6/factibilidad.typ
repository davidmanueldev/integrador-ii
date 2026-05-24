== Factibilidad Técnica

#v(1em)
El proyecto cuenta con total viabilidad técnica debido a la madurez de las herramientas y servicios cloud seleccionados. No se requiere la adquisición de servidores físicos (On-Premise), ya que toda la infraestructura está basada en un modelo Serverless y Backend-as-a-Service (BaaS).
- *Hardware Requerido:* Para el desarrollo solo se necesitan equipos de computación estándar. Para la operación en el restaurante, basta con computadoras convencionales para la caja, y tabletas o dispositivos móviles Android/iOS de gama media para que los meseros utilicen el módulo POS a través del navegador web.
- *Software y Servicios Cloud:* El uso de *Next.js 14* garantiza rendimiento optimizado (SSR). *Supabase* cubre todas las necesidades de base de datos relacional (PostgreSQL), autenticación, y vectorización de datos (pgvector) sin configuraciones complejas de DevOps. La integración de IA mediante *OpenAI API* y *Vercel AI SDK* está completamente documentada y es compatible con el entorno. Por último, la pasarela *Red Enlace (CyberSource)* provee APIs REST estables para pagos con tarjeta y código QR Simple en el contexto boliviano.

== Factibilidad Operativa

#v(1em)
La factibilidad operativa es alta. El sistema ha sido diseñado aplicando principios de experiencia de usuario (UX) modernos (usando componentes `shadcn/ui` y Tailwind CSS), resultando en interfaces limpias, intuitivas y responsivas. 
- Para el *equipo de desarrollo*, el stack tecnológico (React, TypeScript, Prisma) es ampliamente conocido y cuenta con una vasta comunidad de soporte.
- Para los *usuarios finales (clientes)*, el sistema de reservaciones y el chatbot están diseñados para ser operados sin capacitación previa, interactuando en lenguaje natural.
- Para el *personal del restaurante*, el tiempo de inducción para operar el módulo POS y el panel de administración se estima en menos de 4 horas, debido a la simplificación de flujos visuales y la prevención automatizada de errores.

== Factibilidad Económica

#v(1em)
La factibilidad económica es uno de los puntos más fuertes del proyecto al basarse en costos operativos bajo demanda (Pay-as-you-go), lo que permite al Restaurante Bambú evitar altos costos iniciales de licencias o hardware de servidores. A continuación, se detalla un presupuesto mensual estimado para producción (basado en precios comerciales estándar de 2024):

*Costos de Infraestructura y Software (Mensual):*
- *Hosting Frontend (Vercel Pro):* \$20 USD (Incluye análisis avanzados y mayor capacidad de procesamiento Serverless).
- *Base de Datos y Backend (Supabase Pro):* \$25 USD (Incluye 8GB de BD, almacenamiento de imágenes y backups automáticos diarios).
- *Consumo de IA (OpenAI API - text-embedding-3-small y GPT-3.5/4o-mini):* ~\$10 a \$15 USD (Estimado bajo una demanda de 500 interacciones diarias).
- *Dominio Web:* ~\$1.5 USD (\$15 a \$20 USD anuales).
- *Total Operativo en la Nube:* *Aprox. \$60 USD mensuales* (Equivalente a ~Bs. 417).

*Costos de Procesamiento de Pago (Red Enlace):*
- No hay costo fijo de hosting por las transacciones vía CyberSource, pero existe una comisión transaccional de *1.5% a 2.1%* por cada venta pagada con tarjeta, y una tarifa de mantenimiento de la plataforma EON de *Bs. 70 mensuales*. Los pagos por QR Simple tienen comisiones reducidas que favorecen el margen de ganancia.

== Análisis Costo/Beneficio

#v(1em)
Al contrastar los costos mensuales de infraestructura (~Bs. 500, incluyendo servicios en la nube y mantenimiento de Red Enlace) frente a los beneficios operativos, la inversión se justifica ampliamente:
1. *Ahorro en Horas-Hombre:* El chatbot con IA reduce significativamente el tiempo que el personal de recepción gasta respondiendo llamadas repetitivas sobre horarios y disponibilidad.
2. *Mitigación de Pérdidas:* El control automatizado de caja y la reducción de errores en la toma de pedidos mediante el POS digital previenen fugas de capital y devoluciones por platos erróneos.
3. *Aumento de Ventas:* El sistema de recomendaciones algorítmicas y la facilidad para realizar reservaciones y pagos QR 24/7 incrementan el ticket promedio y la fidelización del cliente.

El retorno de inversión (ROI) es positivo y a corto plazo, demostrando que la modernización digital con IA es financieramente sustentable para restaurantes de mediana escala en El Alto.
