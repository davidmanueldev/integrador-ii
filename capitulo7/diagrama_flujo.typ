// Diagramas de flujo del sistema usando fletcher
#import "../config/diagramas.typ": *

== 7.1 Diagrama de Flujo

El Sistema Integral de Gestión para Restaurante Bambú sigue el siguiente flujo general:

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
      node((2, 2), [*Hacer Reservación*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 5pt),
      node((4, 2), [*Chatbot IA*], shape: rect, fill: rgb("#e1bee7"), corner-radius: 5pt),

      // Sub-ramas de Menú
      node((-1, 3), [Detalles Producto], shape: rect, fill: rgb("#dcedc8"), corner-radius: 5pt),
      node((0, 3), [Búsqueda], shape: rect, fill: rgb("#dcedc8"), corner-radius: 5pt),
      node((1, 3), [Filtrar Categoría], shape: rect, fill: rgb("#dcedc8"), corner-radius: 5pt),

      // Sub-sub-ramas de Detalles
      node((-1.5, 4), [Descripción], shape: rect, fill: rgb("#f1f8e9"), corner-radius: 5pt),
      node((-0.5, 4), [Precio], shape: rect, fill: rgb("#f1f8e9"), corner-radius: 5pt),
      node((1, 4), [Imagen], shape: rect, fill: rgb("#f1f8e9"), corner-radius: 5pt),

      // Sub-ramas de Reservación
      node((1.5, 3), [Calendario], shape: rect, fill: rgb("#fff8e1"), corner-radius: 5pt),
      node((2, 3), [Seleccionar Mesa], shape: rect, fill: rgb("#fff8e1"), corner-radius: 5pt),
      node((2.5, 3), [Confirmar], shape: rect, fill: rgb("#fff8e1"), corner-radius: 5pt),

      // Sub-ramas de Chatbot
      node((3.5, 3), [Consultas Menú], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 5pt),
      node((3.5, 4), [Recomendaciones], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 5pt),
      node((3.5, 5), [Info Restaurante], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 5pt),
      node((4.5, 5), [*Login*], shape: rect, fill: rgb("#fff9c4"), corner-radius: 5pt),

      // Sub-ramas de Login
      node((4.5, 6), [Form Login], shape: rect, fill: rgb("#fffde7"), corner-radius: 5pt),
      node((4.5, 7), [Autenticación], shape: rect, fill: rgb("#fffde7"), corner-radius: 5pt),
      node((4.5, 8), [*Panel Usuario*], shape: rect, fill: rgb("#a5d6a7"), corner-radius: 5pt),

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

      // Conexiones Reservación
      edge((2, 2), (1.5, 3), "->"),
      edge((2, 2), (2, 3), "->"),
      edge((2, 2), (2.5, 3), "->"),

      // Conexiones Chatbot
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

=== 7.1.2 Flujo de Proceso de Reservación

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (18mm, 8mm),

      // Inicio
      node((1, 0), [●], shape: circle, fill: black, stroke: none),

      // Flujo principal
      node((1, 1), [*Accede a Web*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 5pt),
      node((1, 2), [*Selecciona Fecha*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 5pt),
      node((1, 3), [*Ve Disponibilidad*], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 5pt),
      node((1, 4), [*Elige Mesa/Hora*], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 5pt),
      node((1, 5), [¿Auth?], shape: diamond, fill: rgb("#fff9c4")),

      // Rama de autenticación
      node((0, 5), [*Login*], shape: rect, fill: rgb("#ffecb3"), corner-radius: 5pt),

      // Continúa flujo
      node((1, 6), [*Ingresa Datos*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 7), [*Confirmar*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 8), [¿OK?], shape: diamond, fill: rgb("#fff9c4")),

      // Ramas de confirmación
      node((0, 8), [*Error*], shape: rect, fill: rgb("#ffcdd2"), corner-radius: 5pt),
      node((1, 9), [*Guarda BD*], shape: rect, fill: rgb("#a5d6a7"), corner-radius: 5pt),
      node((1, 10), [*Email Confirm*], shape: rect, fill: rgb("#b2dfdb"), corner-radius: 5pt),

      // Fin
      node((1, 11), [◉], shape: circle, fill: black, stroke: 2pt),

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
      edge((1, 8), (0, 8), "->", label: [No]),
      edge((0, 8), (1, 4), "->"),
      edge((1, 8), (1, 9), "->", label: [Sí]),
      edge((1, 9), (1, 10), "->"),
      edge((1, 10), (1, 11), "->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Flujo - Proceso de Reservación del Cliente],
)

#pagebreak()

=== 7.1.3 Flujo del Punto de Venta (POS) - Pedido Presencial

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (18mm, 10mm),

      // Inicio
      node((1, 0), [●], shape: circle, fill: black, stroke: none),

      // Autenticación mesero
      node((1, 1), [*Login Mesero*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 5pt),
      node((1, 2), [¿Autorizado?], shape: diamond, fill: rgb("#fff9c4")),
      node((0, 2), [*Denegado*], shape: rect, fill: rgb("#ffcdd2"), corner-radius: 5pt),

      // Panel POS
      node((1, 3), [*Panel POS*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 5pt),
      node((1, 4), [*Selecciona Mesa*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 5), [*Agrega Productos*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 5pt),
      node((1, 6), [*Envía a Cocina*], shape: rect, fill: rgb("#ffe0b2"), corner-radius: 5pt),
      node((1, 7), [*Cocina Prepara*], shape: rect, fill: rgb("#fff9c4"), corner-radius: 5pt),
      node((1, 8), [*Marca Listo*], shape: rect, fill: rgb("#b2dfdb"), corner-radius: 5pt),
      node((1, 9), [*Entrega Mesa*], shape: rect, fill: rgb("#a5d6a7"), corner-radius: 5pt),

      // Convergencia
      node((1, 10), [◉], shape: circle, fill: black, stroke: 2pt),

      // Conexiones
      edge((1, 0), (1, 1), "->"),
      edge((1, 1), (1, 2), "->"),
      edge((1, 2), (0, 2), "->", label: [No]),
      edge((1, 2), (1, 3), "->", label: [Sí]),
      edge((1, 3), (1, 4), "->"),
      edge((1, 4), (1, 5), "->"),
      edge((1, 5), (1, 6), "->"),
      edge((1, 6), (1, 7), "->"),
      edge((1, 7), (1, 8), "->"),
      edge((1, 8), (1, 9), "->"),
      edge((1, 9), (1, 10), "->"),
    ),
    diagram-scale: 70%,
  ),
  caption: [Diagrama de Flujo - Punto de Venta (POS)],
)

#pagebreak()

=== 7.1.4 Flujo de Integración de Pagos

#figure(
  scaled-diagram(
    flow-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: (12mm, 8mm),

      // Participantes (columnas)
      node((0, 0), [*Mesero*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 3pt),
      node((1, 0), [*POS*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 3pt),
      node((2, 0), [*API*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 3pt),
      node((3, 0), [*Pago*], shape: rect, fill: rgb("#f3e5f5"), corner-radius: 3pt),
      node((4, 0), [*Supabase*], shape: rect, fill: rgb("#e8f5e9"), corner-radius: 3pt),

      // Líneas de vida
      node((0, 1), [Solicita cuenta], shape: rect, fill: white),
      node((1, 2), [Calcula total], shape: rect, fill: white),
      node((0, 3), [Elige método], shape: rect, fill: rgb("#fff9c4")),
      node((2, 4), [Procesa], shape: rect, fill: white),
      
      // Métodos de pago
      node((3, 4), [Tarjeta/QR/Efectivo], shape: rect, fill: rgb("#e1bee7")),
      
      node((2, 5), [Valida], shape: rect, fill: white),
      node((4, 6), [Actualiza], shape: rect, fill: rgb("#c8e6c9")),
      node((4, 7), [pagado: true], shape: rect, fill: rgb("#a5d6a7")),
      node((1, 8), [Imprime], shape: rect, fill: white),
      node((0, 9), [Recibo], shape: rect, fill: rgb("#b2dfdb")),

      // Conexiones
      edge((0, 1), (1, 2), "->"),
      edge((1, 2), (0, 3), "->"),
      edge((0, 3), (1, 3), "->"),
      edge((1, 3), (2, 4), "->"),
      edge((2, 4), (3, 4), "->"),
      edge((3, 4), (2, 5), "-->"),
      edge((2, 5), (4, 6), "->"),
      edge((4, 6), (4, 7), "->"),
      edge((4, 7), (2, 7), "-->"),
      edge((2, 7), (1, 8), "-->"),
      edge((1, 8), (0, 9), "->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Secuencia - Proceso de Pago],
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
      node((0, 0), [🌐 *Web Cliente*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 8pt),
      node((0, 1), [📱 *POS Mesero*], shape: rect, fill: rgb("#e3f2fd"), corner-radius: 8pt),

      // Frontend
      node((1, 0.5), [*Next.js 14*], shape: rect, fill: rgb("#bbdefb"), corner-radius: 8pt),

      // API Gateway
      node((2, 0.5), [*API Routes*], shape: rect, fill: rgb("#fff3e0"), corner-radius: 8pt),

      // Servicios
      node((3, 0), [*Reservaciones*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 8pt),
      node((3, 1), [*Pedidos/POS*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 8pt),
      node((3, 2), [*Chatbot IA*], shape: rect, fill: rgb("#c8e6c9"), corner-radius: 8pt),

      // Base de datos
      node((4, 1), [🗄️ *Supabase*], shape: rect, fill: rgb("#e1bee7"), corner-radius: 8pt),

      // Externos
      node((4, 0), [💳 *Red Enlace*], shape: rect, fill: rgb("#f8bbd9"), corner-radius: 8pt),
      node((4, 2), [✉️ *Resend*], shape: rect, fill: rgb("#b2ebf2"), corner-radius: 8pt),

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
      edge((3, 0), (4, 2), "<->"),
      edge((3, 2), (4, 1), "<->"),
    ),
    diagram-scale: 65%,
  ),
  caption: [Diagrama de Flujo de Datos del Sistema],
)
