== 7.2 Diagramas de Desarrollo

=== 7.2.1 Diagrama de Casos de Uso

Los casos de uso principales del sistema son:

*Actores:*
- Cliente (Usuario no autenticado)
- Cliente Registrado (Usuario autenticado)
- Administrador
- Sistema de Pago (Stripe)

*Casos de Uso del Cliente:*
- Ver menú y productos
- Registrarse en el sistema
- Iniciar sesión
- Agregar productos al carrito
- Modificar carrito de compras
- Realizar checkout
- Efectuar pago
- Ver historial de pedidos
- Rastrear estado de pedido

*Casos de Uso del Administrador:*
- Gestionar categorías (CRUD)
- Gestionar productos (CRUD)
- Ver todos los pedidos
- Actualizar estado de pedidos
- Gestionar usuarios
- Ver estadísticas y reportes

=== 7.2.2 Diagrama de Secuencia

*Secuencia: Proceso de Compra*

```
Cliente -> Frontend: Selecciona productos
Frontend -> Carrito: Agrega items
Cliente -> Frontend: Procede a checkout
Frontend -> AuthAPI: Verifica autenticación
AuthAPI -> Frontend: Token válido
Frontend -> OrderAPI: Crea orden temporal
OrderAPI -> StripeAPI: Crea checkout session
StripeAPI -> OrderAPI: Session ID
OrderAPI -> Frontend: Retorna session URL
Frontend -> Cliente: Redirige a Stripe
Cliente -> Stripe: Completa pago
Stripe -> OrderAPI: Webhook de confirmación
OrderAPI -> Database: Actualiza estado orden
OrderAPI -> Cliente: Envía notificación
```

*Secuencia: Gestión de Productos (Admin)*

```
Admin -> Frontend: Accede a panel admin
Frontend -> AuthAPI: Verifica permisos
AuthAPI -> Frontend: Rol = admin
Admin -> Frontend: Crea producto
Frontend -> ProductAPI: POST /api/products
ProductAPI -> ImageAPI: Sube imagen a S3
ImageAPI -> ProductAPI: URL de imagen
ProductAPI -> Database: Inserta producto
Database -> ProductAPI: Producto creado
ProductAPI -> Frontend: Respuesta exitosa
Frontend -> Admin: Muestra confirmación
```

=== 7.2.3 Diagrama de Estados

*Estados de un Pedido:*

```
[Inicial] -> CARRITO
   |
   v
PENDIENTE (orden creada, esperando pago)
   |
   +-> CANCELADO (pago fallido o timeout)
   |
   v
CONFIRMADO (pago exitoso)
   |
   v
EN_PREPARACION (cocina trabajando)
   |
   v
LISTO (listo para entrega)
   |
   v
EN_CAMINO (delivery en proceso)
   |
   v
ENTREGADO [Final]
```

*Estados de un Producto:*

```
ACTIVO (visible en menú)
   |
   +-> INACTIVO (oculto temporalmente)
   |
   +-> AGOTADO (sin stock)
   |
   +-> ELIMINADO (soft delete)
```

=== 7.2.4 Diagrama de Clases

*Entidades Principales:*

```typescript
class User {
  _id: ObjectId
  email: string
  password: string (hashed)
  name: string
  phone?: string
  address?: Address
  role: 'client' | 'admin'
  createdAt: Date

  + authenticate()
  + updateProfile()
}

class Product {
  _id: ObjectId
  name: string
  description: string
  price: number
  category: ObjectId -> Category
  image: string (S3 URL)
  available: boolean
  createdAt: Date

  + toggleAvailability()
  + updatePrice()
}

class Category {
  _id: ObjectId
  name: string
  description: string
  products: Product[]

  + addProduct()
  + removeProduct()
}

class Order {
  _id: ObjectId
  user: ObjectId -> User
  items: CartItem[]
  total: number
  status: OrderStatus
  paymentId: string
  deliveryAddress: Address
  createdAt: Date

  + calculateTotal()
  + updateStatus()
  + processPayment()
}

class CartItem {
  product: ObjectId -> Product
  quantity: number
  price: number

  + getSubtotal()
}
```

*Relaciones:*
- User `1 --- *` Order (Un usuario tiene muchos pedidos)
- Order `1 --- *` CartItem (Un pedido contiene múltiples items)
- CartItem `* --- 1` Product (Cada item referencia un producto)
- Category `1 --- *` Product (Una categoría agrupa productos)


#figure(
  image("../diagrama3.png", width: 90%),
  caption: [Diagrama de relación entre entidades principales],
)
