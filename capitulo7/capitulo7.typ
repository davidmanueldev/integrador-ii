// Portada del Capítulo VII
#set page(numbering: none)
#counter(page).update(n => n - 1)
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO VII: \
    INGENIERÍA DEL PROYECTO
  ]
]

#pagebreak()
#set page(numbering: "1", number-align: right + top)
#place(top, hide[= CAPÍTULO VII: INGENIERÍA DEL PROYECTO])


#include "diagrama_flujo.typ"

#pagebreak()

#include "diagramas_desarrollo.typ"

#pagebreak()

#include "modelado_proyecto.typ"

#pagebreak()

#include "desarrollo_proyecto.typ"

#pagebreak()

#include "monitoreo_evaluacion.typ"
