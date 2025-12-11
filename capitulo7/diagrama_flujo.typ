// Diagramas de flujo del sistema usando fletcher
#import "../config/diagramas.typ": *

== 7.1 Diagrama de Flujo

El sistema de pedidos en línea "Restaurante Bambú" sigue el siguiente flujo general:

=== 7.1.1 Mapa Navegacional del Sistema

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (12mm, 10mm),

      // Inicio
      node((2, 0), [*Inicio del Sistema*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 5pt),

      // Página de Inicio
      node((2, 1), [*Página de Inicio*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),

      // Ramas principales desde HomePage
      node((0, 2), [*Visualizar Menú*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((2, 2), [*Info Restaurante*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 5pt),
      node((4, 2), [*Registro*], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),

      // Sub-ramas de Menú
      node((-1, 3), [Detalles Producto], shape: rect, fill: rgb("#dcedc8"), corner-radius: 5pt),
      node((0, 3), [Búsqueda], shape: rect, fill: rgb("#dcedc8"), corner-radius: 5pt),
      node((1, 3), [Filtrar Categoría], shape: rect, fill: rgb("#dcedc8"), corner-radius: 5pt),

      // Sub-sub-ramas de Detalles
      node((-1.5, 4), [Descripción], shape: rect, fill: rgb("#f1f8e9"), corner-radius: 5pt),
      node((-0.5, 4), [Precio], shape: rect, fill: rgb("#f1f8e9"), corner-radius: 5pt),
      node((1, 4), [Imagen], shape: rect, fill: rgb("#f1f8e9"), corner-radius: 5pt),

      // Sub-ramas de Info Restaurante
      node((1.5, 3), [Horarios], shape: rect, fill: rgb("#fff8e1"), corner-radius: 5pt),
      node((2, 3), [Ubicación], shape: rect, fill: rgb("#fff8e1"), corner-radius: 5pt),
      node((2.5, 3), [Contacto], shape: rect, fill: rgb("#fff8e1"), corner-radius: 5pt),

      // Sub-ramas de Registro
      node((3.5, 3), [Form Registro], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 5pt),
      node((3.5, 4), [Validación], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 5pt),
      node((3.5, 5), [Confirmación], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 5pt),
      node((4.5, 5), [*Login*], shape: rect, fill: rgb("#fff9c4"), corner-radius: 5pt),

      // Sub-ramas de Login
      node((4.5, 6), [Form Login], shape: rect, fill: rgb("#fffde7"), corner-radius: 5pt),
      node((4.5, 7), [Autenticación], shape: rect, fill: rgb("#fffde7"), corner-radius: 5pt),
      node((4.5, 8), [*Panel Cliente*], shape: rect, fill: rgb("#a5d6a7"), corner-radius: 5pt),

      // Conexiones principales
      edge((2, 0), (2, 1), "->"),
      edge((2, 1), (0, 2), "->"),
      edge((2, 1), (2, 2), "->"),
      edge((2, 1), (4, 2), "->"),

      // Conexiones Menú
      edge((0, 2), (-1, 3), "->"),
      edge((0, 2), (0, 3), "->"),
      edge((0, 2), (1, 3), "->"),
      edge((-1, 3), (-1.5, 4), "->"),
      edge((-1, 3), (-0.5, 4), "->"),
      edge((1, 3), (1, 4), "->"),

      // Conexiones Info Restaurante
      edge((2, 2), (1.5, 3), "->"),
      edge((2, 2), (2, 3), "->"),
      edge((2, 2), (2.5, 3), "->"),

      // Conexiones Registro
      edge((4, 2), (3.5, 3), "->"),
      edge((3.5, 3), (3.5, 4), "->"),
      edge((3.5, 4), (3.5, 5), "->"),
      edge((3.5, 5), (4.5, 5), "->"),

      // Conexiones Login
      edge((4.5, 5), (4.5, 6), "->"),
      edge((4.5, 6), (4.5, 7), "->"),
      edge((4.5, 7), (4.5, 8), "->"),
    ),
    diagram-scale: 55%,
  ),
  caption: [Mapa Navegacional del Sistema - Restaurante Bambú],
)

#pagebreak()

=== 7.1.2 Flujo de Proceso de Compra

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (18mm, 8mm),

      // Inicio
      node((1, 0), [●], shape: circle, fill: black, stroke: none),

      // Flujo principal
      node((1, 1), [*Accede a App*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 5pt),
      node((1, 2), [*Navega Menú*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 5pt),
      node((1, 3), [*Selecciona*], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 5pt),
      node((1, 4), [*Agrega Carrito*], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 5pt),
      node((1, 5), [¿Auth?], shape: diamond, fill: rgb("#fff9c4")),

      // Rama de autenticación
      node((0, 5), [*Login*], shape: rect, fill: rgb("#ffecb3"), corner-radius: 5pt),

      // Continúa flujo
      node((1, 6), [*Checkout*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 7), [*Datos Envío*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 8), [*Pago Stripe*], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),
      node((1, 9), [¿OK?], shape: diamond, fill: rgb("#fff9c4")),

      // Ramas del pago
      node((0, 9), [*Error*], shape: rect, fill: rgb("#ffcdd2"), corner-radius: 5pt),
      node((1, 10), [*Confirmar*], shape: rect, fill: rgb("#a5d6a7"), corner-radius: 5pt),
      node((1, 11), [*Notificar*], shape: rect, fill: rgb("#b2dfdb"), corner-radius: 5pt),

      // Fin
      node((1, 12), [◉], shape: circle, fill: black, stroke: 2pt),

      // Conexiones principales
      edge((1, 0), (1, 1), "->"),
      edge((1, 1), (1, 2), "->"),
      edge((1, 2), (1, 3), "->"),
      edge((1, 3), (1, 4), "->"),
      edge((1, 4), (1, 5), "->"),
      edge((1, 5), (0, 5), "->", label: [No]),
      edge((0, 5), (1, 6), "->"),
      edge((1, 5), (1, 6), "->", label: [Sí]),
      edge((1, 6), (1, 7), "->"),
      edge((1, 7), (1, 8), "->"),
      edge((1, 8), (1, 9), "->"),
      edge((1, 9), (0, 9), "->", label: [No]),
      edge((0, 9), (1, 8), "->"),
      edge((1, 9), (1, 10), "->", label: [Sí]),
      edge((1, 10), (1, 11), "->"),
      edge((1, 11), (1, 12), "->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Flujo - Proceso de Compra del Cliente],
)

#pagebreak()

=== 7.1.3 Flujo Administrativo - Gestión de Productos

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (18mm, 10mm),

      // Inicio
      node((1, 0), [●], shape: circle, fill: black, stroke: none),

      // Autenticación admin
      node((1, 1), [*Login Admin*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 5pt),
      node((1, 2), [¿Admin?], shape: diamond, fill: rgb("#fff9c4")),
      node((0, 2), [*Denegado*], shape: rect, fill: rgb("#ffcdd2"), corner-radius: 5pt),

      // Panel admin
      node((1, 3), [*Dashboard*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 5pt),
      node((1, 4), [¿Acción?], shape: diamond, fill: rgb("#e1bee7")),

      // Acciones
      node((0, 4), [*Productos*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((2, 4), [*Pedidos*], shape: rect, fill: rgb("#b2dfdb"), corner-radius: 5pt),
      node((0, 5), [CRUD], shape: rect, fill: rgb("#dcedc8"), corner-radius: 5pt),
      node((2, 5), [Estado], shape: rect, fill: rgb("#b2ebf2"), corner-radius: 5pt),

      // Convergencia
      node((1, 6), [*Guardar*], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 5pt),
      node((1, 7), [◉], shape: circle, fill: black, stroke: 2pt),

      // Conexiones
      edge((1, 0), (1, 1), "->"),
      edge((1, 1), (1, 2), "->"),
      edge((1, 2), (0, 2), "->", label: [No]),
      edge((1, 2), (1, 3), "->", label: [Sí]),
      edge((1, 3), (1, 4), "->"),
      edge((1, 4), (0, 4), "->"),
      edge((1, 4), (2, 4), "->"),
      edge((0, 4), (0, 5), "->"),
      edge((2, 4), (2, 5), "->"),
      edge((0, 5), (1, 6), "->"),
      edge((2, 5), (1, 6), "->"),
      edge((1, 6), (1, 7), "->"),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama de Flujo - Panel Administrativo],
)

#pagebreak()

=== 7.1.4 Flujo de Integración con Stripe (Pagos)

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (12mm, 8mm),

      // Participantes (columnas)
      node((0, 0), [*Cliente*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 3pt),
      node((1, 0), [*Frontend*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 3pt),
      node((2, 0), [*Backend*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 3pt),
      node((3, 0), [*Stripe*], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 3pt),
      node((4, 0), [*DB*], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 3pt),

      // Líneas de vida
      node((0, 1), [Confirma], shape: rect, fill: white),
      node((1, 2), [POST], shape: rect, fill: white),
      node((2, 3), [Guarda], shape: rect, fill: white),
      node((4, 3), [pending], shape: rect, fill: rgb("#fff9c4")),
      node((2, 4), [Session], shape: rect, fill: white),
      node((3, 4), [ID], shape: rect, fill: rgb("#e1bee7")),
      node((1, 5), [Redirige], shape: rect, fill: white),
      node((0, 6), [Paga], shape: rect, fill: rgb("#c8e6c9")),
      node((3, 7), [Webhook], shape: rect, fill: rgb("#f3e5f5")),
      node((2, 7), [Valida], shape: rect, fill: white),
      node((4, 8), [confirmed], shape: rect, fill: rgb("#a5d6a7")),
      node((0, 9), [Email], shape: rect, fill: rgb("#b2dfdb")),

      // Conexiones
      edge((0, 1), (1, 2), "->"),
      edge((1, 2), (2, 3), "->"),
      edge((2, 3), (4, 3), "->"),
      edge((2, 4), (3, 4), "->"),
      edge((3, 4), (2, 4), "-->"),
      edge((2, 4), (1, 5), "-->"),
      edge((1, 5), (0, 6), "->"),
      edge((0, 6), (3, 7), "->"),
      edge((3, 7), (2, 7), "->"),
      edge((2, 7), (4, 8), "->"),
      edge((2, 7), (0, 9), "->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Secuencia - Integración con Stripe],
)

#pagebreak()

=== 7.1.5 Flujo de Datos del Sistema

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (22mm, 12mm),

      // Clientes
      node((0, 0), [🌐 *Browser*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 8pt),
      node((0, 1), [📱 *Mobile*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 8pt),

      // Frontend
      node((1, 0.5), [*Next.js*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 8pt),

      // API Gateway
      node((2, 0.5), [*API REST*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 8pt),

      // Servicios
      node((3, 0), [*Auth*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 8pt),
      node((3, 1), [*Orders*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 8pt),
      node((3, 2), [*Products*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 8pt),

      // Base de datos
      node((4, 1), [🗄️ *MongoDB*], shape: rect, fill: rgb("#e1bee7"), corner-radius: 8pt),

      // Externos
      node((4, 0), [💳 *Stripe*], shape: rect, fill: rgb("#f8bbd9"), corner-radius: 8pt),
      node((4, 2), [☁️ *S3*], shape: rect, fill: rgb("#b2ebf2"), corner-radius: 8pt),

      // Conexiones
      edge((0, 0), (1, 0.5), "->"),
      edge((0, 1), (1, 0.5), "->"),
      edge((1, 0.5), (2, 0.5), "<->"),
      edge((2, 0.5), (3, 0), "<->"),
      edge((2, 0.5), (3, 1), "<->"),
      edge((2, 0.5), (3, 2), "<->"),
      edge((3, 0), (4, 1), "<->"),
      edge((3, 1), (4, 1), "<->"),
      edge((3, 1), (4, 0), "<->"),
      edge((3, 2), (4, 1), "<->"),
      edge((3, 2), (4, 2), "<->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Flujo de Datos del Sistema],
)
