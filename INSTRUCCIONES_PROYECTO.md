# INSTRUCCIONES DE REDEFINICIÓN DEL PROYECTO

## Resumen Ejecutivo

Este documento contiene todas las decisiones y cambios acordados para redefinir el proyecto de tesis del Restaurante Bambú. Usar como referencia si se pierde el contexto de la conversación.

---

## INFORMACIÓN GENERAL

| Campo | Valor |
|-------|-------|
| **Título Nuevo** | Sistema Web de Gestión para el Restaurante Bambú con Inteligencia Artificial |
| **Título Anterior** | Sistema de Pedidos en Línea - Restaurante Bambú con MCPs |
| **Ubicación** | El Alto, La Paz, Bolivia |
| **Tipo de Proyecto** | Sistema completo (no MVP) |
| **Terminología** | "Sistema Web" (estándar en repositorios bolivianos como UMSA) |

---

## CAMBIOS PRINCIPALES

### LO QUE SE ELIMINA

1. **MCPs (Model Context Protocol)** - ELIMINADOS COMPLETAMENTE
   - Eliminar todas las referencias a MCPs en todo el documento
   - Eliminar servidores MCP de Menú, Inventario, Pedidos, Info
   - Reemplazar por funcionalidades de IA más prácticas

2. **Delivery** - ELIMINADO
   - No hay personal para cubrir esta funcionalidad
   - Eliminar todas las referencias a pedidos en línea para entrega
   - Eliminar carrito de compras para delivery
   - El sistema es solo para servicio presencial en el restaurante

3. **Stripe** - REEMPLAZADO
   - Reemplazar por Red Enlace CyberSource (pasarela boliviana)

4. **MongoDB** - REEMPLAZADO
   - Reemplazar por Supabase (PostgreSQL)

5. **NextAuth** - REEMPLAZADO
   - Reemplazar por Supabase Auth

---

## MÓDULOS DEL SISTEMA (NUEVOS)

### Módulo 1: Sistema de Reservaciones
- Calendario interactivo de disponibilidad de mesas
- Configuración de mesas (capacidad, ubicación)
- Reservas por fecha/hora/número de personas
- Confirmación automática por email (Resend)
- Gestión de lista de espera
- Cancelaciones y modificaciones
- Panel administrativo para gestionar reservaciones

### Módulo 2: Punto de Venta (POS)
- Registro de pedidos por mesa/cliente
- Menú digital para meseros/cajeros
- Estados de orden (tomada, en preparación, servida, pagada)
- División de cuenta
- Generación de tickets/recibos
- Control de caja (apertura, cierre, cuadre diario)
- Historial de transacciones

### Módulo 3: Gestión Administrativa
- Dashboard con métricas en tiempo real
- Gestión de menú (CRUD productos/categorías)
- Gestión de mesas
- Reportes de ventas
- Gestión de usuarios/roles

---

## FUNCIONALIDADES DE IA (4 FUNCIONES)

### 1. Chatbot Inteligente con Búsqueda Semántica
- **Descripción**: Asistente que comprende lenguaje natural
- **Usuarios**: Clientes + Staff (ambos)
- **Tecnología**: Embeddings con pgvector de Supabase + LLM (OpenAI/Claude por definir)
- **Ejemplos de uso**:
  - "¿Qué platos tienen sin gluten?"
  - "Quiero algo ligero para cenar"
  - "¿A qué hora cierran los domingos?"

### 2. Sistema de Recomendación de Platillos
- **Descripción**: Sugerencias personalizadas basadas en preferencias e historial
- **Usuarios**: Clientes
- **Tecnología**: Algoritmos de recomendación + historial de pedidos
- **Ejemplos de uso**:
  - Sugerir platillos basados en pedidos anteriores
  - Recomendar platillos similares a los favoritos
  - Sugerir complementos (ej: postre después de plato principal)

### 3. Predicción de Demanda
- **Descripción**: Estima afluencia por día/hora
- **Usuarios**: Staff/Admin
- **Tecnología**: Análisis de datos históricos + modelo predictivo
- **Uso**: Optimización de personal e inventario

### 4. Análisis de Sentimiento de Reseñas
- **Descripción**: Analiza feedback de clientes
- **Fuente de reseñas**: Sistema interno (no externas como Google)
- **Usuarios**: Admin
- **Tecnología**: NLP/LLM para clasificar sentimiento
- **Output**: Dashboard con métricas de satisfacción, alertas para reseñas negativas

---

## MÉTODOS DE PAGO

| Método | Tecnología | Notas |
|--------|------------|-------|
| **Tarjeta** | Red Enlace CyberSource API | VISA, Mastercard, Amex |
| **Código QR** | Red Enlace QR Simple | QR generado por el sistema |
| **Efectivo** | Registro manual | Control de caja interno |

### Sobre Red Enlace
- Es la pasarela de pagos estándar en Bolivia
- Supervisada por ASFI (Autoridad de Supervisión del Sistema Financiero)
- Liquida directamente a cuenta bancaria boliviana
- Comisión: hasta 2.5%
- Cumple PCI DSS y 3D Secure
- Producto a usar: **CyberSource API** (REST/SOAP)
- Alternativa más simple: EON (Enlazate Online) - pero se eligió CyberSource

---

## STACK TECNOLÓGICO FINAL

### Frontend
| Tecnología | Propósito |
|------------|-----------|
| Next.js 14 | Framework principal |
| React 18 | UI Library |
| TypeScript | Tipado estático |
| Tailwind CSS | Estilos |
| **shadcn/ui** | Componentes UI |
| React Hook Form + Zod | Formularios y validación |
| react-day-picker | Calendario para reservaciones |
| Recharts | Gráficos para dashboard |

### Backend / Base de Datos
| Tecnología | Propósito |
|------------|-----------|
| **Supabase (PostgreSQL)** | Base de datos principal |
| **Prisma** | ORM |
| **Supabase Auth** | Autenticación |
| **Supabase Storage** | Almacenamiento de imágenes |
| **Supabase Realtime** | Notificaciones en tiempo real |
| Next.js API Routes | Endpoints |

### Pagos (Bolivia)
| Tecnología | Propósito |
|------------|-----------|
| **Red Enlace CyberSource** | Pasarela de pagos |
| **Red Enlace QR Simple** | Pagos con QR |

### Inteligencia Artificial
| Tecnología | Propósito |
|------------|-----------|
| **Supabase pgvector** | Almacenamiento de embeddings |
| OpenAI / Claude (por definir) | LLM para chatbot y análisis |
| **Vercel AI SDK** | Streaming y hooks de IA |

### Infraestructura
| Tecnología | Propósito |
|------------|-----------|
| Vercel | Hosting frontend |
| Supabase Cloud | Hosting base de datos |
| **Resend** | Emails transaccionales |

---

## ARCHIVOS A MODIFICAR

### FASE 1: Preliminares y Capítulo 1 (ALTA PRIORIDAD)

| Archivo | Estado | Cambios |
|---------|--------|---------|
| `preliminares/resumen.typ` | COMPLETADO | Reescrito con nuevo enfoque |
| `preliminares/abstract.typ` | COMPLETADO | Reescrito en inglés |
| `capitulo1/introduccion.typ` | COMPLETADO | Actualizado |
| `capitulo1/planteamiento.typ` | COMPLETADO | Reformulado sin delivery ni MCPs |
| `capitulo1/objetivos.typ` | COMPLETADO | 9 nuevos objetivos específicos |
| `capitulo1/alcances.typ` | PENDIENTE | Actualizar alcances y limitaciones |

### FASE 2: Eliminar/Reemplazar MCPs (MEDIA PRIORIDAD)

| Archivo | Acción |
|---------|--------|
| `capitulo2/mcps.typ` | ELIMINAR o reemplazar por sección de IA aplicada |
| `capitulo3/diseno_mcps.typ` | ELIMINAR o reemplazar |
| `capitulo4/mcps.typ` | ELIMINAR |
| `capitulo4/implementacion_mcps.typ` | ELIMINAR |
| `capitulo5/evaluacion_mcps.typ` | ELIMINAR |

### FASE 3: Actualizar Stack Tecnológico (MEDIA PRIORIDAD)

| Archivo | Cambios |
|---------|---------|
| `capitulo4/bases_datos_apis.typ` | Actualizar a Supabase + Prisma |
| `capitulo4/tecnologias_web.typ` | Actualizar stack completo |
| `capitulo4/chatbots_llms.typ` | Actualizar enfoque (embeddings, no MCPs) |
| `capitulo3/arquitectura.typ` | Nueva arquitectura del sistema |

### FASE 4: Nuevas Secciones (A CREAR)

- Sección de Sistema de Reservaciones
- Sección de Punto de Venta (POS)
- Sección de Red Enlace (pagos Bolivia)
- Sección de Embeddings y Búsqueda Semántica
- Sección de Sistema de Recomendación
- Sección de Predicción de Demanda
- Sección de Análisis de Sentimiento

---

## NUEVOS OBJETIVOS ESPECÍFICOS (9 OBJETIVOS)

**Regla**: Un solo verbo por objetivo (no "Diseñar, desarrollar e implementar")

| OE | Verbo | Descripción |
|----|-------|-------------|
| **OE1** | Desarrollar | Sistema de reservaciones (calendario, confirmaciones email) |
| **OE2** | Construir | Punto de venta (estados de orden, control de caja) |
| **OE3** | Integrar | Pasarela de pagos Red Enlace (tarjeta, QR, efectivo) |
| **OE4** | Crear | Chatbot inteligente (RAG con pgvector + embeddings) |
| **OE5** | Diseñar | Sistema de recomendación (preferencias + historial) |
| **OE6** | Elaborar | Modelo de predicción de demanda (día/hora) |
| **OE7** | Incorporar | Análisis de sentimiento (reseñas internas) |
| **OE8** | Estructurar | Panel administrativo (dashboard, reportes, roles) |
| **OE9** | Ejecutar | Pruebas de rendimiento y usabilidad |

**Objetivo General**: Solo usa "Implementar" (no múltiples verbos)

---

## PREGUNTA DE INVESTIGACIÓN (NUEVA)

> ¿Cómo desarrollar e implementar un sistema integral de gestión para el Restaurante Bambú que integre módulos de reservaciones y punto de venta con funcionalidades de inteligencia artificial, adaptado al contexto boliviano, para mejorar simultáneamente la experiencia del cliente, la eficiencia operativa y la capacidad de toma de decisiones basada en datos?

---

## CARACTERÍSTICAS ESPECÍFICAS PARA BOLIVIA

- **Pasarela de pagos**: Red Enlace (no Stripe)
- **Moneda**: Bolivianos (BOB)
- **Regulador**: ASFI
- **Ubicación**: El Alto, La Paz
- **Idioma del sistema**: Español
- **Método de pago QR**: Red Enlace QR Simple (no apps externas)

---

## NOTAS IMPORTANTES

1. El documento está escrito en **Typst** (.typ)
2. Para compilar: `typst compile index.typ`
3. El archivo principal es `index.typ`
4. Mantener formato APA 7ma edición
5. Seguir estructura Lazcano

---

## PROGRESO ACTUAL

### ✅ COMPLETADO
- [x] Resumen (preliminares/resumen.typ)
- [x] Abstract (preliminares/abstract.typ)
- [x] Portada (preliminares/portada.typ) - Título actualizado a "Sistema Web"
- [x] Introducción (capitulo1/introduccion.typ)
- [x] Planteamiento del problema (capitulo1/planteamiento.typ)
- [x] Objetivos (capitulo1/objetivos.typ) - Un verbo por objetivo
- [x] Objetivos cap2 (capitulo2/objetivos.typ) - Sincronizado
- [x] Antecedentes (capitulo1/antecedentes.typ) - Reescrito con fuentes reales
- [x] Alcances y limitaciones (capitulo1/alcances.typ)
- [x] Marco teórico completo (capitulo2/)
- [x] Diseño del sistema (capitulo3/)
- [x] Implementación (capitulo4/) - Stack actualizado
- [x] Evaluación y pruebas (capitulo5/)
- [x] Plan de implementación (capitulo6/)
- [x] Ingeniería del proyecto (capitulo7/)
- [x] Conclusiones (capitulo8/)
- [x] Anexos (anexos/)
- [x] Glosario y declaración jurada
- [x] Referencias bibliográficas actualizadas

### 📝 NOTAS
- Las referencias a MongoDB y Stripe que quedan son **comparativas** (justifican la elección del nuevo stack)
- El documento compila correctamente con `typst compile index.typ`
- Los warnings de fuentes (Times New Roman) son esperados y no afectan el resultado

---

## ANTECEDENTES REALES ENCONTRADOS

### Internacional
- **Universidad de Granada (España)** - Tesis sobre destinos turísticos inteligentes y estrategias online para restaurantes

### Nacional (Bolivia)
- **UMSA** - "Sistema productivo digital Broaster California" (2023) - Aplicación web para restaurante
- **UMSA** - "Sistema web de georreferenciación de restaurantes" (2016)

### Local (El Alto)
- **UNIFRANZ El Alto** - Sistemas POS básicos (repositorio no accesible directamente)

---

*Documento generado como respaldo de la conversación de redefinición del proyecto.*

---

## COMANDOS ÚTILES

```bash
# Compilar documento
cd /home/davidmanuel/Pruebas/integrador-ii && typst compile index.typ

# Verificar referencias obsoletas (las comparativas son válidas)
grep -rn "MCP\|MongoDB\|Mongoose\|Stripe\|NextAuth" --include="*.typ" .

# Ver estructura del proyecto
ls -la capitulo*/
```
