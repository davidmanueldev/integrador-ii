== 4.1 Tecnologías Web y Arquitectura

=== 4.1.1 Stack Tecnológico (MERN Modificado)

El proyecto utiliza un stack tecnológico moderno compuesto por MongoDB, Express (implícito en Next.js), React y Node.js, seleccionado por su robustez, escalabilidad y unificación del lenguaje JavaScript en todas las capas de la aplicación.

*Next.js y React*
Next.js es el framework de React utilizado para el desarrollo frontend y backend (API Routes). Ofrece ventajas críticas como Server-Side Rendering (SSR) para mejor SEO, optimización automática de imágenes y un sistema de enrutamiento basado en archivos. React permite la construcción de interfaces de usuario modulares mediante componentes reutilizables, facilitando el mantenimiento y la escalabilidad del código (Vercel, 2023).

*MongoDB y Mongoose*
Como base de datos NoSQL, MongoDB permite almacenar información en documentos JSON flexibles, ideal para catálogos de productos con atributos variables. Mongoose actúa como ODM (Object-Document Mapper), proporcionando validación de esquemas y modelado de datos robusto sobre Node.js.

*NextAuth.js y Stripe*
Para la seguridad, se implementa NextAuth.js, gestionando la autenticación de usuarios y sesiones seguras. El procesamiento de pagos se delega a Stripe, una pasarela de pagos que garantiza el cumplimiento de estándares de seguridad PCI-DSS y ofrece una integración fluida mediante APIs REST.

=== 4.1.2 Arquitectura Cliente-Servidor

La aplicación sigue una arquitectura cliente-servidor moderna. El *cliente* (navegador web) ejecuta la interfaz React, encargada de la interacción con el usuario y la presentación de datos. El *servidor* (Next.js) maneja la lógica de negocio, la comunicación con la base de datos y expone endpoints API REST seguros. Esta separación permite un desarrollo independiente y facilita la integración de servicios externos como los servidores MCP.
