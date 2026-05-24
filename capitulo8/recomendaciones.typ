== Recomendaciones

#v(1em)
Con el propósito de garantizar la mejora continua y escalar las capacidades del sistema desarrollado, se plantean las siguientes recomendaciones técnicas y comerciales:

1. *Expansión a Plataformas Móviles Nativas:* Aunque el sistema actual es responsivo y funcional en navegadores de dispositivos móviles, se recomienda a futuro el desarrollo de una aplicación nativa (ej. utilizando React Native o Flutter) que consuma la misma API de Supabase. Esto permitiría enviar notificaciones Push (Push Notifications) directas a los clientes sobre promociones y el estado de sus reservaciones, mejorando la fidelización.

2. *Programa de Lealtad y Gamificación:* Se sugiere implementar un módulo de "Puntos de Cliente Frecuente" vinculado al sistema de recomendaciones por Inteligencia Artificial. Esto permitiría otorgar recompensas automáticas o cupones de descuento personalizados cuando la IA detecte patrones de compra recurrentes, fomentando un mayor flujo de ventas y retorno de clientes.

3. *Integración con Sistemas de Delivery Externos:* Para expandir el alcance funcional (superando uno de los límites actuales del proyecto), se recomienda desarrollar webhooks e integraciones por API con plataformas de delivery consolidadas en Bolivia (como PedidosYa o Yango). Esto centralizaría en un solo panel administrativo todos los pedidos (tanto presenciales como en línea), unificando el control de caja y los reportes financieros.

4. *Entrenamiento Continuo de los Modelos Predictivos:* Dado que la precisión del módulo de predicción de demanda mejora a medida que se recopilan más datos, se recomienda realizar auditorías trimestrales a la base de datos histórica. Asimismo, se aconseja incluir variables externas en futuros algoritmos de predicción, tales como condiciones climáticas de El Alto o festividades locales, para aumentar el porcentaje de confianza en las estimaciones de afluencia de clientes.
