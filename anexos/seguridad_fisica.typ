// Anexo F: Seguridad Física y Lógica
// Sistema de Pedidos en Línea - Restaurante Bambú

= ANEXO F: SEGURIDAD FÍSICA Y LÓGICA

== F.1 Seguridad Física

La seguridad física del sistema se garantiza a través de la infraestructura en la nube utilizada para el despliegue:

=== F.1.1 Infraestructura de Hosting

El sistema está desplegado en servicios de nube que cumplen con estándares internacionales de seguridad física:

#figure(
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Componente*], [*Proveedor / Medidas*],
    [Aplicación Web],
    [Vercel - Data centers Tier III con acceso biométrico, vigilancia 24/7, y sistemas contra incendios],

    [Base de Datos], [MongoDB Atlas - Centros de datos AWS/GCP con certificación SOC 2 Tipo II, ISO 27001],
    [Almacenamiento de Imágenes],
    [AWS S3 - Infraestructura con redundancia geográfica y controles de acceso físico estrictos],

    [Procesamiento de Pagos], [Stripe - Certificación PCI-DSS Nivel 1, data centers con máxima seguridad física],
  ),
  caption: [Infraestructura y Seguridad Física por Componente],
)

=== F.1.2 Certificaciones de los Proveedores

#figure(
  table(
    columns: (auto, auto, auto),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e8f5e9") } else { white },
    [*Proveedor*], [*Certificación*], [*Alcance*],
    [MongoDB Atlas], [SOC 2 Tipo II], [Seguridad, disponibilidad, integridad],
    [MongoDB Atlas], [ISO 27001], [Gestión de seguridad de la información],
    [AWS S3], [ISO 27001, SOC 1/2/3], [Infraestructura y servicios cloud],
    [Stripe], [PCI-DSS Nivel 1], [Procesamiento de datos de tarjetas],
    [Vercel], [SOC 2 Tipo II], [Hosting y CDN],
  ),
  caption: [Certificaciones de Seguridad de Proveedores],
)

=== F.1.3 Respaldos y Recuperación ante Desastres

#figure(
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fff3e0") } else { white },
    [*Aspecto*], [*Implementación*],
    [Backups de BD], [MongoDB Atlas realiza backups automáticos diarios con retención de 7 días],
    [Redundancia], [Réplicas en múltiples zonas de disponibilidad],
    [Punto de Recuperación (RPO)], [Menos de 24 horas para datos de base de datos],
    [Tiempo de Recuperación (RTO)], [Menos de 4 horas para restauración completa],
  ),
  caption: [Plan de Respaldos y Recuperación],
)

#pagebreak()

== F.2 Seguridad Lógica

La seguridad lógica del sistema implementa múltiples capas de protección:

=== F.2.1 Autenticación y Autorización

#figure(
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Mecanismo*], [*Implementación*],
    [Hashing de Contraseñas], [bcrypt con 10 rounds de salt],
    [Sesiones], [NextAuth con tokens JWT firmados],
    [OAuth 2.0], [Integración con Google para login social],
    [Cookies Seguras], [httpOnly, secure, sameSite],
    [Verificación de Rol], [Función `isAdmin()` en cada endpoint protegido],
  ),
  caption: [Mecanismos de Autenticación y Autorización],
)

=== F.2.2 Protección contra OWASP Top 10

#figure(
  table(
    columns: (auto, auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e8f5e9") } else { white },
    [*Vulnerabilidad*], [*Estado*], [*Medida Implementada*],
    [A01: Broken Access Control], [✓], [Verificación de sesión y rol en APIs],
    [A02: Cryptographic Failures], [✓], [bcrypt para passwords, HTTPS obligatorio],
    [A03: Injection], [✓], [Mongoose ODM con validación de schemas],
    [A04: Insecure Design], [✓], [Arquitectura de 3 capas con separación de responsabilidades],
    [A05: Security Misconfiguration], [✓], [Variables de entorno, .env no committeado],
    [A06: Vulnerable Components], [✓], [Dependencias actualizadas, npm audit],
    [A07: Auth Failures], [✓], [NextAuth con providers seguros],
    [A08: Data Integrity Failures], [✓], [Verificación de firma en webhooks Stripe],
    [A09: Security Logging], [△], [Logs básicos en consola (mejorable)],
    [A10: SSRF], [✓], [No hay requests dinámicos a URLs externas],
  ),
  caption: [Cumplimiento OWASP Top 10],
)

#pagebreak()

=== F.2.3 Protección de Variables de Entorno

El sistema protege credenciales sensibles mediante variables de entorno:

```env
# Credenciales NUNCA en código fuente
MONGO_URL="mongodb+srv://user:****@cluster/db"
NEXTAUTH_URL="https://restaurante-bambu.vercel.app"
SECRET="jwt-secret-key-never-exposed"
GOOGLE_CLIENT_ID="oauth-client-id"
GOOGLE_CLIENT_SECRET="oauth-client-secret"
STRIPE_SK="sk_live_****"
STRIPE_PK="pk_live_****"
MY_AWS_ACCESS_KEY="aws-access-key"
MY_AWS_SECRET_KEY="aws-secret-key"
```

*Medidas de Protección:*
- Archivo `.env` incluido en `.gitignore`
- Credenciales de producción solo en panel de Vercel
- Rotación periódica de API keys

=== F.2.4 Validación de Datos

#figure(
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fce4ec") } else { white },
    [*Capa*], [*Validación*],
    [Frontend], [Validación de formularios con estados de React],
    [API Routes], [Verificación de campos requeridos antes de operaciones],
    [Mongoose], [Schemas con tipos, required, unique, validadores custom],
    [MongoDB], [Índices únicos para prevenir duplicados],
  ),
  caption: [Capas de Validación de Datos],
)

#pagebreak()

== F.3 Conexión a Servidor

=== F.3.1 Arquitectura de Conexión

El sistema utiliza una arquitectura serverless con conexiones optimizadas:

#figure(
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#e3f2fd") } else { white },
    [*Conexión*], [*Configuración*],
    [Cliente → Vercel], [HTTPS (TLS 1.3), CDN global con edge locations],
    [Vercel → MongoDB Atlas], [Connection pooling, URI con SSL obligatorio],
    [Backend → Stripe API], [HTTPS, API keys en headers seguros],
    [Backend → AWS S3], [SDK oficial con credenciales IAM],
  ),
  caption: [Arquitectura de Conexiones del Sistema],
)

=== F.3.2 Configuración de MongoDB Atlas

```javascript
// URI de conexión con parámetros de seguridad
const uri = "mongodb+srv://user:password@cluster.mongodb.net/restaurante-bambu" +
  "?retryWrites=true&w=majority&ssl=true";
```

*Parámetros de Seguridad:*
- `ssl=true`: Conexión encriptada obligatoria
- `retryWrites=true`: Reintentos automáticos
- `w=majority`: Confirmación de escritura en mayoría de nodos

=== F.3.3 Whitelist de IPs

MongoDB Atlas está configurado con:
- Acceso desde cualquier IP (`0.0.0.0/0`) para compatibilidad con Vercel serverless
- Autenticación requerida para todas las conexiones
- Usuarios específicos por base de datos con permisos mínimos necesarios

=== F.3.4 Monitoreo de Conexiones

- MongoDB Atlas Dashboard para métricas en tiempo real
- Alertas configuradas para conexiones anómalas
- Logs de acceso para auditoría
