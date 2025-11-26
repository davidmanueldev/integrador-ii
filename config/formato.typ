// Formato y estilos adicionales para el documento

// Función para figuras con pie de imagen
#let figura(imagen, caption) = {
  figure(
    imagen,
    caption: caption,
  )
}

// Función para tablas con formato APA
#let tabla(contenido, caption) = {
  figure(
    contenido,
    caption: caption,
    kind: table,
  )
}

// Bloque de código con formato
#let codigo(contenido) = {
  block(
    fill: rgb("f5f5f5"),
    inset: 8pt,
    radius: 4pt,
    width: 100%,
    text(font: "Courier New", size: 10pt)[
      #contenido
    ],
  )
}

// Nota al pie estilo APA
#let nota-pie(contenido) = {
  text(size: 10pt, style: "italic")[
    #emph[Nota.] #contenido
  ]
}

// Formato de finalización de capítulo (centrado, negrita)
#let capitulo-fin(numero, nombre) = {
  v(2cm)
  align(center)[
    text(weight: "bold", size: 12pt)[
    CAPITULO #numero: #nombre
    ]
  ]
  pagebreak()
}
