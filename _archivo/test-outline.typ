#set page(numbering: "i")
#counter(page).update(1)

#outline()

#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

#set page(numbering: none)
#counter(page).update(n => n - 1)
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO I: \
    MARCO INTRODUCTORIO
  ]
]

#pagebreak()
#set page(numbering: "1")
#place(top, hide[= CAPÍTULO I: MARCO INTRODUCTORIO])
= 1.1 Introduccion
Text
