#set heading(numbering: none)
#show heading.where(level: 1): it => {
  set align(center)
  set text(weight: "bold", size: 12pt)
  it.body
  v(1em)
}

#outline()

#pagebreak()
#place(top, hide[= CAPÍTULO I: MARCO INTRODUCTORIO])
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    CAPÍTULO I: \
    MARCO INTRODUCTORIO
  ]
]
