// Portada Personalizada UNIFRANZ
#page(
  margin: (top: 3cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
  [
    #align(center)[
      #text(weight: "bold", size: 14pt)[
        UNIVERSIDAD PRIVADA FRANZ TAMAYO SEDE EL ALTO\
        FACULTAD DE INGENIERÍA\
        CARRERA DE INGENIERÍA DE SISTEMAS
      ]

      #v(2cm)

      // Logo
      #image("../logounifranz.png", width: 5cm)

      #v(2cm)

      #text(weight: "bold", size: 12pt)[
        PROYECTO INTEGRADOR INTERMEDIO II
      ]

      #v(1.5cm)

      #text(weight: "bold", size: 14pt)[
        "SISTEMA WEB DE PEDIDOS EN LÍNEA PARA EL RESTAURANTE BAMBÚ INTEGRANDO MODEL CONTEXT PROTOCOL (MCP) CON CHATBOT INTELIGENTE"
      ]

      #v(1.5cm)

      #text(weight: "bold", size: 12pt)[
        CASO : Restaurante Bambú
      ]

      #align(center)[
        #grid(
          columns: (auto, auto),
          gutter: 10pt,
          align(right)[*AUTOR :*], align(left)[David Manuel Mamani Huanca],
          align(right)[*TUTOR :*], align(left)[Ing. Juan Gabriel Lazcano Balanza],
        )
      ]

      #text(weight: "bold", size: 12pt)[
        EL ALTO – BOLIVIA\
        2025
      ]
    ]
  ],
)

#pagebreak()
