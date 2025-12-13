// Archivo principal del proyecto
// Sistema de Pedidos en Línea - Restaurante Bambú con MCPs
// Formato APA 7ma Edición - Estructura Lazcano

// Importar configuración APA
#import "config/apa-setup.typ": *
#import "config/formato.typ": *

// =====================================================
// SECCIÓN PRELIMINAR (Numeración: números romanos i, ii, iii...)
// Según norma APA 7 para tesis/disertaciones
// =====================================================

// Configuración inicial SIN numeración para portada
#set page(numbering: none)

// PORTADA (Sin número de página visible)
#include "preliminares/portada.typ"

// Ahora activamos numeración romana para páginas preliminares
#set page(
  numbering: "i",
  number-align: center + bottom,
)
#counter(page).update(1)

// Aplicar configuración APA al documento (sin afectar numeración)
#show: apa-config

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

// =====================================================
// CONTENIDO PRINCIPAL (Numeración: números arábigos 1, 2, 3...)
// La página 1 comienza aquí según APA 7 para tesis
// =====================================================

// Cambiar a numeración arábiga y resetear contador a 1
#set page(
  numbering: "1",
  number-align: right + top,
)
#counter(page).update(1)

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

// ANEXOS (detallados en archivo separado)
#include "anexos/anexos.typ"

#pagebreak()

// ANEXO E: CÓDIGO FUENTE DEL PROTOTIPO
#include "anexos/codigo_fuente.typ"

#pagebreak()

// ANEXO F: SEGURIDAD FÍSICA Y LÓGICA
#include "anexos/seguridad_fisica.typ"

#pagebreak()

// CRONOGRAMA DE ACTIVIDADES (detallado en archivo separado)
#include "anexos/cronograma.typ"



#pagebreak()

// Glosario
#include "Glosario.typ"
