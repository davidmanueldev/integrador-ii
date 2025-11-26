#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm)
)

#set text(
  size: 12pt,
  lang: "es"
)

#set par(
  justify: true,
  leading: 0.65em
)

#let linea(n) = {
  "_" * n
}

#align(center)[
  #text(size: 12pt, weight: "bold")[
    DECLARACIÓN JURADA DE AUTENTICIDAD DE PERFIL DE TRABAJO DE GRADO
  ]
]

#v(1.5em)

Yo, David Manuel Mamani Huanca, estudiante de Proyecto Intermedio Integrador I, de la Carrera de Ingeniería de Sistemas de la Universidad Privada Franz Tamayo, identificado con CI. 13465497 y Registro Universitario: #linea(40)

#v(0.8em)

Declaro bajo juramento que:

#v(0.8em)

#enum(
  numbering: "1.",
  spacing: 0.65em,
  [Soy autor del Proyecto Integrador:\
  #v(0.3em)
  #align(center)[
    #text(weight: "bold")[
      "SISTEMA DE PEDIDOS EN LÍNEA CON INTEGRACIÓN MCP PARA RESTAURANTE BAMBÚ"
    ]
  ]
  #v(0.3em)
  El mismo que presentamos bajo la modalidad de Proyecto Integrador.],
  
  [El texto de mi perfil de Proyecto Integrador respeta y no vulnera los derechos de terceros, incluidos los derechos de propiedad intelectual. En tal sentido, declaro que este Proyecto Integrador no ha sido plagiado total ni parcialmente, para la cual he respetado las normas internacionales de citas y referencias de las fuentes consultadas],
  
  [El texto del Proyecto Integrador que presento no ha sido publicado ni presentado antes en cualquier medio electrónico o físico.],
  
  [Por tanto, declaro que mi perfil de Proyecto Integrador cumple con todas las normas de la carrera de Ingeniería de Sistemas de la Universidad Privada Franz Tamayo.],
  
  [El incumplimiento de lo declarado da lugar a responsabilidad del declarante, en consecuencia; a través del presente documento asumo frente a terceros, la carrera de Ingeniera de Sistemas de la Universidad Privada Franz Tamayo toda responsabilidad que pueda derivarse por el Proyecto Integrador presentado.]
)

#v(1.5em)

Fecha: #linea(40)

#v(3em)

#align(center)[
  #linea(40)
  
  #v(0.3em)
  
  Univ. David Manuel Mamani Huanca
  
  CI. 13465497
]

#pagebreak()

#set page(
  numbering: "i",
  number-align: center
)

#counter(page).update(1)

#align(center)[
  #text(size: 12pt, weight: "bold")[
    DEDICATORIA
  ]
]

#v(2em)

#align(left)[
A mi madre, por su amor incondicional, por haberme criado con esfuerzo, valores y dedicación, siendo mi mayor ejemplo de fortaleza y constancia.

A mi familia, que siempre me ha brindado su apoyo, paciencia y motivación para seguir adelante, incluso en los momentos más difíciles.

A mi silla, que aguantó todo este tiempo sin romperse, siendo testigo silencioso de largas jornadas de trabajo y dedicación.

Este logro es tan mío como suyo.
]

#pagebreak()

#align(center)[
  #text(size: 12pt, weight: "bold")[
    AGRADECIMIENTOS
  ]
]

#v(2em)

#align(left)[
Quiero expresar mi sincero agradecimiento a la Universidad Privada Franz Tamayo – UNIFRANZ, por brindarme la oportunidad de formarme académicamente y por el acceso a los conocimientos que han sido clave en mi desarrollo profesional.

De igual manera, agradezco a mis docentes, quienes con su enseñanza, compromiso y dedicación han contribuido de manera significativa a mi formación.

Gracias a todos por la confianza y apoyo, que me motivan a seguir esforzándome para alcanzar nuevas metas.
]
