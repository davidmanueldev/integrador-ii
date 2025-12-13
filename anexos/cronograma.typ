// Cronograma de Actividades del Proyecto
// Sistema de Pedidos en Línea - Restaurante Bambú

= CRONOGRAMA DE ACTIVIDADES

El desarrollo del proyecto se llevó a cabo en un período de 3 meses, dividido en las siguientes fases:

== Fase 1: Planificación y Análisis (Semanas 1-2)

#figure(
  table(
    columns: (1fr, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Actividad*], [*Inicio*], [*Fin*], [*Duración*],
    [Análisis de requisitos funcionales y no funcionales], [01/09/2025], [07/09/2025], [7 días],
    [Estudio de tecnologías (Next.js, MongoDB, Stripe)], [08/09/2025], [10/09/2025], [3 días],
    [Definición de arquitectura del sistema], [11/09/2025], [14/09/2025], [4 días],
    [Diseño de base de datos y modelado de datos], [15/09/2025], [17/09/2025], [3 días],
    [Diseño de interfaz de usuario (wireframes)], [18/09/2025], [21/09/2025], [4 días],
  ),
  caption: [Cronograma Fase 1 - Planificación y Análisis],
)

== Fase 2: Desarrollo del Sistema (Semanas 3-8)

#figure(
  table(
    columns: (1fr, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e8f5e9") } else { white },
    [*Actividad*], [*Inicio*], [*Fin*], [*Duración*],
    [Configuración del entorno de desarrollo], [22/09/2025], [23/09/2025], [2 días],
    [Desarrollo del módulo de autenticación], [24/09/2025], [30/09/2025], [7 días],
    [Desarrollo del catálogo de productos], [01/10/2025], [10/10/2025], [10 días],
    [Desarrollo del carrito de compras], [11/10/2025], [17/10/2025], [7 días],
    [Integración con Stripe (pagos)], [18/10/2025], [25/10/2025], [8 días],
    [Desarrollo del panel administrativo], [26/10/2025], [05/11/2025], [11 días],
    [Integración con AWS S3 (imágenes)], [06/11/2025], [08/11/2025], [3 días],
  ),
  caption: [Cronograma Fase 2 - Desarrollo del Sistema],
)

#pagebreak()

== Fase 3: Pruebas e Integración (Semanas 9-10)

#figure(
  table(
    columns: (1fr, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fff3e0") } else { white },
    [*Actividad*], [*Inicio*], [*Fin*], [*Duración*],
    [Pruebas unitarias de componentes], [09/11/2025], [12/11/2025], [4 días],
    [Pruebas de integración API-Base de datos], [13/11/2025], [15/11/2025], [3 días],
    [Pruebas end-to-end de flujos críticos], [16/11/2025], [18/11/2025], [3 días],
    [Pruebas de seguridad (OWASP)], [19/11/2025], [20/11/2025], [2 días],
    [Pruebas de rendimiento y carga], [21/11/2025], [22/11/2025], [2 días],
    [Corrección de defectos identificados], [23/11/2025], [25/11/2025], [3 días],
  ),
  caption: [Cronograma Fase 3 - Pruebas e Integración],
)

== Fase 4: Despliegue y Documentación (Semanas 11-12)

#figure(
  table(
    columns: (1fr, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fce4ec") } else { white },
    [*Actividad*], [*Inicio*], [*Fin*], [*Duración*],
    [Configuración del entorno de producción], [26/11/2025], [27/11/2025], [2 días],
    [Despliegue en servidor de producción], [28/11/2025], [28/11/2025], [1 día],
    [Verificación post-despliegue], [29/11/2025], [29/11/2025], [1 día],
    [Elaboración de manual de usuario], [30/11/2025], [02/12/2025], [3 días],
    [Elaboración de documentación técnica], [03/12/2025], [05/12/2025], [3 días],
    [Capacitación al personal del restaurante], [06/12/2025], [06/12/2025], [1 día],
  ),
  caption: [Cronograma Fase 4 - Despliegue y Documentación],
)

#pagebreak()

== Diagrama de Gantt Simplificado

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    stroke: 0.5pt,
    fill: (col, row) => {
      if row == 0 { rgb("#424242") } else if col == 0 { white } else if row <= 2 and col == 1 {
        rgb("#e3f2fd")
      } else if row >= 3 and row <= 5 and col == 2 { rgb("#e8f5e9") } else if row >= 6 and row <= 7 and col == 3 {
        rgb("#fff3e0")
      } else if row >= 8 and col == 4 { rgb("#fce4ec") } else { rgb("#fafafa") }
    },
    [#text(fill: white)[*Fase*]],
    [#text(fill: white)[*Sep*]],
    [#text(fill: white)[*Oct*]],
    [#text(fill: white)[*Nov*]],
    [#text(fill: white)[*Dic*]],

    [Análisis], [████████], [], [], [],
    [Diseño], [██████], [], [], [],
    [Autenticación], [], [████████], [], [],
    [Catálogo/Carrito], [], [████████████], [], [],
    [Pagos/Admin], [], [████], [████████], [],
    [Pruebas], [], [], [████████], [],
    [Correcciones], [], [], [████], [],
    [Despliegue], [], [], [], [████],
    [Documentación], [], [], [], [████████],
  ),
  caption: [Diagrama de Gantt del Proyecto],
)

== Resumen del Cronograma

#figure(
  table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e1bee7") } else if row == 5 { rgb("#c8e6c9") } else { white },
    [*Fase*], [*Duración*], [*Inicio*], [*Fin*],
    [Planificación y Análisis], [21 días], [01/09/2025], [21/09/2025],
    [Desarrollo del Sistema], [48 días], [22/09/2025], [08/11/2025],
    [Pruebas e Integración], [17 días], [09/11/2025], [25/11/2025],
    [Despliegue y Documentación], [11 días], [26/11/2025], [06/12/2025],
    [*TOTAL PROYECTO*], [*97 días*], [*01/09/2025*], [*06/12/2025*],
  ),
  caption: [Resumen General del Cronograma],
)

== Hitos del Proyecto

#figure(
  table(
    columns: (auto, auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#b2dfdb") } else { white },
    [*Hito*], [*Fecha*], [*Descripción*],
    [H1], [21/09/2025], [Finalización del diseño y aprobación de arquitectura],
    [H2], [30/09/2025], [Sistema de autenticación funcional],
    [H3], [25/10/2025], [Integración de pagos con Stripe completada],
    [H4], [08/11/2025], [MVP funcional con todas las características],
    [H5], [25/11/2025], [Pruebas completadas y defectos corregidos],
    [H6], [06/12/2025], [Entrega final y capacitación],
  ),
  caption: [Hitos Principales del Proyecto],
)
