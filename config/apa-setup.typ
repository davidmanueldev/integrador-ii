// Configuración APA 7ma Edición para Typst
// Basado en American Psychological Association (7th ed.)

// Función principal de configuración APA
#let apa-config(doc) = {
  // Configuración de página según APA 7
  set page(
    paper: "us-letter", // Tamaño carta (APA estándar)
    margin: (
      top: 2.54cm, // 1 pulgada
      bottom: 2.54cm, // 1 pulgada
      left: 2.54cm, // 1 pulgada
      right: 2.54cm, // 1 pulgada
    ),
    numbering: "1", // Numeración arábiga
    number-align: right + top, // Números arriba a la derecha
  )

  // Configuración de texto según APA 7
  set text(
    font: ("Times New Roman", "Liberation Serif", "Georgia"),
    size: 12pt,
    lang: "es", // Idioma español
  )

  // Interlineado doble (APA requirement)
  // IMPORTANTE: Alineación a la IZQUIERDA (NO justificado según APA 7)
  set par(
    leading: 1em, // Espacio entre líneas (doble)
    justify: false, // SIN justificación (borde derecho irregular)
    first-line-indent: 1.27cm, // Sangría de primera línea (0.5 pulgadas)
  )

  // Configuración de encabezados según APA 7
  set heading(numbering: "1.1")

  // Estilo para nivel 1: Centrado, Negrita
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "bold", size: 12pt)
    it.body
    v(1em)
  }

  // Estilo para nivel 2: Izquierda, Negrita
  show heading.where(level: 2): it => {
    set text(weight: "bold", size: 12pt)
    it.body
    v(0.5em)
  }

  // Estilo para nivel 3: Izquierda, Negrita, Cursiva
  show heading.where(level: 3): it => {
    set text(weight: "bold", style: "italic", size: 12pt)
    it.body
    v(0.5em)
  }

  doc
}

// Función para citas en formato APA
#let cite-apa(author, year) = {
  [(#author, #year)]
}

// Función para citas con página
#let cite-apa-page(author, year, page) = {
  [(#author, #year, p. #page)]
}

// Función para referencias bibliográficas
#let reference-apa(authors, year, title, source) = {
  [#authors (#year). #emph[#title]. #source.]
}
