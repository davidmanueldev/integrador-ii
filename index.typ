// Archivo principal del proyecto
// Formato alineado a la GUIA_PROYECTO_INTEGRADOR_UNIFRANZ.md

#import "config/apa-setup.typ": *
#import "config/formato.typ": *

#set page(paper: "us-letter", numbering: none)

// PORTADA
#include "preliminares/portada.typ"

#set page(
  paper: "us-letter",
  numbering: "i",
  number-align: center + bottom,
)
#counter(page).update(1)

#show: apa-config

#include "declaracionJurada.typ"
#pagebreak()

// Páginas preliminares
#include "preliminares/dedicatoria.typ"
#pagebreak()
#include "preliminares/agradecimientos.typ"
#pagebreak()
#include "preliminares/resumen.typ"
#pagebreak()
#include "preliminares/palabras_clave.typ"
#pagebreak()
#include "preliminares/abstract.typ"
#pagebreak()
#include "preliminares/keywords.typ"
#pagebreak()

// ÍNDICE GENERAL
#outline(
  title: [Índice General],
  indent: auto,
)
#pagebreak()

// ÍNDICE DE CUADROS
#outline(
  title: [Índice de Cuadros],
  target: figure.where(kind: "cuadro"),
)
#pagebreak()

// ÍNDICE DE FIGURAS
#outline(
  title: [Índice de Figuras],
  target: figure.where(kind: image),
)
#pagebreak()

// ÍNDICE DE TABLAS
#outline(
  title: [Índice de Tablas],
  target: figure.where(kind: table),
)
#pagebreak()

#set page(
  paper: "us-letter",
  numbering: "1",
  number-align: right + top,
)
#counter(page).update(1)
#counter(heading).update(0)

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
#include "capitulo5/capitulo5.typ"
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
#include "anexos/anexos.typ"
#pagebreak()

// CRONOGRAMA DE ACTIVIDADES
#include "anexos/cronograma.typ"
#pagebreak()
