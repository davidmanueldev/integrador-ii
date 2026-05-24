// Configuración APA 7ma Edición para Typst (Modificado para cumplir Guía UNIFRANZ)

// Función principal de configuración
#let apa-config(doc) = {
  // Configuración de página según GUIA_PROYECTO_INTEGRADOR_UNIFRANZ.md
  set page(
    paper: "us-letter", // Tamaño carta
    margin: (
      top: 2cm, 
      bottom: 2cm, 
      left: 2cm, 
      right: 2cm, 
    ),
  )

  // Configuración de texto según GUIA
  set text(
    font: "Liberation Sans",
    size: 12pt,
    lang: "es", // Idioma español
  )

  // Interlineado 1.0 (sencillo) y alineación justificada según GUIA
  set par(
    leading: 0.6em, // Espacio entre líneas aproximado a sencillo
    justify: true, // Alineación Justificada
    first-line-indent: 1.27cm, // Sangría de primera línea (para mantener algo de APA)
  )

  // Configuración de encabezados según APA 7 / Guía Unifranz
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
      return none
    } else {
      return numbering("1.1", ..n)
    }
  })

  // Estilo para nivel 1: Centrado, Negrita (según APA para nivel 1)
  // Aunque la guía UNIFRANZ dice "Títulos de capítulo: Arial 12pt Negrita"
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
