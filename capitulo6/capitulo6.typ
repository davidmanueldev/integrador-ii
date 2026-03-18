// Portada del Capítulo VI
#set page(numbering: none)
#place(top, hide[= CAPÍTULO VI: ESTUDIO DE FACTIBILIDAD])
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO VI: \
    ESTUDIO DE FACTIBILIDAD
  ]
]

#pagebreak()
#set page(numbering: "1", number-align: right + top)


== 6.1 Factibilidad Técnica

=== 6.1.1 Infraestructura Tecnológica

El análisis de factibilidad técnica evalúa la disponibilidad de recursos tecnológicos necesarios para implementar el Sistema Integral de Gestión:

*Hardware Disponible:*
- Servidores en la nube (Vercel para aplicación, Supabase para backend)
- Dispositivos de desarrollo (computadoras con capacidad para ejecutar Node.js)
- Dispositivos de prueba (navegadores modernos, dispositivos móviles)

*Software Requerido:*
- Node.js v20+ (gratuito, open source)
- PostgreSQL 15+ (gratuito en Supabase tier free)
- Next.js 14+ (gratuito, open source)
- Git para control de versiones (gratuito)

*Servicios Cloud:*
- Supabase (plan gratuito: 500MB BD, 1GB storage, Auth ilimitado)
- Vercel (plan gratuito: 100GB bandwidth, serverless functions)
- OpenAI API (pay-per-use para embeddings y chat)
- Resend (plan gratuito: 3000 emails/mes)

*Conocimientos Técnicos:*
El equipo de desarrollo cuenta con conocimientos en:
- TypeScript/JavaScript
- Desarrollo web full-stack (React, Next.js)
- Bases de datos relacionales (PostgreSQL, Prisma)
- APIs RESTful
- Integración de servicios de IA

*Conclusión:* El proyecto es técnicamente factible con los recursos disponibles.

=== 6.1.2 Escalabilidad y Rendimiento

El sistema está diseñado para manejar:
- 50 usuarios concurrentes en carga normal
- 200 usuarios concurrentes en horas pico
- Tiempos de respuesta menores a 500ms para APIs REST
- Tiempos de respuesta menores a 3s para consultas de IA
- Tiempos de carga de página menores a 2s

== 6.2 Factibilidad Operativa

=== 6.2.1 Capacitación de Usuarios

El sistema está diseñado con interfaz intuitiva basada en shadcn/ui que minimiza la necesidad de capacitación:
- Panel administrativo con navegación clara
- POS diseñado para uso rápido por meseros
- Sistema de reservaciones autoexplicativo
- Chatbot que guía a los usuarios

=== 6.2.2 Aceptación Organizacional

El Restaurante Bambú ha expresado interés en modernizar su gestión operativa, lo que indica disposición para adoptar la nueva solución.

*Beneficios Operativos:*
- Gestión eficiente de reservaciones
- Reducción de errores en pedidos
- Control de caja con trazabilidad completa
- Análisis de datos de ventas y preferencias
- Mejor experiencia del cliente mediante chatbot e IA

*Conclusión:* El proyecto es operativamente factible con adecuado proceso de adopción.

== 6.3 Factibilidad Económica

=== 6.3.1 Estimación de Costos

*Costos de Desarrollo (Inversión Inicial):*

#table(
  columns: (auto, auto),
  stroke: 0.5pt,
  [*Concepto*], [*Costo (Bs.)*],
  [Desarrollo de Software (4 meses)], [20,000],
  [Licencias y Herramientas], [0 (Open Source)],
  [Diseño UX/UI], [2,500],
  [Testing y QA], [2,000],
  [Integración Red Enlace], [1,500],
  [*Total Inversión Inicial*], [*26,000*],
)

*Costos Operativos (Mensuales):*

#table(
  columns: (auto, auto),
  stroke: 0.5pt,
  [*Concepto*], [*Costo Mensual (Bs.)*],
  [Vercel Pro (opcional)], [140],
  [Supabase Pro (opcional)], [175],
  [OpenAI API (embeddings + chat)], [100],
  [Resend (emails)], [0 (plan gratuito)],
  [Dominio y SSL], [20],
  [Mantenimiento], [800],
  [*Total Mensual*], [*1,235*],
)

*Nota:* Los primeros 6 meses pueden operar con planes gratuitos de Vercel y Supabase, reduciendo costos a Bs. 920/mes.

=== 6.3.2 Beneficios Económicos Esperados

*Beneficios Directos:*
- Reducción de errores en reservaciones: 1,000 Bs/mes
- Mayor ocupación de mesas: 2,000 Bs/mes
- Eficiencia en atención con POS: 1,500 Bs/mes
- Reducción de errores en caja: 500 Bs/mes

*Beneficios Indirectos:*
- Incremento en ventas por recomendaciones IA: 2,000 Bs/mes estimado
- Mejor planificación con predicción de demanda: 1,000 Bs/mes
- Modernización de imagen de marca
- Datos para toma de decisiones estratégicas

*Conclusión:* El proyecto es económicamente viable con ROI estimado en 4 meses.

== 6.4 Análisis Costo/Beneficio

=== 6.4.1 Cálculo de ROI

*Periodo de Análisis:* 12 meses

*Inversión Total Año 1:* 26,000 + (1,235 × 12) = 40,820 Bs

*Beneficios Totales Año 1:* (5,000 + 3,000) × 12 = 96,000 Bs

*Retorno de Inversión (ROI):*
#align(center)[
  ROI = ((Beneficios - Costos) / Costos) × 100 = ((96,000 - 40,820) / 40,820) × 100 = *135%*
]

*Punto de Equilibrio:* Aproximadamente 4 meses después del lanzamiento.

=== 6.4.2 Conclusión del Estudio de Factibilidad

El proyecto es *VIABLE* desde las tres perspectivas analizadas:

- ✓ *Técnicamente factible:* Tecnologías disponibles, planes gratuitos generosos, conocimientos adecuados
- ✓ *Operativamente factible:* Aceptación organizacional y capacitación mínima requerida
- ✓ *Económicamente factible:* ROI positivo de 135% con punto de equilibrio a 4 meses
