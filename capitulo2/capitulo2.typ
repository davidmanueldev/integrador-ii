// Portada del Capítulo II
#set page(numbering: none)
#counter(page).update(n => n - 1)
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO II: \
    DISEÑO TEÓRICO DE LA \
    INVESTIGACIÓN
  ]
]

#pagebreak()
#set page(numbering: "1", number-align: right + top)
#place(top, hide[= CAPÍTULO II: DISEÑO TEÓRICO DE LA INVESTIGACIÓN])


// 2.1 Problema de Investigación
#include "problema.typ"

#pagebreak()

// 2.2 Determinación de Objetivos
#include "objetivos.typ"
