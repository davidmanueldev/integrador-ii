// Archivo principal del proyecto
// Sistema de Pedidos en Línea - Restaurante Bambú con MCPs
// Formato APA 7ma Edición - Estructura Lazcano

// Importar configuración APA
#import "config/apa-setup.typ": *
#import "config/formato.typ": *

// Aplicar configuración APA al documento
#show: apa-config

// PORTADA (Formato APA 7 - Estudiante)
#include "preliminares/portada.typ"

// RESUMEN (Español)
#include "preliminares/resumen.typ"

// ABSTRACT (Inglés)
#include "preliminares/abstract.typ"

// Declaración jurada
#include "declaracionJurada.typ"

#pagebreak()

// ÍNDICE (se genera automáticamente con outline())
#outline(
  title: [Índice General],
  indent: auto,
)

#pagebreak()

// CAPÍTULO I: MARCO INTRODUCTORIO
#include "capitulo1/capitulo1.typ"

#pagebreak()

// CAPÍTULO II: DISEÑO TEÓRICO DE LA INVESTIGACIÓN
#include "capitulo2/capitulo2.typ"

#pagebreak()

// CAPÍTULO III: JUSTIFICACIÓN, ALCANCES Y APORTES
#include "capitulo3/capitulo3.typ"

#pagebreak()

// CAPÍTULO IV: MARCO TEÓRICO
#include "capitulo4/capitulo4.typ"

#pagebreak()

// CAPÍTULO V: DISEÑO METODOLÓGICO
#include "capitulo5/metodologia.typ"

#pagebreak()

// CAPÍTULO VI: ESTUDIO DE FACTIBILIDAD
#include "capitulo6/capitulo6.typ"

#pagebreak()

// CAPÍTULO VII: INGENIERÍA DEL PROYECTO
#include "capitulo7/capitulo7.typ"

#pagebreak()

// CAPÍTULO VIII: CONCLUSIONES Y RECOMENDACIONES
#include "capitulo8/capitulo8.typ"

#pagebreak()

// BIBLIOGRAFÍA
#include "referencias/bibliografia.typ"

#pagebreak()

// ANEXOS
= ANEXOS

== Anexo A: Esquemas de Base de Datos
_Ver archivos DDL en repositorio del proyecto_

== Anexo B: Documentación de API
_Disponible en /api/docs mediante Swagger UI_

== Anexo C: Manual de Usuario
_Documento separado entregado con el proyecto_

#pagebreak()

// CRONOGRAMA DE ACTIVIDADES
= CRONOGRAMA DE ACTIVIDADES

#table(
  columns: (auto, auto, auto, auto),
  stroke: 0.5pt,
  [*Actividad*], [*Inicio*], [*Fin*], [*Duración*],
  [Análisis de Requisitos], [01/09/2025], [15/09/2025], [15 días],
  [Diseño de Arquitectura], [16/09/2025], [30/09/2025], [15 días],
  [Desarrollo Frontend], [01/10/2025], [31/10/2025], [31 días],
  [Desarrollo Backend], [01/10/2025], [31/10/2025], [31 días],
  [Integración de Pagos], [01/11/2025], [07/11/2025], [7 días],
  [Pruebas], [08/11/2025], [18/11/2025], [11 días],
  [Despliegue], [19/11/2025], [19/11/2025], [1 día],
)

#pagebreak()

// Glosario
#include "Glosario.typ"
