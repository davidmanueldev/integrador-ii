== 5.5 Pruebas de Aceptación

Las pruebas de aceptación se llevaron a cabo con un grupo de control conformado por 6 empleados del Restaurante Bambú (2 meseros, 1 cajero, 1 cocinero, 1 encargado de reservaciones, 1 gerente) y 12 clientes frecuentes seleccionados aleatoriamente.

=== Validación de Usabilidad (SUS)

Se aplicó la escala de usabilidad del sistema (System Usability Scale - SUS) después de que los participantes completaran tareas predefinidas correspondientes a cada módulo.

*Resultados SUS por Módulo:*

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [*Módulo*], [*Puntaje SUS*], [*Interpretación*],
    [Sistema de Reservaciones], [88/100], [Excelente],
    [Punto de Venta (POS)], [84/100], [Excelente],
    [Panel Administrativo], [82/100], [Muy Bueno],
    [Chatbot Inteligente], [86/100], [Excelente],
  ),
  caption: [Resultados SUS por Módulo del Sistema],
)

*Métricas Generales:*
- *Puntaje Promedio General:* 85/100 (Interpretación: "Excelente").
- *Facilidad de Aprendizaje:* 9.1/10.
- *Confianza en el Sistema:* 8.9/10.

=== Encuesta de Satisfacción del Chatbot

Se evaluó específicamente la interacción con el asistente virtual potenciado por búsqueda semántica y RAG.

#figure(
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: horizon,
    [*Pregunta*], [*Calificación Promedio (1-5)*],
    [¿Las respuestas fueron útiles y precisas?], [4.7],
    [¿El tiempo de respuesta fue adecuado?], [4.6],
    [¿La información sobre precios y disponibilidad fue correcta?], [4.9],
    [¿Las recomendaciones de platillos fueron acertadas?], [4.4],
    [¿El chatbot entendió correctamente sus consultas?], [4.5],
  ),
  caption: [Resultados de Encuesta de Satisfacción - Módulo Chatbot],
)

=== Validación de Funcionalidades de IA

Se realizaron pruebas específicas para validar las funcionalidades de inteligencia artificial:

*Sistema de Recomendaciones:*
- Se presentaron recomendaciones a 12 clientes basadas en su historial.
- *Hit Rate:* 75% de los clientes encontraron al menos una recomendación relevante entre las 3 principales.
- *Feedback cualitativo:* "Me sorprendió que recordara que no como mariscos" (Cliente #7).

*Predicción de Demanda:*
- Se compararon predicciones del modelo con datos reales de 2 semanas.
- *Error Absoluto Medio (MAE):* 8.3 pedidos por franja horaria.
- *Utilidad percibida:* El gerente indicó que las predicciones ayudaron a planificar turnos de personal.

*Análisis de Sentimiento:*
- Se procesaron 45 reseñas de prueba con sentimientos conocidos.
- *Precisión de clasificación:* 89% (positivo/negativo/neutro).
- *Valor agregado:* Identificación automática de quejas recurrentes sobre tiempos de espera.

=== Conclusión de Aceptación

El Gerente General del Restaurante Bambú firmó el acta de aceptación del sistema, destacando:

1. Cumplimiento del 100% de los requerimientos funcionales críticos.
2. La integración de pagos con Red Enlace funciona correctamente con tarjetas locales.
3. El sistema de reservaciones redujo significativamente las llamadas telefónicas.
4. Las funcionalidades de IA superaron las expectativas, especialmente el chatbot y las recomendaciones personalizadas.
5. El personal se adaptó rápidamente al nuevo sistema POS gracias a su interfaz intuitiva.
