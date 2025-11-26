== 4.2 Model Context Protocol (MCPs)

=== 4.2.1 Fundamentos de MCP

Model Context Protocol (MCP) es un estándar abierto que permite a los asistentes de Inteligencia Artificial conectarse de manera segura a fuentes de datos y herramientas externas. A diferencia de los enfoques tradicionales donde los datos se "inyectan" estáticamente en el prompt, MCP establece una arquitectura cliente-servidor estandarizada para el intercambio de contexto (Anthropic, 2024).

=== 4.2.2 Arquitectura MCP

La arquitectura MCP se compone de tres elementos principales:

- *MCP Host:* La aplicación anfitriona (como Claude Desktop o un IDE) que ejecuta el modelo de IA.
- *MCP Client:* El componente que inicia las conexiones y gestiona el ciclo de vida de la comunicación.
- *MCP Server:* Un servicio ligero que expone recursos (datos), herramientas (funciones ejecutables) y prompts a través del protocolo.

=== 4.2.3 Implementación en el Proyecto

En este sistema, se implementan servidores MCP personalizados que actúan como puente entre el chatbot y la base de datos del restaurante. Estos servidores exponen "Herramientas" específicas (e.g., `consultar_menu`, `verificar_estado_pedido`) que el LLM puede invocar bajo demanda. Esto garantiza que cada respuesta generada por el asistente se base en la información más reciente almacenada en MongoDB, eliminando las alucinaciones por datos desactualizados.
