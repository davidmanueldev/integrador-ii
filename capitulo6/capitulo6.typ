// Portada del Capítulo VI
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO VI: \
    ESTUDIO DE FACTIBILIDAD
  ]
]

#pagebreak()

== 6.1 Factibilidad Técnica

=== 6.1.1 Infraestructura Tecnológica

El análisis de factibilidad técnica evalúa la disponibilidad de recursos tecnológicos necesarios para implementar el sistema:

*Hardware Disponible:*
- Servidores en la nube (Railway, Vercel, render.com) para deployment
- Dispositivos de desarrollo (computadoras con capacidad para ejecutar Node.js, MongoDB)
- Dispositivos de prueba (navegadores modernos, dispositivos móviles)

*Software Requerido:*
- Node.js v18+ (gratuito, open source)
- MongoDB 6+ (gratuito en versión Community)
- Next.js 14+ (gratuito, open source)
- Git para control de versiones (gratuito)

*Conocimientos Técnicos:*
El equipo de desarrollo cuenta con conocimientos en:
- JavaScript/TypeScript
- Desarrollo web full-stack (React, Node.js, Express)
- Bases de datos NoSQL (MongoDB)
- APIs RESTful
- Metodologías ágiles

*Conclusión:* El proyecto es técnicamente factible con los recursos disponibles.

=== 6.1.2 Escalabilidad y Rendimiento

El sistema está diseñado para manejar:
- 50 usuarios concurrentes en carga normal
- 200 usuarios concurrentes en horas pico
- Tiempos de respuesta < 500ms para APIs
- Tiempos de carga de página < 2s

== 6.2 Factibilidad Operativa

=== 6.2.1 Capacitación de Usuarios

El sistema está diseñado con interfaz intuitiva que minimiza la necesidad de capacitación:
- Panel administrativo con navegación clara
- Interfaz de cliente simplificada
- Manual de usuario y tutoriales en video

=== 6.2.2 Aceptación Organizacional

El restaurante "Bambú" ha expresado interés en modernizar su proceso de pedidos, lo que indica disposición para adoptar la nueva solución.

*Beneficios Operativos:*
- Reducción de errores en pedidos
- Mayor eficiencia en la gestión de órdenes
- Análisis de datos de ventas en tiempo real
- Mejor experiencia del cliente

*Conclusión:* El proyecto es operativamente factible con adecuado proceso de adopción.

== 6.3 Factibilidad Económica

=== 6.3.1 Estimación de Costos

*Costos de Desarrollo (Inversión Inicial):*

#table(
  columns: (auto, auto),
  stroke: 0.5pt,
  [*Concepto*], [*Costo (Bs.)*],
  [Desarrollo de Software (3 meses)], [15,000],
  [Licencias y Herramientas], [0 (Open Source)],
  [Servidor de Desarrollo], [500],
  [Diseño UX/UI], [2,000],
  [Testing y QA], [1,500],
  [*Total Inversión Inicial*], [*19,000*],
)

*Costos Operativos (Mensuales):*

#table(
  columns: (auto, auto),
  stroke: 0.5pt,
  [*Concepto*], [*Costo Mensual (Bs.)*],
  [Hosting (Railway/Vercel)], [150],
  [Base de Datos (MongoDB Atlas)], [100],
  [Dominio y SSL], [20],
  [Mantenimiento], [1,000],
  [*Total Mensual*], [*1,270*],
)

=== 6.3.2 Beneficios Económicos Esperados

*Beneficios Directos:*
- Reducción de costos de personal (toma de pedidos manual): 2,000 Bs/mes
- Reducción de errores en pedidos (pérdidas): 1,500 Bs/mes
- Mayor eficiencia operativa: 1,000 Bs/mes

*Beneficios Indirectos:*
- Incremento en ventas por mejor experiencia de cliente: 3,000 Bs/mes estimado
- Análisis de datos para toma de decisiones
- Modernización de imagen de marca

*Conclusión:* El proyecto es económicamente viable con ROI estimado en 6 meses.

== 6.4 Análisis Costo/Beneficio

=== 6.4.1 Cálculo de ROI

*Periodo de Análisis:* 12 meses

*Inversión Total Año 1:* 19,000 + (1,270 × 12) = 34,240 Bs

*Beneficios Totales Año 1:* (4,500 + 3,000) × 12 = 90,000 Bs

*Retorno de Inversión (ROI):*
#align(center)[
  ROI = ((Beneficios - Costos) / Costos) × 100 = ((90,000 - 34,240) / 34,240) × 100 = *163%*
]

*Punto de Equilibrio:* Aproximadamente 5 meses después del lanzamiento.

=== 6.4.2 Conclusión del Estudio de Factibilidad

El proyecto es *VIABLE* desde las tres perspectivas analizadas:

- ✓ *Técnicamente factible:* Tecnologías disponibles y conocimientos adecuados
- ✓ *Operativamente factible:* Aceptación organizacional y capacitación mínima requerida
- ✓ *Económicamente factible:* ROI positivo de 163% con punto de equilibrio a 5 meses

Se recomienda proceder con la implementación del proyecto.
