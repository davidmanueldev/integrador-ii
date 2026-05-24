= Chatbots y Asistentes Virtuales

Los chatbots han evolucionado desde simples sistemas de respuesta basados en reglas hasta asistentes conversacionales avanzados capaces de comprender lenguaje natural y proporcionar respuestas contextualizadas basadas en información actualizada. Esta evolución ha transformado la forma en que las empresas interactúan con sus clientes, automatizando soporte y mejorando la experiencia del usuario.

== Evolución de los Chatbots

=== Primera Generación: Sistemas Basados en Reglas

Los chatbots más tempranos (décadas de 1960-1990) operaban mediante reglas if-then predefinidas:

```
SI usuario_dice("hola") ENTONCES responder("¡Hola! ¿En qué puedo ayudarte?")
SI usuario_dice_contiene("precio") ENTONCES responder("Los precios varían según el producto")
```

*Características*:
- Respuestas completamente predefinidas
- Sin capacidad de aprendizaje
- Requieren programar todas las posibles interacciones manualmente
- Fallan ante variaciones mínimas en formulación de preguntas

=== Segunda Generación: Procesamiento de Lenguaje Natural (NLP) Básico

Con avances en NLP (1990-2010), los chatbots comenzaron a:

- Tokenizar y analizar estructura gramatical de oraciones
- Identificar intenciones (intents) mediante clasificadores de texto
- Extraer entidades clave (fechas, números, nombres de productos)
- Generar respuestas mediante plantillas

*Arquitectura Intent-Entity*:

```javascript
// Identificar intención
const intent = clasificador.clasificar("¿Tienen pizzas vegetarianas?");
// → intent: "consultar_menu"
// → entidades: { tipo: "vegetariana", categoria: "pizza" }

// Generar respuesta desde plantilla
const respuesta = plantillas[intent].render(entidades);
```

*Limitaciones*:
- Respuestas basadas en plantillas predefinidas
- Información estática en base de conocimiento
- Contexto conversacional limitado

=== Tercera Generación: Modelos de Lenguaje Grandes (LLMs)

Los avances recientes en inteligencia artificial (2018-presente) han introducido modelos de lenguaje transformers como GPT-4, Claude y Gemini que revolucionan chatbots:

*Capacidades*:
- *Comprensión contextual profunda*: Entendimiento de matices, implicaciones, contexto conversacional
- *Generación de texto natural*: Respuestas fluidas en lenguaje natural, no plantillas rígidas
- *Razonamiento*: Capacidad de inferir información, conectar conceptos, explicar razonamientos
- *Multilingüismo*: Soporte para múltiples idiomas incluyendo español boliviano

*Ejemplo de Interacción Compleja*:

```
Usuario: "Quiero algo ligero pero nutritivo, tengo reunión en la tarde"

Chatbot LLM: "Te recomendaría nuestra Ensalada César con Pollo (Bs. 45)
o el Wrap de Vegetales Asados (Bs. 38). Ambos son ligeros, te darán
energía sostenida para tu reunión sin sensación de pesadez. El wrap es
más fácil de comer si tienes prisa. ¿Te gustaría conocer los ingredientes
de alguno?"
```

== Problemática: Información Desactualizada en Chatbots

A pesar de capacidades avanzadas de LLMs, persiste un desafío crítico: *los modelos tienen información estática hasta su fecha de corte de entrenamiento*.

=== Escenario Problemático

*Situación*: Restaurante actualiza precio de Pizza Margarita de Bs. 45 a Bs. 52

*Sin Acceso a Datos en Tiempo Real*:
```
Usuario: "¿Cuánto cuesta la Pizza Margarita?"
Chatbot: "La Pizza Margarita cuesta Bs. 45"  ← INCORRECTO
```

*Consecuencias*:
- Información incorrecta frustra al usuario
- Pérdida de confianza en el sistema
- Clientes pueden sentirse engañados al descubrir precio real

=== Soluciones Tradicionales y Limitaciones

*Actualización Periódica de Base de Conocimiento*

Proceso:
1. Administrador actualiza documento de información
2. Documento se procesa para crear nuevos embeddings
3. Chatbot puede recuperar información actualizada

Problemas:
- Proceso manual y propenso a errores
- Retraso entre cambio real y actualización
- Difícil mantener sincronización perfecta

== Solución: Retrieval-Augmented Generation (RAG)

La técnica de RAG (Generación Aumentada por Recuperación) combina la capacidad generativa de LLMs con información recuperada de fuentes externas actualizadas.

=== Arquitectura RAG con Embeddings

El sistema implementa RAG mediante búsqueda semántica con pgvector:

```
1. Usuario hace pregunta: "¿Qué opciones vegetarianas tienen?"
2. Pregunta se convierte en embedding (vector de 1536 dimensiones)
3. Búsqueda de similitud en PostgreSQL/pgvector → platillos relevantes
4. Platillos recuperados se incluyen en contexto del LLM
5. LLM genera respuesta natural basándose en datos actualizados
```

=== Implementación en el Proyecto

*Generación de Embeddings*

```typescript
import { embed } from 'ai';
import { openai } from '@ai-sdk/openai';

async function generateEmbedding(text: string) {
  const { embedding } = await embed({
    model: openai.embedding('text-embedding-3-small'),
    value: text
  });
  return embedding;
}
```

*Búsqueda Semántica*

```sql
-- Buscar platillos similares a la consulta del usuario
SELECT id, name, description, price,
       1 - (embedding <=> $1) as similarity
FROM products
WHERE 1 - (embedding <=> $1) > 0.7
ORDER BY similarity DESC
LIMIT 5;
```

*Flujo Completo*:

```
Usuario: "¿Cuánto cuesta la Pizza Margarita y está disponible?"

1. Sistema genera embedding de la consulta
2. Busca en pgvector productos similares
3. Recupera datos actualizados de PostgreSQL:
   {
     nombre: "Pizza Margarita",
     precio: 52.00,
     disponible: true,
     descripcion: "Pizza clásica con tomate, mozzarella..."
   }
4. LLM genera respuesta con contexto:
   "La Pizza Margarita cuesta Bs. 52 y sí está disponible.
   Es nuestra pizza clásica con tomate, mozzarella fresca y albahaca.
   ¿Te gustaría que la agregue a tu pedido?"
```

*Ventajas de RAG*:
- Precio siempre correcto (consulta BD actualizada)
- Disponibilidad en tiempo real
- Sin mantenimiento manual de documentos
- Respuesta natural y contextualizada del LLM

== Comparación de Enfoques

| Aspecto | Reglas Fijas | NLP + Plantillas | LLM Solo | LLM + RAG (Este Proyecto) |
|---------|--------------|------------------|----------|---------------------------|
| *Comprensión* | Muy limitada | Moderada | Excelente | Excelente |
| *Naturalidad* | Robótica | Moderada | Excelente | Excelente |
| *Info actualizada* | Manual | Manual | No | Automática |
| *Mantenimiento* | Alto | Alto | Medio | Bajo |
| *Precisión datos* | Alta (si actualizado) | Alta (si actualizado) | Riesgo alucinaciones | Alta (datos reales) |

== Desafíos en Implementación

=== Desafíos Técnicos

*Latencia*
- Generación de embeddings y búsqueda vectorial añaden tiempo
- Solución: Índices HNSW en pgvector, caché de embeddings frecuentes

*Calidad de Embeddings*
- El texto de productos debe ser descriptivo para buenos embeddings
- Solución: Enriquecer descripciones con ingredientes, categorías, tags

*Manejo de Contexto*
- El chatbot debe saber cuándo buscar en la BD vs responder directamente
- Solución: Prompts bien diseñados con instrucciones claras

=== Desafíos de Experiencia de Usuario

*Expectativas*
- Usuarios pueden sobreestimar capacidades del chatbot
- Solución: Establecer expectativas claras, sugerir qué puede hacer

*Escalamiento*
- Algunos casos requieren intervención humana
- Solución: Mecanismo de derivación a personal del restaurante

== Métricas de Evaluación

*Precisión de Respuestas*
- Porcentaje de respuestas correctas y actualizadas
- Meta: >95% de precisión en consultas sobre menú y precios

*Relevancia de Búsqueda*
- Calidad de los resultados de búsqueda semántica
- Medición: Score de similitud promedio de resultados utilizados

*Tiempo de Respuesta*
- Latencia desde consulta hasta respuesta completa
- Meta: menor a 3 segundos para consultas simples

*Satisfacción del Usuario*
- Encuestas post-interacción (escala 1-5)
- Meta: Promedio >4.0

== Casos de Uso en Restaurante Bambú

El chatbot con RAG en este proyecto aborda:

*Consultas de Menú*
- "¿Qué platos vegetarianos tienen?"
- "¿Cuál es el platillo más popular?"
- "¿Tienen opciones sin gluten?"

*Recomendaciones Personalizadas*
- "¿Qué me recomiendas si me gustó el lomo saltado?"
- "Quiero algo similar a lo que pedí la vez pasada"

*Información de Reservaciones*
- "¿Tienen mesa disponible para 4 personas el sábado?"
- "¿Cuál es el horario de atención?"

*Asistencia General*
- "¿Qué métodos de pago aceptan?"
- "¿Aceptan tarjeta de débito?"

Cada consulta se resuelve con información actualizada obtenida mediante búsqueda semántica en la base de datos, garantizando precisión y mejorando significativamente la experiencia del usuario comparado con chatbots tradicionales.

La combinación de capacidades conversacionales avanzadas de LLMs con acceso a datos en tiempo real mediante RAG y pgvector representa una solución robusta para asistentes virtuales en negocios, adaptada específicamente al contexto del Restaurante Bambú.
