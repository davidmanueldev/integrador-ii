// Portada del Capítulo III
#set page(numbering: none)
#counter(page).update(n => n - 1)
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO III: \
    JUSTIFICACIÓN, ALCANCES \
    Y APORTES
  ]
]

#pagebreak()
#set page(numbering: "1", number-align: right + top)
#place(top, hide[= CAPÍTULO III: JUSTIFICACIÓN, ALCANCES Y APORTES])


// 3.1 Justificación
#include "justificacion.typ"

#pagebreak()

// 3.2 Alcances
#include "alcances.typ"

#pagebreak()

// 3.3 Aportes
#include "aportes.typ"
