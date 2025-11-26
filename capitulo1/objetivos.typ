== 1.4 Objetivos

=== 1.4.1 Objetivo General

Desarrollar e implementar un sistema web integral de pedidos en línea para el Restaurante Bambú, integrando Model Context Protocol (MCPs) para proporcionar un chatbot asistente con capacidad de acceso a información en tiempo real, con el fin de mejorar la experiencia del cliente, incrementar la eficiencia operativa y establecer una base tecnológica escalable para el crecimiento del negocio.

=== 1.4.2 Objetivos Específicos

*OE1: Sistema de Gestión de Menú*

Implementar un módulo completo de gestión de menú con operaciones CRUD (Crear, Leer, Actualizar, Eliminar) que permita a los administradores mantener actualizado el catálogo de productos, incluyendo:

- Registro de productos con nombre, descripción, precio, categoría e imagen
- Organización jerárquica mediante categorías y subcategorías
- Control de disponibilidad y destacados
- Interfaz administrativa intuitiva para gestión sin conocimientos técnicos

*OE2: Carrito de Compras y Procesamiento de Pagos*

Desarrollar un carrito de compras funcional integrado con la pasarela de pagos Stripe para procesamiento seguro de transacciones, contemplando:

- Gestión de productos en carrito (agregar, modificar cantidad, eliminar)
- Cálculo automático de subtotales, impuestos y totales
- Integración con Stripe para pagos con tarjeta de crédito/débito
- Confirmación de pedidos y generación de número de orden único
- Manejo de webhooks para validación de pagos

*OE3: Sistema de Autenticación y Autorización*

Integrar un sistema robusto de autenticación y autorización utilizando NextAuth para garantizar la seguridad y control de acceso, implementando:

- Registro e inicio de sesión de usuarios
- Autenticación mediante credenciales (email/contraseña)
- Gestión de sesiones seguras con cookies HTTP-only
- Sistema de roles (Cliente, Administrador)
- Protección de rutas según permisos de usuario

*OE4: Panel Administrativo*

Crear un panel administrativo completo para gestión centralizada de la plataforma, incluyendo:

- Dashboard con métricas clave (ventas, pedidos pendientes, productos más vendidos)
- Gestión de categorías de productos
- Administración de pedidos (visualización, actualización de estados)
- Gestión de usuarios y permisos
- Configuración general del sistema

*OE5: Diseño e Implementación de Servidores MCP*

Diseñar y desarrollar servidores Model Context Protocol personalizados para exponer datos del restaurante de forma estructurada y segura, implementando:

- *MCP de Menú*: Servidor que proporciona acceso a productos disponibles con información completa (nombre, descripción, precio, imagen, categoría)
- *MCP de Inventario*: Servidor que verifica disponibilidad en tiempo real de productos
- *MCP de Pedidos*: Servidor que permite consultar el estado y detalles de pedidos mediante número de orden
- *MCP de Información del Restaurante*: Servidor que provee datos operativos (horarios, ubicación, políticas, días festivos)

Cada servidor MCP deberá implementar el protocolo estándar, incluyendo métodos de inicialización, listado de recursos disponibles y consultas específicas.

=== OE6: Integración de MCPs con Chatbot

Integrar los servidores MCP desarrollados con el chatbot asistente para habilitar respuestas contextualizadas en tiempo real, contemplando:

- Configuración del cliente MCP en el sistema de chatbot
- Conexión con todos los servidores MCP implementados
- Lógica de ruteo de consultas al servidor MCP apropiado
- Procesamiento de resultados y generación de respuestas naturales
- Manejo de errores y fallbacks cuando los servidores no están disponibles

=== OE7: Pruebas y Validación del Sistema

Realizar pruebas funcionales exhaustivas y validación del sistema completo para garantizar calidad, confiabilidad y cumplimiento de requisitos, incluyendo:

- Pruebas unitarias de componentes críticos
- Pruebas de integración entre módulos
- Pruebas de flujos end-to-end (desde exploración de menú hasta confirmación de pago)
- Validación de comunicación con servidores MCP
- Pruebas de seguridad (autenticación, autorización, validación de inputs)
- Pruebas de usabilidad con usuarios reales

=== OE8: Evaluación de Mejora con MCPs

Evaluar cuantitativamente la mejora en precisión de respuestas y satisfacción del usuario comparando el chatbot con MCPs versus un chatbot sin acceso a datos en tiempo real, mediante:

- Definición de métricas de evaluación (precisión de respuestas, tiempo de respuesta, tasa de resolución exitosa)
- Aplicación de casos de prueba estandarizados
- Recopilación de retroalimentación de usuarios
- Análisis comparativo de resultados
- Documentación de hallazgos y conclusiones

Estos objetivos específicos abordan de manera integral tanto los aspectos funcionales del sistema de pedidos en línea como la innovación tecnológica representada por la integración de MCPs, estableciendo un camino claro para el desarrollo y validación del proyecto.
