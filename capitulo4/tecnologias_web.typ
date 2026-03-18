== 4.1 Tecnologías Web y Arquitectura

=== 4.1.1 Stack Tecnológico

El proyecto utiliza un stack tecnológico moderno optimizado para el desarrollo de aplicaciones web con funcionalidades de inteligencia artificial, seleccionado por su robustez, escalabilidad y compatibilidad con el ecosistema de servicios cloud.

*Next.js 14 y React 18*

Next.js es el framework de React utilizado para el desarrollo frontend y backend (API Routes). La versión 14 incorpora mejoras significativas:

- *App Router:* Sistema de enrutamiento moderno basado en directorios
- *Server Components:* Componentes que se renderizan en el servidor, mejorando el rendimiento
- *Server Actions:* Mutaciones de datos simplificadas sin necesidad de endpoints separados
- *Streaming:* Renderizado progresivo para mejor experiencia de usuario

React 18 permite la construcción de interfaces de usuario modulares mediante componentes reutilizables, facilitando el mantenimiento y la escalabilidad del código (Vercel, 2024).

*TypeScript*

TypeScript añade tipado estático a JavaScript, proporcionando:

- Detección de errores en tiempo de desarrollo
- Mejor autocompletado y documentación en el IDE
- Refactorización más segura
- Interfaces claras entre componentes y servicios

*Tailwind CSS y shadcn/ui*

Tailwind CSS es un framework de CSS utility-first que permite crear interfaces personalizadas sin escribir CSS personalizado. shadcn/ui proporciona componentes pre-construidos accesibles y personalizables:

- Componentes como botones, formularios, modales, tablas
- Integración nativa con Tailwind CSS
- Accesibilidad (a11y) incorporada
- Fácil personalización mediante variables CSS

=== 4.1.2 Supabase como Backend-as-a-Service

Supabase es una alternativa open-source a Firebase que proporciona una suite completa de servicios backend sobre PostgreSQL.

*Base de Datos PostgreSQL*

PostgreSQL es una base de datos relacional robusta y madura:

- Soporte para tipos de datos avanzados (JSON, arrays, vectores)
- Transacciones ACID completas
- Extensibilidad mediante extensiones (pgvector para embeddings)
- Row Level Security (RLS) para control de acceso granular

*Supabase Auth*

Sistema de autenticación integrado que incluye:

- Autenticación con email/contraseña
- Proveedores OAuth (Google, GitHub, etc.)
- Gestión de sesiones con JWT
- Recuperación de contraseña
- Verificación de email

*Supabase Storage*

Almacenamiento de archivos integrado:

- Buckets públicos y privados
- Transformación de imágenes on-the-fly
- CDN para distribución global
- Políticas de acceso basadas en RLS

*Supabase Realtime*

Funcionalidades en tiempo real:

- Suscripción a cambios en la base de datos
- Broadcast de mensajes entre clientes
- Presence para estado de usuarios
- Ideal para notificaciones de nuevas reservaciones u órdenes

=== 4.1.3 Prisma ORM

Prisma es un ORM (Object-Relational Mapping) moderno para Node.js y TypeScript:

```typescript
// Esquema de Prisma (schema.prisma)
model Producto {
  id          String   @id @default(uuid())
  nombre      String
  descripcion String
  precio      Decimal
  categoria   Categoria @relation(fields: [categoriaId], references: [id])
  categoriaId String
  disponible  Boolean  @default(true)
  createdAt   DateTime @default(now())
}
```

*Ventajas de Prisma:*

- *Type-safety:* Genera tipos TypeScript automáticamente desde el esquema
- *Migraciones:* Sistema de migraciones declarativo
- *Query Builder:* API intuitiva para consultas complejas
- *Prisma Studio:* Interfaz visual para explorar datos

=== 4.1.4 Arquitectura del Sistema

La aplicación sigue una arquitectura moderna de tres capas con servicios especializados:

```
┌─────────────────────────────────────────────────────────────┐
│                    CAPA DE PRESENTACIÓN                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   Cliente   │  │    Admin    │  │   Chatbot/IA        │  │
│  │ (Reservas)  │  │   (POS)     │  │   (Asistente)       │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
│                    Next.js + React + shadcn/ui               │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    CAPA DE APLICACIÓN                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ API Routes  │  │  Vercel AI  │  │   Red Enlace        │  │
│  │  (Next.js)  │  │    SDK      │  │   Integration       │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    CAPA DE DATOS                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │  Supabase   │  │  Supabase   │  │    Supabase         │  │
│  │ PostgreSQL  │  │   Storage   │  │    pgvector         │  │
│  │  + Prisma   │  │  (Imágenes) │  │   (Embeddings)      │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

=== 4.1.5 Vercel AI SDK

El Vercel AI SDK simplifica la integración de modelos de lenguaje en aplicaciones Next.js:

```typescript
import { useChat } from 'ai/react';

function ChatComponent() {
  const { messages, input, handleInputChange, handleSubmit } = useChat({
    api: '/api/chat',
  });

  return (
    <form onSubmit={handleSubmit}>
      {messages.map(m => (
        <div key={m.id}>{m.content}</div>
      ))}
      <input value={input} onChange={handleInputChange} />
    </form>
  );
}
```

*Características principales:*

- *Streaming:* Respuestas en tiempo real mientras el modelo genera texto
- *Hooks de React:* useChat, useCompletion para integración sencilla
- *Multi-provider:* Soporte para OpenAI, Anthropic, Google, y otros
- *Edge Functions:* Compatibilidad con funciones serverless de Vercel

=== 4.1.6 Infraestructura de Despliegue

*Vercel*

Vercel es la plataforma de despliegue recomendada para Next.js:

- Despliegue automático desde GitHub
- Preview deployments para cada pull request
- Edge Functions para baja latencia
- Analytics integrado
- Dominio personalizado con SSL automático

*Supabase Cloud*

Supabase ofrece hosting gestionado para la base de datos:

- Backups automáticos
- Escalado automático
- Monitoreo y alertas
- Panel de administración
- CLI para desarrollo local
