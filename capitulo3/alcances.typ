== 3.2 Alcances

=== 3.2.1 Alcance Temático

El proyecto abarca el desarrollo integral de un sistema de gestión para restaurante que incluye:

- *Módulo de Reservaciones:* Calendario interactivo, gestión de mesas, confirmaciones automáticas, lista de espera y panel administrativo de reservaciones.
- *Módulo de Punto de Venta (POS):* Registro de pedidos por mesa, gestión de estados de orden, división de cuenta, generación de tickets y control de caja.
- *Módulo de Pagos:* Integración con Red Enlace CyberSource para pagos con tarjeta de débito/crédito, código QR Simple y registro de pagos en efectivo.
- *Módulo Administrativo:* Gestión de menú, mesas, usuarios, reportes de ventas y configuración del sistema.
- *Funcionalidades de IA:*
  - Chatbot inteligente con búsqueda semántica para consultas de menú y disponibilidad
  - Sistema de recomendación de platillos basado en preferencias
  - Predicción de demanda por día y hora
  - Análisis de sentimiento sobre reseñas de clientes

=== 3.2.2 Alcance Geográfico

La implementación del sistema se circunscribe a las operaciones del Restaurante Bambú en su ubicación de El Alto, La Paz, Bolivia. El sistema está diseñado específicamente para el contexto boliviano:

- Integración con pasarela de pagos local (Red Enlace)
- Moneda boliviana (BOB)
- Cumplimiento de regulaciones ASFI
- Idioma español

=== 3.2.3 Límites

El sistema no incluye:

- *Delivery o pedidos para llevar:* El sistema se enfoca exclusivamente en servicio presencial en el restaurante (no hay personal disponible para delivery).
- *Aplicaciones móviles nativas:* Se limita a una aplicación web responsiva, sin desarrollo de apps iOS/Android.
- *Múltiples sucursales:* El sistema está diseñado para una única ubicación.
- *Integración con sistemas contables externos:* No incluye conexión con SIAT o sistemas de facturación electrónica en esta fase.
- *Integración con plataformas de delivery:* No incluye conexión con PedidosYa, Rappi u otros servicios similares.
- *Rastreo GPS:* No aplica al no incluir funcionalidad de delivery.
