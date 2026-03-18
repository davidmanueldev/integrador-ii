// Portada del Capítulo I
#set page(numbering: none)
#counter(page).update(n => n - 1)
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO I: \
    MARCO INTRODUCTORIO
  ]
]

#pagebreak()
#set page(numbering: "1", number-align: right + top)
#place(top, hide[= CAPÍTULO I: MARCO INTRODUCTORIO])


// 1.1 Introducción
#include "introduccion.typ"

#pagebreak()

// 1.2 Antecedentes
#include "antecedentes.typ"
