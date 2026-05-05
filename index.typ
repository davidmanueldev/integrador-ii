// Archivo principal del proyecto
// Sistema Web de Gestión para el Restaurante Bambú con Inteligencia Artificial
// Formato APA 7ma Edición - Estructura Hito 3

// Importar configuración APA
#import "config/apa-setup.typ": *
#import "config/formato.typ": *

// =====================================================
// SECCIÓN PRELIMINAR (Numeración: números romanos i, ii, iii...)
// =====================================================

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

// Declaración Jurada, Dedicatoria y Agradecimientos (que estaban dentro de este archivo)
#include "declaracionJurada.typ"
#pagebreak()

// RESUMEN Y ABSTRACT
#include "preliminares/resumen.typ"
#include "preliminares/abstract.typ"

// ÍNDICE
#outline(
  title: [Índice],
  indent: auto,
)
#pagebreak()

// =====================================================
// CONTENIDO PRINCIPAL
// =====================================================

#set page(
  paper: "us-letter",
  numbering: "1",
  number-align: right + top,
)
#counter(page).update(1)

// I. Capítulo I. Generalidades
#include "capitulo1/capitulo1.typ"
#pagebreak()

// II. Capítulo II. Marco Teórico.
#include "capitulo4/capitulo4.typ"
#pagebreak()

// III. Capítulo III. Marco Práctico.
#include "capitulo7/capitulo7.typ"
#pagebreak()

// IV. Capítulo IV. Factibilidad Técnica, Económica y Social
#include "capitulo6/capitulo6.typ"
#pagebreak()

// V. Capítulo V. Conclusiones y Recomendaciones
#include "capitulo8/capitulo8.typ"
#pagebreak()

// Anexos
#include "anexos/anexos.typ"
#include "anexos/codigo_fuente.typ"
#include "anexos/seguridad_fisica.typ"
#include "anexos/cronograma.typ"
#pagebreak()

// Bibliografía
#include "referencias/bibliografia.typ"
