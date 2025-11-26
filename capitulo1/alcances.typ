= Alcances y Limitaciones

== Alcances del Proyecto

El presente proyecto contempla el desarrollo e implementación de las siguientes funcionalidades y componentes:

=== Alcance Funcional

*Módulo de Catálogo y Menú*
- Visualización pública del menú completo organizado por categorías
- Búsqueda y filtrado de productos
- Visualización detallada de cada producto (nombre, descripción, precio, imagen, ingredientes, información nutricional opcional)
- Indicadores de disponibilidad y productos destacados
- Responsive design para acceso desde dispositivos móviles y escritorio

*Módulo de Carrito y Pedidos*
- Gestión completa de carrito de compras (agregar, modificar cantidad, eliminar productos)
- Cálculo automático de subtotales, impuestos y total
- Formulario de información de entrega
- Integración con Stripe para procesamiento seguro de pagos
- Generación de número de orden único
- Confirmación de pedido con resumen detallado
- Envío de notificaciones por email

*Módulo de Autenticación*
- Registro de nuevos usuarios con validación de datos
- Inicio de sesión seguro con credenciales
- Recuperación de contraseña mediante email
- Gestión de perfil de usuario (actualización de datos personales)
- Historial de pedidos para usuarios registrados
- Sistema de roles (Cliente, Administrador)

*Panel Administrativo*
- Dashboard con métricas en tiempo real:
  - Total de pedidos (diario, semanal, mensual)
  - Ingresos totales
  - Productos más vendidos
  - Pedidos pendientes
- Gestión completa de productos (CRUD):
  - Crear nuevos productos con formulario intuitivo
  - Editar productos existentes
  - Eliminación lógica (soft delete) de productos
  - Carga de imágenes mediante drag-and-drop
- Gestión de categorías:
  - Crear, editar y eliminar categorías
  - Reordenar categorías
- Gestión de pedidos:
  - Visualización de todos los pedidos
  - Filtrado por estado (pendiente, en preparación, enviado, completado, cancelado)
  - Actualización manual de estados
  - Visualización de detalles completos de cada pedido
- Gestión básica de usuarios:
  - Lista de usuarios registrados
  - Modificación de roles

*Módulo de Chatbot con MCPs*
- Interfaz de chat integrada en la plataforma
- Procesamiento de lenguaje natural para consultas de usuarios
- Integración con servidores MCP para acceso a datos en tiempo real:

  *MCP de Menú*:
  - Consulta de productos disponibles
  - Búsqueda de productos por nombre o categoría
  - Obtención de información detallada (precio, descripción, ingredientes)

  *MCP de Inventario*:
  - Verificación de disponibilidad de productos en tiempo real
  - Consulta de stock disponible

  *MCP de Pedidos*:
  - Consulta de estado de pedidos por número de orden
  - Obtención de detalles de pedidos específicos

  *MCP de Información del Restaurante*:
  - Horarios de atención
  - Ubicación y datos de contacto
  - Políticas de entrega y devoluciones
  - Información sobre días festivos y cierres especiales

=== 1.6.2 Alcance Geográfico

*Tecnologías Implementadas*
- Frontend: Next.js 14 con React 18, Tailwind CSS para estilos
- Backend: API Routes de Next.js (serverless functions)
- Base de datos: MongoDB con Mongoose para ODM
- Autenticación: NextAuth.js con JWT
- Pagos: Stripe API con webhooks para confirmación
- Model Context Protocol: Implementación de servidores MCP personalizados en Node.js
- Hosting: Deployment en plataforma compatible (Vercel, AWS, u otra)

=== 1.6.3 Límites
- Seguridad:
  - Contraseñas hasheadas con bcrypt
  - Sesiones con cookies HTTP-only
  - Validación de inputs en cliente y servidor
  - Protección CSRF
  - Variables sensibles en variables de entorno
- Rendimiento:
  - Optimización de imágenes con Next.js Image
  - Caching de consultas frecuentes
  - Lazy loading de componentes
- Usabilidad:
  - Interfaz intuitiva y responsive
  - Feedback visual para acciones del usuario
  - Mensajes de error claros y constructivos

*Pruebas y Validación*
- Pruebas unitarias de componentes críticos
- Pruebas de integración de flujos principales
- Pruebas end-to-end de proceso completo de pedido
- Validación de comunicación con servidores MCP
- Pruebas de seguridad básicas
- Evaluación comparativa de chatbot con MCPs vs. sin MCPs

*Documentación*
- Documentación técnica del sistema (arquitectura, APIs, modelos de datos)
- Manual de usuario para clientes (cómo realizar pedidos, usar el chatbot)
- Manual de administrador (gestión de productos, pedidos, configuración)
- Documentación de servidores MCP (endpoints, formatos de respuesta)
- Código fuente comentado siguiendo estándares de la industria

== Limitaciones del Proyecto

=== Limitaciones de Alcance Funcional

*Funcionalidades No Incluidas en el MVP*
- Sistema de reservaciones de mesas
- Programa de lealtad y puntos
- Aplicación móvil nativa (iOS/Android)
- Sistema de cupones y descuentos promocionales
- Integración con redes sociales para compartir
- Sistema de calificaciones y reseñas de productos
- Chat en vivo con soporte humano
- Sistema de recomendaciones personalizadas mediante machine learning
- Múltiples métodos de pago (solo Stripe en MVP)
- Opciones de entrega en tiempo real con tracking de repartidor
- Sistema de inventario automatizado con alertas de stock bajo

*Limitaciones del Chatbot*
- El chatbot no procesará pedidos directamente (solo proporciona información)
- No reemplaza completamente el soporte humano para casos complejos
- Limitado a idioma español en versión inicial
- No incluye capacidad de procesamiento de imágenes enviadas por usuarios
- No mantiene contexto de conversaciones entre sesiones (stateless)

=== Limitaciones Técnicas

*Infraestructura*
- Diseñado para carga moderada (hasta 500 usuarios concurrentes)
- Sin implementación de caché distribuido (Redis) en MVP
- Sin balanceador de carga para alta disponibilidad
- Almacenamiento de imágenes limitado por plan de hosting

*Integraciones*
- Stripe como única pasarela de pago (no incluye PayPal, transferencias, etc.)
- Email mediante servicio de terceros (límites de envío según plan)
- Sin integración con sistemas POS físicos
- Sin integración con servicios de delivery externos (Rappi, Uber Eats)

*Servidores MCP*
- Implementación básica sin sistema de caché avanzado para respuestas MCP
- Sin versionamiento de API de servidores MCP
- Tolerancia a fallos limitada (si un servidor MCP falla, esa funcionalidad no está disponible)
- Sin métricas de rendimiento detalladas de servidores MCP

=== Limitaciones de Recursos

*Temporales*
- Desarrollo completado en aproximadamente 13 días (MVP)
- Tiempo limitado para pruebas exhaustivas de todos los casos de uso
- Período de validación con usuarios reales acotado

*Humanos*
- Proyecto desarrollado por un equipo reducido
- Conocimiento especializado en MCPs limitado (tecnología emergente)
- Dependencia de documentación disponible de tecnologías nuevas

*Económicos*
- Presupuesto limitado para servicios cloud premium
- Restricciones en herramientas de testing pagadas
- Límites de transacciones en modo de prueba de Stripe

=== Limitaciones de Datos

*Datos Históricos*
- Sin datos históricos previos de pedidos para análisis predictivo inicial
- Modelos de recomendación requieren acumulación de datos
- Métricas de desempeño basadas en período inicial limitado

*Privacidad y Regulaciones*
- Cumplimiento básico de protección de datos
- Sin certificación formal de estándares de seguridad (PCI-DSS completo)
- Políticas de privacidad básicas (no revisadas legalmente)

=== Limitaciones Geográficas y de Mercado

*Alcance Geográfico*
- Implementación inicial para una ubicación del Restaurante Bambú
- Sin soporte para múltiples sucursales en MVP
- Zona de entrega delimitada geográficamente

*Idioma y Localización*
- Interfaz únicamente en español
- Formato de moneda y fechas para región específica
- Sin adaptación cultural para mercados internacionales

== Consideraciones Finales de Alcance

A pesar de las limitaciones mencionadas, el alcance definido constituye un MVP (Producto Mínimo Viable) robusto que:

1. *Resuelve el problema central*: Proporciona un sistema funcional de pedidos en línea con chatbot inteligente
2. *Demuestra innovación*: Integra exitosamente MCPs en un contexto real de negocio
3. *Permite validación*: Incluye suficientes funcionalidades para evaluar viabilidad y aceptación
4. *Establece base escalable*: Arquitectura permite expansión futura sin reescritura completa

Las limitaciones identificadas no comprometen los objetivos核心 del proyecto, sino que delimitan un alcance realista y ejecutable dentro de las restricciones existentes. Muchas de las funcionalidades excluidas están contempladas como trabajo futuro una vez validado el sistema基本.

La estrategia de desarrollo prioriza calidad sobre cantidad, asegurando que las funcionalidades incluidas estén completamente implementadas, probadas y documentadas, en lugar de incluir un catálogo extenso de características parcialmente desarrolladas.
