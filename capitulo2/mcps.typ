== 2.4 Model Context Protocol (MCPs)

El Model Context Protocol (MCPs) representa una innovación fundamental en la forma en que sistemas de inteligencia artificial acceden y utilizan información contextual de fuentes externas. Desarrollado por Anthropic, MCP establece un protocolo estándar para conectar modelos de lenguaje (LLMs) con herramientas, datos y servicios mediante interfaces bien definidas (Anthropic, 2024).

=== 2.4.1 Fundamentos del Model Context Protocol

=== Motivación y Problemática Abordada

Tradicionalmente, los chatbots y asistentes virtuales operan con limitaciones significativas en cuanto al acceso a información actualizada:

*Información Estática*
- Los modelos de lenguaje se entrenan con datos hasta una fecha de corte específica
- No tienen conocimiento de eventos, datos o cambios posteriores a su entrenamiento
- Respuestas sobre información específica de un negocio deben ser "programadas" previamente en su base de conocimiento

*Desincronización de Datos*
- Cuando información del negocio cambia (precios de productos, disponibilidad, horarios), el chatbot no se actualiza automáticamente
- Requiere intervención manual para actualizar respuestas predefinidas
- Riesgo de proporcionar información incorrecta o desactualizada a usuarios

*Arquitecturas Monolíticas*
- La lógica del chatbot está acoplada con las fuentes de datos
- Cambios en datos requieren modificar y redesplegar el chatbot completo
- Dificulta mantenimiento y escalabilidad del sistema

=== Solución: Model Context Protocol

MCP resuelve estos problemas mediante un protocolo estandarizado que permite a modelos de IA conectarse dinámicamente con fuentes de datos externas:

*Separación de Responsabilidades*
- *Cliente MCP*: El sistema de IA (chatbot) que consume información
- *Servidor MCP*: Servicio que expone datos específicos mediante interfaz estandarizada
- *Protocolo MCP*: Especificación de comunicación entre cliente y servidor

*Acceso Dinámico a Datos*
- El chatbot consulta servidores MCP en tiempo de ejecución
- Siempre obtiene información actualizada directamente de la fuente de verdad
- No requiere reentrenamiento ni reconfiguración cuando datos cambian

*Arquitectura Modular*
- Agregar nuevas fuentes de datos solo requiere crear nuevo servidor MCP
- Múltiples aplicaciones pueden consumir los mismos servidores MCP
- Mantenimiento independiente de cada componente

=== 2.4.2 Arquitectura del Model Context Protocol

=== Componentes Principales

*Servidor MCP*

Un servidor MCP es un servicio que implementa el protocolo MCP para exponer datos o funcionalidades específicas. Responsabilidades:

- Definir recursos disponibles (catálogo de productos, información de pedidos, etc.)
- Implementar operaciones de consulta sobre esos recursos
- Validar peticiones y manejar errores
- Formatear respuestas según especificación MCP

Ejemplo conceptual de servidor MCP para menú de restaurante:

```javascript
class MenuMCPServer {
  // Registrar recursos disponibles
  async listResources() {
    return [
      { uri: "menu://productos", name: "Catálogo de Productos" },
      { uri: "menu://categorias", name: "Categorías de Productos" }
    ];
  }

  // Consultar recurso específico
  async readResource(uri) {
    if (uri === "menu://productos") {
      const productos = await obtenerProductosDisponibles();
      return { contents: productos };
    }
  }

  // Ejecutar operación (búsqueda, filtrado)
  async callTool(name, arguments) {
    if (name === "buscarProducto") {
      return buscarProductoPorNombre(arguments.nombre);
    }
  }
}
```

*Cliente MCP*

El cliente MCP es el componente que consume servidores MCP. En este proyecto, el chatbot actúa como cliente MCP:

```javascript
class MCPClient {
  constructor(mcpServers) {
    this.servers = mcpServers; // Lista de servidores MCP disponibles
  }

  async consultarMenu() {
    const menuServer = this.servers.find(s => s.name === 'menu');
    const productos = await menuServer.readResource('menu://productos');
    return productos;
  }

  async consultarEstadoPedido(numeroPedido) {
    const pedidosServer = this.servers.find(s => s.name === 'pedidos');
    const estado = await pedidosServer.callTool('consultarEstado', {
      numeroPedido: numeroPedido
    });
    return estado;
  }
}
```

*Protocolo de Comunicación*

MCP define mensajes estandarizados en formato JSON-RPC 2.0 para comunicación entre cliente y servidor:

```json
// Request: Listar recursos disponibles
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "resources/list",
  "params": {}
}

// Response: Recursos disponibles
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "resources": [
      {
        "uri": "menu://productos",
        "name": "Catálogo de Productos",
        "description": "Lista completa de productos disponibles"
      }
    ]
  }
}
```

=== Flujo de Interacción

1. *Inicialización*: Cliente MCP se conecta con servidores MCP disponibles
2. *Descubrimiento*: Cliente consulta qué recursos y operaciones ofrece cada servidor
3. *Consulta de Usuario*: Usuario hace pregunta al chatbot ("¿Cuál es el precio de la pizza?")
4. *Determinación de Servidor*: Chatbot identifica que requiere datos del servidor MCP de menú
5. *Petición MCP*: Chatbot envía petición al servidor MCP apropiado
6. *Procesamiento*: Servidor MCP consulta base de datos y formatea respuesta
7. *Respuesta MCP*: Servidor retorna datos solicitados
8. *Generación de Respuesta*: Chatbot utiliza datos obtenidos para generar respuesta en lenguaje natural
9. *Presentación*: Usuario recibe respuesta actualizada y precisa

== Métodos del Protocolo MCP

El protocolo MCP define varios métodos estándar:

=== Gestión de Recursos

*resources/list*
- Retorna lista de recursos disponibles en el servidor
- Cada recurso tiene URI único, nombre y descripción

*resources/read*
- Lee contenido de un recurso específico
- Parámetro: URI del recurso

=== Gestión de Herramientas (Tools)

*tools/list*
- Lista operaciones disponibles (búsqueda, filtrado, cálculos)
- Especifica parámetros requeridos para cada herramienta

*tools/call*
- Ejecuta una herramienta específica con parámetros dados
- Retorna resultado de la operación

=== Prompts

*prompts/list*
- Lista prompts predefinidos disponibles
- Útil para casos de uso comunes

*prompts/get*
- Obtiene un prompt específico con plantilla

== Ventajas de MCPs sobre Enfoques Tradicionales

=== Comparación: Chatbot Tradicional vs Chatbot con MCP

| Aspecto | Sin MCP | Con MCP |
|---------|---------|---------|
| *Actualización de datos* | Requiere modificar chatbot y redesplegar | Automática (servidor MCP lee BD actualizada) |
| *Consistencia* | Información puede desincronizarse | Siempre consulta fuente de verdad |
| *Mantenimiento* | Complejo, requiere conocimiento técnico | Modificar datos en base de datos |
| *Escalabilidad* | Agregar fuentes requiere modificar chatbot | Crear nuevo servidor MCP independiente |
| *Reutilización* | Lógica acoplada al chatbot específico | Servidores MCP usables por múltiples clientes |
| *Testing* | Difícil probar chatbot aisladamente | Cliente y servidores testables independientemente |

=== Arquitectura Tradicional

```
┌─────────────────────────────────────────┐
│           Chatbot Monolítico             │
│                                          │
│  ┌──────────────────────────────────┐   │
│  │ Base de Conocimiento Estática   │   │
│  │ - Productos: [....]              │   │
│  │ - Precios: [....]                │   │
│  │ - Horarios: [....]               │   │
│  └──────────────────────────────────┘   │
│                                          │
│  ┌──────────────────────────────────┐   │
│  │ Lógica de Procesamiento         │   │
│  └──────────────────────────────────┘   │
└─────────────────────────────────────────┘
```

Problema: Cambiar precio requiere modificar base de conocimiento, probar y redesplegar chatbot completo.

=== Arquitectura con MCP

```
┌──────────────┐          ┌───────────────────┐
│   Chatbot    │◄────────►│  Servidor MCP     │
│ (Cliente MCP)│          │     Menú          │
└─────┬────────┘          └─────────┬─────────┘
      │                             │
      │                      ┌──────▼─────┐
      │                      │ MongoDB    │
      │                      │ Productos  │
      │                      └────────────┘
      │
      │                   ┌───────────────────┐
      └──────────────────►│  Servidor MCP     │
                          │    Pedidos        │
                          └─────────┬─────────┘
                                    │
                             ┌──────▼─────┐
                             │ MongoDB    │
                             │ Pedidos    │
                             └────────────┘
```

Ventaja: Modificar precio solo requiere actualizar MongoDB. Servidor MCP refleja cambio automáticamente. Chatbot obtiene dato actualizado en próxima consulta.

== Casos de Uso de MCPs

=== Información Dinámica de Negocio

*Catálogo de Productos*
- Usuario: "¿Qué pastas tienen disponibles?"
- Chatbot consulta Servidor MCP de Menú
- Obtiene lista actual de pastas con precios y disponibilidad
- Genera respuesta con lista de pastas disponibles, sus precios y descripciones

*Disponibilidad en Tiempo Real*
- Usuario: "¿Está disponible el Tiramisu?"
- MCP consulta inventario actual
- Responde según disponibilidad en ese momento exacto

=== Consultas Transaccionales

*Estado de Pedidos*
- Usuario consulta sobre el estado de su pedido mediante un número de orden
- Chatbot llama Servidor MCP de Pedidos
- Consulta estado actual en base de datos
- Responde: "Tu pedido está en preparación, tiempo estimado 15 minutos"

*Historial de Compras*
- Usuario: "¿Qué pedí la última vez?"
- MCP accede a historial del usuario
- Retorna detalles del último pedido

=== Información Operativa

*Horarios y Políticas*
- Usuario: "¿Están abiertos el día de Navidad?"
- Servidor MCP de Información consulta calendario de días festivos
- Responde: "El restaurante estará cerrado el 25 de diciembre"

=== Análisis y Recomendaciones

*Productos Populares*
- Usuario: "¿Qué recomiendan?"
- MCP ejecuta consulta de productos con mejor valoración
- Chatbot sugiere opciones basadas en datos reales

== Implementación de Servidores MCP en el Proyecto

El Sistema de Pedidos en Línea implementa cuatro servidores MCP personalizados:

=== Servidor MCP de Menú

Recursos expuestos:
- `menu://productos`: Lista completa de productos
- `menu://categorias`: Categorías de productos
- `menu://producto/:id`: Detalles de producto específico

Herramientas:
- `buscarProducto(nombre)`: Búsqueda por nombre
- `filtrarPorCategoria(categoria)`: Productos de categoría específica
- `obtenerDestacados()`: Productos destacados

=== Servidor MCP de Inventario

Recursos:
- `inventario://disponibilidad`: Estado de disponibilidad de productos

Herramientas:
- `verificarDisponibilidad(productoId)`: Consulta si producto está disponible
- `obtenerStock(productoId)`: Cantidad disponible (si aplica)

=== Servidor MCP de Pedidos

Recursos:
- `pedidos://pedido/:numeroPedido`: Detalles de pedido específico

Herramientas:
- `consultarEstado(numeroPedido)`: Estado actual del pedido
- `obtenerDetalles(numeroPedido)`: Información completa del pedido

=== Servidor MCP de Información del Restaurante

Recursos:
- `info://horarios`: Horarios de atención
- `info://ubicacion`: Dirección y contacto
- `info://politicas`: Políticas de entrega y devoluciones
- `info://dias-festivos`: Calendario de cierres especiales

== Seguridad y Consideraciones de Implementación

=== Autenticación y Autorización

Los servidores MCP deben implementar mecanismos de seguridad:

- *Autenticación*: Verificar identidad del cliente MCP mediante tokens o API keys
- *Autorización*: Controlar qué recursos y operaciones puede acceder cada cliente
- *Rate Limiting*: Limitar número de peticiones para prevenir abuso
- *Validación de Inputs*: Sanitizar parámetros para prevenir inyecciones

=== Manejo de Errores

Servidores MCP deben retornar errores descriptivos:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "error": {
    "code": -32602,
    "message": "Invalid params",
    "data": "Número de pedido no encontrado"
  }
}
```

=== Logging y Monitoreo

- Registrar todas las peticiones MCP para auditoría
- Monitorear tiempos de respuesta de servidores
- Alertas cuando servidores no están disponibles

La integración de Model Context Protocol en el Sistema de Pedidos en Línea representa una innovación técnica significativa que diferencia esta solución de implementaciones convencionales, proporcionando un chatbot verdaderamente inteligente y actualizado que mejora sustancialmente la experiencia del usuario y reduce costos de mantenimiento.
