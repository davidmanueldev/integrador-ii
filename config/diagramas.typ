// Archivo de configuración para diagramas
// Importa paquetes de diagramas para usar en todo el proyecto

// Fletcher - Para todos los diagramas (flowcharts, arquitectura, estados, secuencia)
#import "@preview/fletcher:0.5.8": diagram, edge, node
#import "@preview/fletcher:0.5.8" as fletcher: shapes

// Re-exportar para uso en el proyecto
#let flow-diagram = diagram
#let flow-node = node
#let flow-edge = edge
#let diamond = shapes.diamond

// Función para escalar diagramas y que quepan en la página
#let scaled-diagram(content, diagram-scale: 65%) = {
  align(center)[
    #box(width: 100%)[
      #align(center)[
        #scale(x: diagram-scale, y: diagram-scale, content)
      ]
    ]
  ]
}

