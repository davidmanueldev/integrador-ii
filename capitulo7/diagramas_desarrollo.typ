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
      node((0, 3), [🍽️ *Mesero*], shape: circle, fill: rgb("#c8e6c9")),
      node((0, 5), [👨‍💼 *Admin*], shape: circle, fill: rgb("#fff3e0")),
      node((0, 7), [💳 *Red Enlace*], shape: circle, fill: rgb("#f3e5f5")),

      // Sistema (centro) - Casos de uso
      node((2, 0), [Ver Menú], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 10pt),
      node((2, 1), [Hacer Reservación], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 10pt),
      node((2, 2), [Consultar Chatbot], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 10pt),
      node((2, 3), [Tomar Pedido], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 10pt),
      node((2, 4), [Gestionar Mesas], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 10pt),
      node((2, 5), [Gestionar Productos], shape: rect, fill: rgb("#fff8e1"), corner-radius: 10pt),
      node((2, 6), [Gestionar Reservaciones], shape: rect, fill: rgb("#fff8e1"), corner-radius: 10pt),
      node((2, 7), [Procesar Pago], shape: rect, fill: rgb("#fce4ec"), corner-radius: 10pt),

      // Conexiones Cliente
      edge((0, 1), (2, 0), "->"),
      edge((0, 1), (2, 1), "->"),
      edge((0, 1), (2, 2), "->"),

      // Conexiones Mesero
      edge((0, 3), (2, 3), "->"),
      edge((0, 3), (2, 4), "->"),

      // Conexiones Admin
      edge((0, 5), (2, 5), "->"),
      edge((0, 5), (2, 6), "->"),

      // Conexiones Red Enlace
      edge((0, 7), (2, 7), "->"),
      edge((2, 3), (2, 7), "-->"),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama de Casos de Uso del Sistema de Gestión],
)

#pagebreak()

=== 7.2.2 Diagrama de Secuencia - Proceso de Reservación

El siguiente diagrama muestra la secuencia de interacciones durante el proceso de reservación:

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (14mm, 6mm),

      // Participantes
      node((0, 0), [*Cliente*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 3pt),
      node((1, 0), [*Frontend*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 3pt),
      node((2, 0), [*API*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 3pt),
      node((3, 0), [*Supabase*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 3pt),
      node((4, 0), [*Resend*], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 3pt),

      // Mensajes secuenciales
      node((0, 1), [1. Selecciona fecha], shape: rect, fill: white, stroke: 0.5pt),
      node((1, 2), [2. Consulta mesas], shape: rect, fill: white, stroke: 0.5pt),
      node((3, 2), [Disponibles], shape: rect, fill: rgb("#c8e6c9"), stroke: 0.5pt),
      node((0, 3), [3. Elige mesa/hora], shape: rect, fill: white, stroke: 0.5pt),
      node((2, 4), [4. Valida], shape: rect, fill: white, stroke: 0.5pt),
      node((3, 5), [5. Guarda], shape: rect, fill: rgb("#fff9c4"), stroke: 0.5pt),
      node((4, 6), [6. Email], shape: rect, fill: rgb("#e1bee7"), stroke: 0.5pt),
      node((0, 7), [7. Confirmación], shape: rect, fill: rgb("#a5d6a7"), stroke: 0.5pt),

      // Conexiones
      edge((0, 1), (1, 2), "->"),
      edge((1, 2), (2, 2), "->"),
      edge((2, 2), (3, 2), "->"),
      edge((3, 2), (2, 2), "-->"),
      edge((2, 2), (1, 2), "-->"),
      edge((0, 3), (1, 3), "->"),
      edge((1, 3), (2, 4), "->"),
      edge((2, 4), (3, 5), "->"),
      edge((3, 5), (2, 5), "-->"),
      edge((2, 5), (4, 6), "->"),
      edge((4, 6), (0, 7), "->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Secuencia del Proceso de Reservación],
)

#pagebreak()

=== 7.2.3 Diagrama de Estados - Ciclo de Vida del Pedido Presencial

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (20mm, 12mm),

      // Estados (horizontal para mejor aprovechamiento)
      node((0, 0), [●], shape: circle, fill: black, stroke: none),
      node((1, 0), [*PENDIENTE*], shape: rect, fill: rgb("#fff9c4"), corner-radius: 5pt),
      node((2, 0), [*EN_PREPARACIÓN*], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((3, 0), [*LISTO*], shape: rect, fill: rgb("#b2dfdb"), corner-radius: 5pt),
      node((4, 0), [*ENTREGADO*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((5, 0), [*PAGADO*], shape: rect, fill: rgb("#a5d6a7"), corner-radius: 5pt),
      node((6, 0), [◉], shape: circle, fill: black, stroke: 2pt),
      node((2, 1), [*CANCELADO*], shape: rect, fill: rgb("#ffcdd2"), corner-radius: 5pt),

      // Transiciones principales
      edge((0, 0), (1, 0), "->"),
      edge((1, 0), (2, 0), "->", label: [Cocina]),
      edge((1, 0), (2, 1), "->"),
      edge((2, 0), (3, 0), "->", label: [Listo]),
      edge((3, 0), (4, 0), "->", label: [Mesero]),
      edge((4, 0), (5, 0), "->", label: [Pago]),
      edge((5, 0), (6, 0), "->"),
    ),
    diagram-scale: 55%,
  ),
  caption: [Diagrama de Estados del Pedido Presencial],
)

#pagebreak()

=== 7.2.4 Diagrama Entidad-Relación (ER)

El siguiente diagrama muestra las entidades principales y sus relaciones en la base de datos PostgreSQL:

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
          id (PK) \
          email \
          rol \
          nombre
        ],
        shape: rect,
        fill: rgb("#e3f2fd"),
        stroke: 2pt,
      ),

      node(
        (1, 0),
        align(left)[
          *RESERVACION* \
          ───── \
          id (PK) \
          user_id (FK) \
          mesa_id (FK) \
          fecha, hora
        ],
        shape: rect,
        fill: rgb("#c8e6c9"),
        stroke: 2pt,
      ),

      node(
        (2, 0),
        align(left)[
          *MESA* \
          ───── \
          id (PK) \
          numero \
          capacidad \
          estado
        ],
        shape: rect,
        fill: rgb("#b2dfdb"),
        stroke: 2pt,
      ),

      node(
        (0, 1),
        align(left)[
          *PEDIDO* \
          ───── \
          id (PK) \
          user_id (FK) \
          mesa_id (FK) \
          total, estado
        ],
        shape: rect,
        fill: rgb("#fff3e0"),
        stroke: 2pt,
      ),

      node(
        (1, 1),
        align(left)[
          *PEDIDO_ITEM* \
          ───── \
          id (PK) \
          pedido_id (FK) \
          producto_id (FK) \
          cantidad, precio
        ],
        shape: rect,
        fill: rgb("#fce4ec"),
        stroke: 2pt,
      ),

      node(
        (2, 1),
        align(left)[
          *PRODUCTO* \
          ───── \
          id (PK) \
          categoria_id (FK) \
          nombre, precio \
          embedding
        ],
        shape: rect,
        fill: rgb("#e8f5e9"),
        stroke: 2pt,
      ),

      // Relaciones con cardinalidad
      edge((0, 0), (1, 0), "->", label: [1:N]),
      edge((1, 0), (2, 0), "->", label: [N:1]),
      edge((0, 0), (0, 1), "->", label: [1:N]),
      edge((0, 1), (2, 0), "->", label: [N:1]),
      edge((0, 1), (1, 1), "->", label: [1:N]),
      edge((1, 1), (2, 1), "->", label: [N:1]),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama Entidad-Relación de la Base de Datos PostgreSQL],
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
      node((0, 1), [Next.js 14], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),
      node((1, 1), [React 18], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),
      node((2, 1), [shadcn/ui], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),
      node((3, 1), [Tailwind], shape: rect, fill: rgb("#bbdefb"), corner-radius: 5pt),

      // Capa de Lógica
      node((1.5, 2), [*LÓGICA*], shape: rect, fill: rgb("#fff3e0")),
      node((0, 3), [API Routes], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((1, 3), [Prisma], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((2, 3), [Vercel AI], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((3, 3), [Zod], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),

      // Capa de Datos
      node((1.5, 4), [*DATOS*], shape: rect, fill: rgb("#e8f5e9")),
      node((0, 5), [PostgreSQL], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 5), [pgvector], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((2, 5), [Supabase Auth], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((3, 5), [Storage], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),

      // Externos
      node((5, 2), [*EXTERNOS*], shape: rect, fill: rgb("#f3e5f5")),
      node((5, 3), [Red Enlace], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),
      node((5, 4), [Resend], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),
      node((5, 5), [OpenAI], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),

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
          - id: UUID \
          - email: String \
          - nombre: String \
          - rol: Enum \
          ──────── \
          + auth() \
          + update()
        ],
        shape: rect,
        fill: rgb("#e3f2fd"),
      ),

      // Clase Producto
      node(
        (1, 0),
        align(left)[
          *Producto* \
          ──────── \
          - id: UUID \
          - nombre: String \
          - precio: Decimal \
          - embedding: Vector \
          ──────── \
          + toggle() \
          + buscar()
        ],
        shape: rect,
        fill: rgb("#e8f5e9"),
      ),

      // Clase Pedido
      node(
        (2, 0),
        align(left)[
          *Pedido* \
          ──────── \
          - id: UUID \
          - mesa_id: UUID \
          - items: Item[] \
          - total, estado \
          ──────── \
          + calcTotal() \
          + setEstado()
        ],
        shape: rect,
        fill: rgb("#fff3e0"),
      ),

      // Clase Reservacion
      node(
        (0, 1),
        align(left)[
          *Reservacion* \
          ──────── \
          - id: UUID \
          - fecha: Date \
          - hora: Time \
          - personas: Int \
          ──────── \
          + confirmar() \
          + cancelar()
        ],
        shape: rect,
        fill: rgb("#c8e6c9"),
      ),

      // Clase Mesa
      node(
        (1, 1),
        align(left)[
          *Mesa* \
          ──────── \
          - id: UUID \
          - numero: Int \
          - capacidad: Int \
          - estado: Enum \
          ──────── \
          + ocupar() \
          + liberar()
        ],
        shape: rect,
        fill: rgb("#b2dfdb"),
      ),

      // Relaciones
      edge((0, 0), (2, 0), "->", label: [1..n]),
      edge((0, 0), (0, 1), "->", label: [1..n]),
      edge((0, 1), (1, 1), "->", label: [n..1]),
      edge((1, 0), (2, 0), "->", label: [n..n]),
      edge((1, 1), (2, 0), "->", label: [1..n]),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama de Clases del Sistema],
)
