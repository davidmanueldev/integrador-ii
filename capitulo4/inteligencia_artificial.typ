== Inteligencia Artificial Aplicada a Restaurantes

La inteligencia artificial (IA) ha experimentado avances significativos en los últimos años, especialmente con el desarrollo de Grandes Modelos de Lenguaje (LLMs) y técnicas de procesamiento de lenguaje natural. Este proyecto aprovecha cuatro aplicaciones específicas de IA que aportan valor al sector gastronómico.

=== Embeddings y Búsqueda Semántica

==== Concepto de Embeddings

Los embeddings son representaciones vectoriales de texto que capturan el significado semántico de palabras, frases o documentos. A diferencia de la búsqueda tradicional basada en coincidencia exacta de palabras clave, los embeddings permiten encontrar contenido relacionado por significado.

```
Ejemplo de búsqueda tradicional vs semántica:

Consulta: "algo ligero para cenar"

Búsqueda tradicional: Busca productos que contengan las palabras "ligero" o "cenar"
Resultado: Puede no encontrar nada si ningún producto usa esas palabras exactas

Búsqueda semántica: Entiende que el usuario busca platillos con pocas calorías
Resultado: Encuentra ensaladas, sopas, pescado a la plancha, etc.
```

==== Implementación con pgvector

Supabase integra la extensión pgvector de PostgreSQL, que permite almacenar y consultar vectores de alta dimensionalidad directamente en la base de datos:

```sql
-- Habilitar extensión pgvector
CREATE EXTENSION vector;

-- Tabla de productos con embedding
CREATE TABLE productos (
  id SERIAL PRIMARY KEY,
  nombre TEXT,
  descripcion TEXT,
  embedding VECTOR(1536)  -- Dimensión de OpenAI text-embedding-3-small
);

-- Búsqueda por similitud semántica
SELECT nombre, descripcion
FROM productos
ORDER BY embedding <-> query_embedding
LIMIT 5;
```

==== Ventajas de pgvector

- *Integración nativa:* No requiere servicios externos de base de datos vectorial
- *Consistencia:* Los embeddings se almacenan junto a los datos relacionales
- *Transacciones:* Se pueden actualizar datos y embeddings en una sola transacción
- *Costo:* Incluido en Supabase sin cargos adicionales

=== Sistemas de Recomendación

==== Tipos de Sistemas de Recomendación

Los sistemas de recomendación predicen las preferencias del usuario basándose en diferentes enfoques:

*Filtrado Colaborativo*
- Recomienda basándose en usuarios con gustos similares
- "Usuarios que pidieron X también pidieron Y"
- Requiere datos históricos de múltiples usuarios

*Filtrado Basado en Contenido*
- Recomienda basándose en características de los productos
- "Si te gustó este platillo picante, te puede gustar este otro"
- Funciona con datos de un solo usuario

*Sistemas Híbridos*
- Combinan ambos enfoques
- Más robustos ante el problema de "cold start"

==== Implementación para Restaurantes

En el contexto de un restaurante, el sistema de recomendación considera:

```typescript
interface PreferenciasCliente {
  restricciones: string[];     // vegetariano, sin gluten, etc.
  alergias: string[];          // mariscos, lácteos, etc.
  saboresPreferidos: string[]; // picante, dulce, etc.
  historialPedidos: Pedido[];  // pedidos anteriores
}

function recomendarPlatillos(cliente: PreferenciasCliente): Producto[] {
  // 1. Filtrar productos que violen restricciones/alergias
  // 2. Ordenar por similitud con historial
  // 3. Priorizar categorías frecuentes
  // 4. Agregar variedad (no repetir lo mismo)
  return productosRecomendados;
}
```

=== Predicción de Demanda

==== Análisis de Series Temporales

La predicción de demanda analiza patrones históricos para estimar la afluencia futura:

*Patrones a considerar:*
- *Estacionalidad semanal:* Mayor demanda los fines de semana
- *Estacionalidad diaria:* Horas pico de almuerzo y cena
- *Tendencias:* Crecimiento o decrecimiento gradual
- *Eventos especiales:* Días festivos, fechas especiales

==== Modelo Simplificado

Para el contexto del proyecto, se implementa un modelo basado en promedios históricos:

```typescript
interface PrediccionDemanda {
  diaSemana: number;        // 0-6 (domingo-sábado)
  horaDelDia: number;       // 0-23
  aforoEstimado: number;    // número de clientes esperados
  confianza: number;        // 0-1 nivel de confianza
}

function predecirDemanda(fecha: Date): PrediccionDemanda {
  // Obtener histórico del mismo día de semana
  // Calcular promedio y desviación estándar
  // Ajustar por tendencias recientes
  return prediccion;
}
```

==== Aplicaciones Prácticas

- *Planificación de personal:* Asignar más meseros en horarios de alta demanda
- *Gestión de inventario:* Preparar más ingredientes para días pico
- *Ofertas dinámicas:* Promociones en horarios de baja afluencia

=== Análisis de Sentimiento

==== Procesamiento de Lenguaje Natural para Feedback

El análisis de sentimiento clasifica texto según la emoción o actitud expresada:

*Niveles de análisis:*
- *Polaridad:* Positivo, neutro, negativo
- *Intensidad:* Qué tan positivo o negativo
- *Aspectos:* Sentimiento hacia elementos específicos (comida, servicio, ambiente)

==== Implementación con LLMs

Los modelos de lenguaje modernos permiten análisis de sentimiento sofisticado:

```typescript
const prompt = `
Analiza la siguiente reseña de restaurante y extrae:
1. Sentimiento general (positivo/neutro/negativo)
2. Puntuación de 1 a 5
3. Aspectos mencionados (comida, servicio, ambiente, precio)
4. Sentimiento por cada aspecto
5. Resumen en una frase

Reseña: "${textoReseña}"
`;

const analisis = await llm.complete(prompt);
```

==== Dashboard de Insights

El sistema agrega los análisis individuales para mostrar:

- Tendencia de satisfacción en el tiempo
- Aspectos mejor y peor valorados
- Alertas para reseñas muy negativas
- Palabras clave frecuentes en feedback positivo y negativo

=== Consideraciones Éticas y Prácticas

==== Privacidad de Datos

- Los embeddings no almacenan el texto original, solo su representación numérica
- Los datos de preferencias se manejan con consentimiento del usuario
- Las reseñas se procesan de manera agregada para insights, manteniendo anonimato

==== Transparencia

- El chatbot indica claramente que es un asistente automatizado
- Las recomendaciones se presentan como sugerencias, no como imposiciones
- Los usuarios pueden optar por no participar en recolección de preferencias

==== Limitaciones Reconocidas

- La calidad de las predicciones mejora con más datos históricos
- El análisis de sentimiento puede malinterpretar sarcasmo o expresiones regionales
- Los embeddings requieren actualización cuando se agregan nuevos productos
