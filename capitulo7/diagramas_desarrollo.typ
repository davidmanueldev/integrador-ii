// Diagramas profesionales usando paquetes de Typst
// Este archivo contiene diagramas visuales del desarrollo

#import "../config/diagramas.typ": *

== 7.2 Diagramas de Desarrollo

=== 7.2.1 Diagrama de Casos de Uso

El siguiente diagrama muestra los actores principales y sus interacciones con el sistema:

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (15mm, 10mm),

      // Actores (izquierda)
      node((0, 1), [👤 *Cliente*], shape: circle, fill: rgb("#e3f2fd")),
      node((0, 4), [👨‍💼 *Admin*], shape: circle, fill: rgb("#fff3e0")),
      node((0, 6), [💳 *Stripe*], shape: circle, fill: rgb("#f3e5f5")),

      // Sistema (centro) - Casos de uso
      node((2, 0), [Ver Menú], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 10pt),
      node((2, 1), [Agregar Carrito], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 10pt),
      node((2, 2), [Realizar Pedido], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 10pt),
      node((2, 3), [Efectuar Pago], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 10pt),
      node((2, 4), [Gestionar Productos], shape: rect, fill: rgb("#fff8e1"), corner-radius: 10pt),
      node((2, 5), [Gestionar Pedidos], shape: rect, fill: rgb("#fff8e1"), corner-radius: 10pt),
      node((2, 6), [Procesar Pago], shape: rect, fill: rgb("#fce4ec"), corner-radius: 10pt),

      // Conexiones Cliente
      edge((0, 1), (2, 0), "->"),
      edge((0, 1), (2, 1), "->"),
      edge((0, 1), (2, 2), "->"),
      edge((0, 1), (2, 3), "->"),

      // Conexiones Admin
      edge((0, 4), (2, 4), "->"),
      edge((0, 4), (2, 5), "->"),

      // Conexiones Stripe
      edge((0, 6), (2, 6), "->"),
      edge((2, 3), (2, 6), "-->"),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama de Casos de Uso del Sistema de Pedidos],
)

#pagebreak()

=== 7.2.2 Diagrama de Secuencia - Proceso de Compra

El siguiente diagrama muestra la secuencia de interacciones durante el proceso de compra:

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (14mm, 6mm),

      // Participantes
      node((0, 0), [*Cliente*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 3pt),
      node((1, 0), [*Frontend*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 3pt),
      node((2, 0), [*AuthAPI*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 3pt),
      node((3, 0), [*OrderAPI*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 3pt),
      node((4, 0), [*Stripe*], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 3pt),
      node((5, 0), [*DB*], shape: rect, fill: rgb("#e1bee7"), corner-radius: 3pt),

      // Mensajes secuenciales
      node((0, 1), [1. Productos], shape: rect, fill: white, stroke: 0.5pt),
      node((1, 2), [2. Carrito], shape: rect, fill: white, stroke: 0.5pt),
      node((0, 3), [3. Checkout], shape: rect, fill: white, stroke: 0.5pt),
      node((2, 4), [4. JWT], shape: rect, fill: white, stroke: 0.5pt),
      node((3, 5), [5. Orden], shape: rect, fill: white, stroke: 0.5pt),
      node((5, 5), [Guarda], shape: rect, fill: rgb("#fff9c4"), stroke: 0.5pt),
      node((4, 6), [6. Session], shape: rect, fill: white, stroke: 0.5pt),
      node((1, 7), [7. Redirige], shape: rect, fill: white, stroke: 0.5pt),
      node((0, 8), [8. Paga], shape: rect, fill: rgb("#c8e6c9"), stroke: 0.5pt),
      node((4, 9), [9. Webhook], shape: rect, fill: white, stroke: 0.5pt),
      node((5, 9), [confirmed], shape: rect, fill: rgb("#a5d6a7"), stroke: 0.5pt),
      node((0, 10), [10. Email], shape: rect, fill: rgb("#b2dfdb"), stroke: 0.5pt),

      // Conexiones
      edge((0, 1), (1, 2), "->"),
      edge((0, 3), (1, 3), "->"),
      edge((1, 3), (2, 4), "->"),
      edge((2, 4), (1, 4), "-->"),
      edge((1, 4), (3, 5), "->"),
      edge((3, 5), (5, 5), "->"),
      edge((3, 5), (4, 6), "->"),
      edge((4, 6), (3, 6), "-->"),
      edge((3, 6), (1, 7), "-->"),
      edge((1, 7), (0, 8), "->"),
      edge((0, 8), (4, 9), "->"),
      edge((4, 9), (3, 9), "->"),
      edge((3, 9), (5, 9), "->"),
      edge((3, 9), (0, 10), "->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Secuencia del Proceso de Compra],
)

#pagebreak()

=== 7.2.3 Diagrama de Estados - Ciclo de Vida del Pedido

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (18mm, 12mm),

      // Estados (horizontal para mejor aprovechamiento)
      node((0, 0), [●], shape: circle, fill: black, stroke: none),
      node((1, 0), [*CARRITO*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),
      node((2, 0), [*PENDIENTE*], shape: rect, fill: rgb("#fff9c4"), corner-radius: 5pt),
      node((3, 0), [*CONFIRMADO*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((2, 1), [*CANCELADO*], shape: rect, fill: rgb("#ffcdd2"), corner-radius: 5pt),
      node((4, 0), [*PREPARACIÓN*], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((5, 0), [*LISTO*], shape: rect, fill: rgb("#b2dfdb"), corner-radius: 5pt),
      node((6, 0), [*EN_CAMINO*], shape: rect, fill: rgb("#d1c4e9"), corner-radius: 5pt),
      node((7, 0), [*ENTREGADO*], shape: rect, fill: rgb("#a5d6a7"), corner-radius: 5pt),
      node((8, 0), [◉], shape: circle, fill: black, stroke: 2pt),

      // Transiciones principales
      edge((0, 0), (1, 0), "->"),
      edge((1, 0), (2, 0), "->"),
      edge((2, 0), (3, 0), "->", label: [OK]),
      edge((2, 0), (2, 1), "->"),
      edge((3, 0), (4, 0), "->"),
      edge((4, 0), (5, 0), "->"),
      edge((5, 0), (6, 0), "->"),
      edge((6, 0), (7, 0), "->"),
      edge((7, 0), (8, 0), "->"),
    ),
    diagram-scale: 55%,
  ),
  caption: [Diagrama de Estados del Pedido],
)

#pagebreak()

=== 7.2.4 Diagrama Entidad-Relación (ER)

El siguiente diagrama muestra las entidades principales y sus relaciones en la base de datos:

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (25mm, 18mm),

      // Entidades
      node(
        (0, 0),
        align(left)[
          *USER* \
          ───── \
          \_id (PK) \
          email \
          password \
          name, role
        ],
        shape: rect,
        fill: rgb("#e3f2fd"),
        stroke: 2pt,
      ),

      node(
        (1, 0),
        align(left)[
          *ORDER* \
          ───── \
          \_id (PK) \
          user (FK) \
          total \
          status
        ],
        shape: rect,
        fill: rgb("#fff3e0"),
        stroke: 2pt,
      ),

      node(
        (2, 0),
        align(left)[
          *ORDER_ITEM* \
          ───── \
          product (FK) \
          name \
          price \
          quantity
        ],
        shape: rect,
        fill: rgb("#fce4ec"),
        stroke: 2pt,
      ),

      node(
        (0, 1),
        align(left)[
          *CATEGORY* \
          ───── \
          \_id (PK) \
          name \
          description
        ],
        shape: rect,
        fill: rgb("#e8f5e9"),
        stroke: 2pt,
      ),

      node(
        (1, 1),
        align(left)[
          *PRODUCT* \
          ───── \
          \_id (PK) \
          category (FK) \
          name, price \
          available
        ],
        shape: rect,
        fill: rgb("#b2dfdb"),
        stroke: 2pt,
      ),

      // Relaciones con cardinalidad
      edge((0, 0), (1, 0), "->", label: [1:N]),
      edge((1, 0), (2, 0), "->", label: [1:N]),
      edge((0, 1), (1, 1), "->", label: [1:N]),
      edge((1, 1), (2, 0), "->", label: [1:N]),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama Entidad-Relación de la Base de Datos],
)

#pagebreak()

=== 7.2.5 Diagrama de Arquitectura del Sistema

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (18mm, 10mm),

      // Capa de Presentación
      node((1.5, 0), [*PRESENTACIÓN*], shape: rect, fill: rgb("#e3f2fd")),
      node((0, 1), [Next.js], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),
      node((1, 1), [React], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),
      node((2, 1), [Tailwind], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),
      node((3, 1), [Context], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),

      // Capa de Lógica
      node((1.5, 2), [*LÓGICA*], shape: rect, fill: rgb("#fff3e0")),
      node((0, 3), [Node.js], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((1, 3), [Express], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((2, 3), [JWT], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((3, 3), [API], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),

      // Capa de Datos
      node((1.5, 4), [*DATOS*], shape: rect, fill: rgb("#e8f5e9")),
      node((0, 5), [MongoDB], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 5), [Mongoose], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((2, 5), [AWS S3], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((3, 5), [Cloudinary], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),

      // Externos
      node((5, 2), [*EXTERNOS*], shape: rect, fill: rgb("#f3e5f5")),
      node((5, 3), [Stripe], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),
      node((5, 4), [Webhooks], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),

      // Conexiones entre capas
      edge((1.5, 1), (1.5, 2), "<->"),
      edge((1.5, 3), (1.5, 4), "<->"),
      edge((3, 3), (5, 3), "<->"),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama de Arquitectura de 3 Capas],
)

#pagebreak()

=== 7.2.6 Diagrama de Clases (Simplificado)

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      spacing: (28mm, 12mm),

      // Clase User
      node(
        (0, 0),
        align(left)[
          *User* \
          ──────── \
          - \_id \
          - email \
          - password \
          - name, role \
          ──────── \
          + auth() \
          + update()
        ],
        shape: rect,
        fill: rgb("#e3f2fd"),
      ),

      // Clase Product
      node(
        (1, 0),
        align(left)[
          *Product* \
          ──────── \
          - \_id \
          - name \
          - price \
          - category \
          ──────── \
          + toggle() \
          + setPrice()
        ],
        shape: rect,
        fill: rgb("#e8f5e9"),
      ),

      // Clase Order
      node(
        (2, 0),
        align(left)[
          *Order* \
          ──────── \
          - \_id \
          - user \
          - items \
          - total, status \
          ──────── \
          + calcTotal() \
          + setStatus()
        ],
        shape: rect,
        fill: rgb("#fff3e0"),
      ),

      // Clase Category
      node(
        (0, 1),
        align(left)[
          *Category* \
          ──────── \
          - \_id \
          - name \
          - description \
          ──────── \
          + add() \
          + remove()
        ],
        shape: rect,
        fill: rgb("#fce4ec"),
      ),

      // Relaciones
      edge((0, 0), (2, 0), "->", label: [1..n]),
      edge((0, 1), (1, 0), "->", label: [1..n]),
      edge((1, 0), (2, 0), "->", label: [n..n]),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama de Clases del Sistema],
)
