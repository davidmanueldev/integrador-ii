= Alcances y Limitaciones

== Alcances del Proyecto

El presente proyecto contempla el desarrollo e implementación de las siguientes funcionalidades y componentes:

=== Alcance Funcional

*Módulo de Reservaciones*
- Calendario interactivo con visualización de disponibilidad de mesas en tiempo real
- Configuración de mesas del restaurante (capacidad, ubicación, características especiales)
- Proceso de reservación por fecha, hora y número de personas
- Confirmación automática de reservaciones mediante correo electrónico
- Gestión de lista de espera para horarios de alta demanda
- Funcionalidad de cancelación y modificación de reservaciones por parte del cliente
- Recordatorios automáticos previos a la reservación
- Panel administrativo para visualización y gestión de todas las reservaciones

*Módulo de Punto de Venta (POS)*
- Registro de pedidos asociados a mesas o clientes directos
- Interfaz de menú digital optimizada para meseros y cajeros
- Gestión de estados de orden (tomada, en preparación, servida, pagada)
- Funcionalidad de división de cuenta entre comensales
- Modificación de pedidos (agregar, quitar, cambiar productos)
- Generación de tickets y comprobantes de pago
- Control de caja con apertura, cierre y cuadre diario
- Historial completo de transacciones

*Módulo de Gestión de Menú*
- Registro de productos con nombre, descripción, precio, categoría e imagen
- Organización jerárquica mediante categorías y subcategorías
- Control de disponibilidad de productos
- Marcado de productos destacados o promocionales
- Registro de ingredientes y alérgenos para cada producto
- Carga de imágenes mediante drag-and-drop con almacenamiento en Supabase Storage
- Interfaz administrativa intuitiva para gestión sin conocimientos técnicos

*Módulo de Pagos - Integración Red Enlace*
- Procesamiento de pagos con tarjeta de débito mediante Red Enlace CyberSource
- Procesamiento de pagos con tarjeta de crédito (VISA, Mastercard, American Express)
- Generación de códigos QR para pago mediante Red Enlace QR Simple
- Registro manual de pagos en efectivo con control de caja
- Cumplimiento de estándares de seguridad PCI DSS
- Autenticación 3D Secure para transacciones con tarjeta
- Liquidación automática a cuenta bancaria boliviana
- Generación de comprobantes de pago

*Módulo de Autenticación y Autorización*
- Registro e inicio de sesión de usuarios mediante Supabase Auth
- Autenticación mediante credenciales (email/contraseña)
- Gestión de sesiones seguras
- Sistema de roles (Administrador, Cajero, Mesero, Cliente)
- Protección de rutas según permisos de usuario
- Recuperación de contraseña

*Panel Administrativo*
- Dashboard con métricas en tiempo real:
  - Total de reservaciones (diarias, semanales, mensuales)
  - Total de ventas e ingresos
  - Ocupación de mesas
  - Productos más vendidos
  - Métricas de satisfacción del cliente
- Gestión completa de productos y categorías
- Administración de mesas y configuración del restaurante
- Gestión de usuarios y asignación de roles
- Reportes de ventas por período, producto y método de pago
- Configuración general del sistema

*Funcionalidades de Inteligencia Artificial*

  *Chatbot Inteligente con Búsqueda Semántica*:
  - Interfaz de chat integrada en la plataforma web
  - Procesamiento de consultas en lenguaje natural
  - Búsqueda semántica sobre el menú utilizando embeddings (pgvector)
  - Respuestas sobre ingredientes, alérgenos y características de platillos
  - Información sobre horarios, ubicación y políticas del restaurante
  - Disponible para clientes y personal del restaurante

  *Sistema de Recomendación de Platillos*:
  - Registro de preferencias del cliente (alergias, restricciones, favoritos)
  - Análisis de historial de pedidos
  - Algoritmo de recomendación basado en similitud
  - Sugerencias de platillos complementarios
  - Integración con el chatbot

  *Predicción de Demanda*:
  - Análisis de datos históricos de reservaciones y ventas
  - Modelo predictivo para estimar afluencia por día y hora
  - Visualización de predicciones en dashboard
  - Alertas para días de alta demanda

  *Análisis de Sentimiento*:
  - Formulario de reseñas post-visita para clientes
  - Procesamiento de reseñas mediante análisis de sentimiento
  - Clasificación automática (positivo, neutro, negativo)
  - Dashboard con métricas de satisfacción
  - Alertas para reseñas negativas

=== 1.6.2 Alcance Tecnológico

*Stack de Desarrollo*
- Frontend: Next.js 14 con React 18, TypeScript, Tailwind CSS
- Componentes UI: shadcn/ui
- Formularios: React Hook Form con validación Zod
- Backend: API Routes de Next.js (serverless functions)
- Base de datos: Supabase (PostgreSQL) con Prisma ORM
- Autenticación: Supabase Auth
- Almacenamiento: Supabase Storage para imágenes
- Tiempo real: Supabase Realtime para notificaciones
- Pagos: Red Enlace CyberSource API
- IA/Embeddings: Supabase pgvector + LLM (OpenAI/Claude)
- SDK de IA: Vercel AI SDK para streaming
- Email: Resend para correos transaccionales
- Hosting: Vercel (frontend) + Supabase Cloud (backend)

=== 1.6.3 Alcance Geográfico

- Implementación específica para el Restaurante Bambú en El Alto, La Paz, Bolivia
- Integración con pasarela de pagos boliviana (Red Enlace)
- Cumplimiento de regulaciones de ASFI
- Moneda: Bolivianos (BOB)
- Idioma: Español

=== 1.6.4 Estándares de Calidad

- Seguridad:
  - Contraseñas hasheadas mediante Supabase Auth
  - Sesiones seguras con tokens JWT
  - Row Level Security (RLS) en base de datos
  - Validación de inputs en cliente y servidor
  - Variables sensibles en variables de entorno
  - Cumplimiento PCI DSS mediante Red Enlace
- Rendimiento:
  - Optimización de imágenes con Next.js Image
  - Caching de consultas frecuentes
  - Lazy loading de componentes
  - Server-side rendering para SEO
- Usabilidad:
  - Interfaz responsive para dispositivos móviles y escritorio
  - Feedback visual para acciones del usuario
  - Mensajes de error claros y constructivos

*Pruebas y Validación*
- Pruebas unitarias de componentes críticos
- Pruebas de integración de flujos principales
- Pruebas end-to-end de proceso completo de reservación y venta
- Validación de integración con Red Enlace CyberSource
- Pruebas de funcionalidades de IA
- Pruebas de seguridad básicas
- Evaluación de precisión del chatbot y sistema de recomendación

*Documentación*
- Documentación técnica del sistema (arquitectura, APIs, modelos de datos)
- Manual de usuario para clientes (cómo reservar, usar el chatbot)
- Manual de operador (gestión de POS, caja, pedidos)
- Manual de administrador (gestión de productos, reportes, configuración)
- Código fuente comentado siguiendo estándares de la industria

== Limitaciones del Proyecto

=== Limitaciones de Alcance Funcional

*Funcionalidades No Incluidas*
- Sistema de delivery o pedidos para llevar (sin personal disponible)
- Aplicación móvil nativa (iOS/Android)
- Programa de lealtad y puntos
- Sistema de cupones y descuentos promocionales
- Integración con redes sociales para compartir
- Chat en vivo con soporte humano
- Múltiples sucursales (solo una ubicación)
- Integración con sistemas POS físicos existentes
- Integración con servicios de delivery externos (PedidosYa, etc.)

*Limitaciones del Chatbot*
- No procesa reservaciones directamente (solo proporciona información y redirige)
- No reemplaza completamente el soporte humano para casos complejos
- Limitado a idioma español
- No incluye capacidad de procesamiento de imágenes
- Calidad de respuestas depende del proveedor de LLM seleccionado

*Limitaciones del Sistema de Recomendación*
- Requiere acumulación de datos históricos para mejorar precisión
- Funcionalidad limitada para usuarios nuevos (cold start)
- No considera factores externos (clima, eventos especiales)

*Limitaciones de Predicción de Demanda*
- Precisión inicial limitada hasta acumular datos históricos suficientes
- No considera factores externos impredecibles
- Modelo simplificado (no machine learning avanzado en MVP)

=== Limitaciones Técnicas

*Infraestructura*
- Diseñado para carga moderada (hasta 500 usuarios concurrentes)
- Dependencia de servicios cloud (Supabase, Vercel)
- Sin implementación de caché distribuido en versión inicial
- Almacenamiento de imágenes limitado por plan de Supabase

*Integraciones*
- Red Enlace como única pasarela de pago
- Sin integración con otros proveedores de pago (PayPal, etc.)
- Email mediante Resend (límites según plan)
- Dependencia de disponibilidad de APIs externas (Red Enlace, LLM)

*Inteligencia Artificial*
- Calidad de embeddings depende del modelo seleccionado
- Costos variables según uso de API de LLM
- Latencia en respuestas del chatbot depende de proveedor
- Sin entrenamiento personalizado de modelos (usa APIs existentes)

=== Limitaciones de Recursos

*Temporales*
- Desarrollo completado en período académico definido
- Tiempo limitado para pruebas exhaustivas
- Período de validación con usuarios reales acotado

*Económicos*
- Uso de planes gratuitos o de bajo costo de servicios cloud
- Límites en llamadas a APIs de IA (costos por uso)
- Sin presupuesto para herramientas de testing pagadas

=== Limitaciones de Datos

*Datos Históricos*
- Sin datos históricos previos para predicción inicial
- Modelos de recomendación requieren acumulación de datos
- Métricas de desempeño basadas en período inicial limitado

*Privacidad y Regulaciones*
- Cumplimiento básico de protección de datos personales
- Políticas de privacidad básicas
- Sin certificación formal de estándares de seguridad adicionales

== Consideraciones Finales de Alcance

A pesar de las limitaciones mencionadas, el alcance definido constituye un sistema completo que:

1. *Resuelve los problemas centrales*: Proporciona gestión digital de reservaciones y punto de venta
2. *Incorpora innovación*: Integra funcionalidades de IA prácticas y demostrables
3. *Se adapta al contexto local*: Diseñado específicamente para Bolivia con Red Enlace
4. *Permite validación*: Incluye suficientes funcionalidades para evaluar viabilidad
5. *Establece base escalable*: Arquitectura permite expansión futura

Las limitaciones identificadas no comprometen los objetivos del proyecto, sino que delimitan un alcance realista y ejecutable dentro de las restricciones existentes.
