== 7.1 Diagrama de Flujo

El sistema de pedidos en línea "Restaurante Bambú" sigue el siguiente flujo general:

=== 7.1.1 Flujo Principal del Sistema

#figure(
  image("../diagrama1.png", width: 90%),
  caption: [Diagrama de flujo general del sistema de pedidos],
)

El proceso comienza cuando el cliente accede a la aplicación web. Los usuarios no autenticados pueden navegar por el menú y agregar productos al carrito. Para completar una compra, el cliente debe registrarse o iniciar sesión.

*Flujo de Pedido:*

1. *Navegación del Menú:* El cliente visualiza las categorías y productos disponibles
2. *Selección de Productos:* Agrega items al carrito de compras
3. *Autenticación:* Login o registro de usuario
4. *Checkout:* Confirmación de productos y datos de entrega
5. *Pago:* Procesamiento mediante Stripe
6. *Confirmación:* Generación de pedido y notificación
7. *Seguimiento:* El cliente puede ver el estado de su pedido
8. *Entrega:* El pedido es procesado y entregado

=== 7.1.2 Flujo Administrativo

#figure(
  image("../diagrama2.png", width: 90%),
  caption: [Diagrama de flujo del panel administrativo],
)

Los administradores tienen un panel dedicado para:

1. *Gestión de Productos:* CRUD de productos y categorías
2. *Gestión de Pedidos:* Visualización y actualización de estados
3. *Gestión de Usuarios:* Administración de permisos
4. *Reportes:* Análisis de ventas y estadísticas

=== 7.1.3 Flujo de Integración con Stripe

El sistema se integra con Stripe para procesamiento de pagos:

1. Cliente confirma pedido → Genera Stripe Checkout Session
2. Cliente completa pago en Stripe → Webhook notifica al servidor
3. Servidor valida el pago → Actualiza estado del pedido
4. Sistema envía confirmación al cliente

Este flujo garantiza la seguridad en las transacciones y permite rastrear los pagos de manera confiable.
