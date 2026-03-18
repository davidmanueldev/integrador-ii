// Anexo F: Seguridad Física y Lógica
// Sistema Integral de Gestión - Restaurante Bambú

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

    [Base de Datos], [Supabase (PostgreSQL) - Infraestructura AWS con certificación SOC 2 Tipo II, ISO 27001],
    [Almacenamiento de Imágenes],
    [Supabase Storage - Infraestructura con redundancia geográfica y controles de acceso estrictos],

    [Procesamiento de Pagos], [Red Enlace/CyberSource - Certificación PCI-DSS Nivel 1, supervisado por ASFI],
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
    [Supabase], [SOC 2 Tipo II], [Seguridad, disponibilidad, integridad],
    [Supabase], [ISO 27001], [Gestión de seguridad de la información],
    [Vercel], [SOC 2 Tipo II], [Hosting y CDN],
    [Red Enlace], [PCI-DSS Nivel 1], [Procesamiento de datos de tarjetas],
    [CyberSource], [PCI-DSS Nivel 1], [Gateway de pagos internacional],
    [OpenAI], [SOC 2 Tipo II], [Servicios de IA],
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
    [Backups de BD], [Supabase realiza backups automáticos diarios con retención de 7 días (Plan Pro: 30 días)],
    [Point-in-Time Recovery], [Restauración a cualquier punto en las últimas 24 horas],
    [Redundancia], [PostgreSQL con réplicas en múltiples zonas de disponibilidad],
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
    [Hashing de Contraseñas], [Supabase Auth utiliza bcrypt con salt automático],
    [Sesiones], [JWT firmados con refresh tokens automáticos],
    [Row Level Security (RLS)], [Políticas a nivel de base de datos PostgreSQL],
    [Cookies Seguras], [httpOnly, secure, sameSite],
    [Verificación de Rol], [Middleware personalizado en cada endpoint protegido],
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
    [A01: Broken Access Control], [✓], [RLS en PostgreSQL + verificación de sesión],
    [A02: Cryptographic Failures], [✓], [Supabase Auth con bcrypt, HTTPS obligatorio],
    [A03: Injection], [✓], [Prisma ORM con queries parametrizadas],
    [A04: Insecure Design], [✓], [Arquitectura de 3 capas con separación de responsabilidades],
    [A05: Security Misconfiguration], [✓], [Variables de entorno, .env.local no committeado],
    [A06: Vulnerable Components], [✓], [Dependencias actualizadas, npm audit regular],
    [A07: Auth Failures], [✓], [Supabase Auth con providers seguros],
    [A08: Data Integrity Failures], [✓], [Verificación de firma en webhooks de pagos],
    [A09: Security Logging], [✓], [Logs de Supabase + Vercel Analytics],
    [A10: SSRF], [✓], [No hay requests dinámicos a URLs externas no validadas],
  ),
  caption: [Cumplimiento OWASP Top 10],
)

#pagebreak()

=== F.2.3 Protección de Variables de Entorno

El sistema protege credenciales sensibles mediante variables de entorno:

```env
# Credenciales NUNCA en código fuente
# Supabase
NEXT_PUBLIC_SUPABASE_URL="https://xxx.supabase.co"
NEXT_PUBLIC_SUPABASE_ANON_KEY="eyJ..."
SUPABASE_SERVICE_ROLE_KEY="eyJ..."

# Base de datos
DATABASE_URL="postgresql://postgres:****@db.xxx.supabase.co:5432/postgres"

# Red Enlace / CyberSource
CYBERSOURCE_MERCHANT_ID="****"
CYBERSOURCE_KEY_ID="****"
CYBERSOURCE_SECRET_KEY="****"

# OpenAI
OPENAI_API_KEY="sk-****"

# Resend
RESEND_API_KEY="re_****"
```

*Medidas de Protección:*
- Archivo `.env.local` incluido en `.gitignore`
- Credenciales de producción solo en panel de Vercel
- Rotación periódica de API keys
- Service Role Key solo usado en servidor, nunca expuesto

=== F.2.4 Validación de Datos

#figure(
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt,
    fill: (_, row) => if row == 0 { rgb("#fce4ec") } else { white },
    [*Capa*], [*Validación*],
    [Frontend], [Validación de formularios con Zod y React Hook Form],
    [API Routes], [Validación con Zod schemas antes de operaciones],
    [Prisma], [Tipos estrictos de TypeScript, constraints en modelo],
    [PostgreSQL], [Constraints de BD: unique, not null, foreign keys, check],
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
    [Vercel → Supabase], [Connection pooling via Supabase, SSL obligatorio],
    [Backend → Red Enlace], [HTTPS, credenciales con firma HMAC],
    [Backend → OpenAI], [HTTPS, API key en headers seguros],
    [Backend → Resend], [HTTPS, API key autenticada],
  ),
  caption: [Arquitectura de Conexiones del Sistema],
)

=== F.3.2 Configuración de Supabase

```typescript
// Conexión segura a Supabase
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
  {
    auth: {
      autoRefreshToken: true,
      persistSession: true,
      detectSessionInUrl: true
    },
    db: {
      schema: 'public'
    }
  }
)
```

*Parámetros de Seguridad:*
- SSL obligatorio en todas las conexiones
- Row Level Security habilitado en todas las tablas
- Anon Key solo permite operaciones autorizadas por RLS

=== F.3.3 Row Level Security (RLS)

Ejemplo de política RLS para la tabla `pedidos`:

```sql
-- Solo meseros y admins pueden ver pedidos
CREATE POLICY "pedidos_select_policy" ON pedidos
  FOR SELECT
  USING (
    auth.uid() IN (
      SELECT id FROM users 
      WHERE rol IN ('MESERO', 'ADMIN')
    )
  );

-- Solo meseros pueden crear pedidos
CREATE POLICY "pedidos_insert_policy" ON pedidos
  FOR INSERT
  WITH CHECK (
    auth.uid() IN (
      SELECT id FROM users WHERE rol = 'MESERO'
    )
  );
```

=== F.3.4 Monitoreo de Conexiones

- Supabase Dashboard para métricas en tiempo real
- Vercel Analytics para rendimiento de API routes
- Alertas configuradas para errores de autenticación
- Logs de acceso para auditoría de transacciones de pago
