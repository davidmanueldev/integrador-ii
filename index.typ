// Archivo principal del proyecto
// Sistema de Pedidos en Línea - Restaurante Bambú con MCPs
// Formato APA 7ma Edición

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

// ÍNDICE (se puede generar automáticamente con outline())
#outline(
  title: [Índice],
  indent: auto,
)

#pagebreak()

// CAPÍTULO 1: PLANTEAMIENTO DEL PROBLEMA
#include "capitulo1/capitulo1.typ"

#pagebreak()

// CAPÍTULO 2: MARCO TEÓRICO
#include "capitulo2/capitulo2.typ"

#pagebreak()

// CAPÍTULO 3: METODOLOGÍA Y DISEÑO DE LA SOLUCIÓN
#include "capitulo3/capitulo3.typ"

#pagebreak()
#include "capitulo4/capitulo4.typ"
#include "capitulo5/capitulo5.typ"
// #include "capitulo6/capitulo6.typ" // Capítulo eliminado

// Bibliografía
#include "referencias/bibliografia.typ"

// Glosario
#include "Glosario.typ"
