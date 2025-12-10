// Capítulo 5: Pruebas de Software y Evaluación Económica

// Importar configuración APA
#import "config/apa-setup.typ": *

// Aplicar configuración APA al documento
#show: apa-config

= CAPÍTULO V: PRUEBAS DE SOFTWARE Y EVALUACIÓN ECONÓMICA

== Convenciones y Definición de Variables

Antes de presentar las métricas de pruebas de software, se definen las variables y fórmulas utilizadas en este capítulo para garantizar claridad y consistencia en los cálculos.

#figure(
  table(
    columns: (1fr, 2fr, 1.5fr),
    inset: 8pt,
    align: (center, left, left),
    table.header(
      [*Variable*], [*Descripción*], [*Unidad*],
    ),
    [DEF], [Número de defectos encontrados], [Cantidad],
    [DEF#sub[C]], [Número de defectos corregidos], [Cantidad],
    [LOC], [Líneas de código del módulo], [Líneas],
    [KLOC], [Miles de líneas de código (LOC/1000)], [Miles de líneas],
    [DD], [Densidad de defectos], [Defectos/KLOC],
    [DRE], [Eficiencia de remoción de defectos], [Porcentaje (%)],
    [TPS], [Transacciones por segundo], [Transacciones/s],
    [SSR], [Server-Side Rendering], [-],
    [VAN], [Valor Actual Neto], [Bs.],
    [TIR], [Tasa Interna de Retorno], [Porcentaje (%)],
  ),
  caption: [Definición de variables y unidades],
) <tabla-variables>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]


== Mapa Navegacional del Sistema

El sistema de pedidos en línea para Restaurante Bambú cuenta con diferentes niveles de acceso según el tipo de usuario. A continuación, se presentan los mapas navegacionales correspondientes a cada perfil de usuario.

El primer mapa navegacional está relacionado con las opciones que están disponibles para cualquier usuario público en general sin la necesidad de estar registrado en el sistema de información.

#pagebreak()

#figure(
  image("diagrama1.png", width: 100%),
  caption: [Mapa de navegación – usuario público (Guest)],
) <fig-mapa-navegacion-publico>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

#pagebreak()

*Opciones disponibles para usuario público:*
- Página de inicio
- Visualizar menú de productos
- Ver detalles de productos (descripción, precio, imagen)
- Búsqueda y filtrado de productos por categoría
- Registro de nueva cuenta
- Inicio de sesión
- Información del restaurante
- Horarios de atención

El segundo mapa navegacional está relacionado con las opciones que están disponibles para el usuario de tipo cliente registrado, en el cual tendrá la posibilidad de realizar pedidos, gestionar su carrito de compras, realizar pagos, visualizar historial de pedidos, gestionar direcciones de entrega, etc.

#pagebreak()

#figure(
  image("diagrama2.png", width: 100%),
  caption: [Mapa de navegación – usuario cliente],
) <fig-mapa-navegacion-cliente>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

#pagebreak()

*Opciones disponibles para usuario cliente:*
- Todas las opciones del usuario público
- Gestión del carrito de compras
  - Agregar productos al carrito
  - Modificar cantidades
  - Eliminar productos del carrito
- Proceso de checkout
  - Selección de dirección de entrega
  - Selección de método de pago
  - Confirmación de pedido
- Gestión de perfil
  - Actualizar datos personales
  - Gestionar direcciones de entrega
  - Cambiar contraseña
- Visualizar historial de pedidos
- Seguimiento de pedidos en tiempo real
- Valorar y comentar productos
- Gestionar métodos de pago guardados

El tercer mapa navegacional está relacionado con las opciones que están disponibles para el usuario de tipo administrador, en el cual tendrá la posibilidad de gestionar productos, categorías, pedidos, usuarios y configuraciones del sistema.

#pagebreak()

#figure(
  image("diagrama3.png", width: 100%),
  caption: [Mapa navegacional – usuario administrador],
) <fig-mapa-navegacion-admin>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

#pagebreak()

*Opciones disponibles para usuario administrador:*
- Panel de administración (Dashboard)
  - Estadísticas de ventas
  - Gráficos de productos más vendidos
  - Reporte de ingresos
  - Pedidos pendientes
- Gestión de productos
  - Crear nuevo producto
  - Modificar producto existente
  - Eliminar producto
  - Gestionar stock/disponibilidad
  - Subir imágenes de productos
- Gestión de categorías
  - Crear nueva categoría
  - Modificar categoría existente
  - Eliminar categoría
- Gestión de pedidos
  - Visualizar todos los pedidos
  - Filtrar pedidos por estado
  - Actualizar estado de pedidos
  - Ver detalles completos de pedidos
- Gestión de usuarios
  - Visualizar lista de clientes
  - Ver detalles de usuarios
  - Modificar permisos
- Configuración del sistema
  - Configurar métodos de pago
  - Configurar zonas de entrega
  - Configurar horarios de atención
  - Gestionar banners y promociones


== Pruebas de Software

Para el presente proyecto se optó por realizar pruebas de caja negra con el fin de proporcionar una buena experiencia de manejo al usuario final, así como pruebas funcionales, de rendimiento y seguridad, las cuales se detallan a continuación.

=== Métricas de Calidad de Software

Para la medición de la calidad del software se utilizan las siguientes métricas estándar según ISTQB (International Software Testing Qualifications Board):

*Eficiencia de Remoción de Defectos (DRE - Defect Removal Efficiency)*

Esta métrica mide el porcentaje de defectos que fueron corregidos respecto a los encontrados:

$ "DRE" = ("DEF"_C / "DEF") times 100% $

Donde:
- $"DEF"_C$ = Número de defectos corregidos
- $"DEF"$ = Número de defectos encontrados

#figure(
  table(
    columns: (1fr, 2fr),
    inset: 8pt,
    align: (center, left),
    table.header(
      [*Variable*], [*Descripción*],
    ),
    [DEF], [Número de defectos encontrados durante las pruebas],
    [DEF#sub[C]], [Número de defectos corregidos],
    [DRE], [Eficiencia de remoción de defectos (%)],
  ),
  caption: [Variables para el cálculo de DRE],
) <tabla-variables-dre>
#v(0.5em)
#align(center)[_Fuente: Elaborado según ISTQB_]

*Densidad de Defectos (DD - Defect Density)*

Esta métrica mide la cantidad de defectos encontrados por cada mil líneas de código (KLOC):

$ "DD" = ("DEF" / "LOC") times 1000 $

Donde:
- $"DEF"$ = Número de defectos encontrados
- $"LOC"$ = Líneas de código del módulo
- El resultado se expresa en defectos por KLOC (miles de líneas de código)

#figure(
  table(
    columns: (1fr, 2fr),
    inset: 8pt,
    align: (center, left),
    table.header(
      [*Variable*], [*Descripción*],
    ),
    [DEF], [Número de defectos encontrados],
    [LOC], [Líneas de código del módulo evaluado],
    [DD], [Densidad de defectos (defectos/KLOC)],
  ),
  caption: [Variables para el cálculo de densidad de defectos],
) <tabla-variables-dd>
#v(0.5em)
#align(center)[_Fuente: Elaborado según ISTQB_]

*Nota:* Un valor de DD menor a 5 defectos/KLOC se considera aceptable para software comercial. Valores menores a 2 defectos/KLOC se consideran excelentes.


=== Ficha de Pruebas de Software - Módulo de Autenticación

*Descripción:* Prueba de caja negra – Módulos de autenticación y sesiones \
*Actores:* Administrador y Cliente

*Proceso realizado en el sistema:*

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (center, left, center, center, center, center, left, left),
    table.header(
      [*Nro.*], [*Proceso*], [*Usuarios*], [*Intentos*], [*Respuestas*], [*Defectos*], [*Tipo Error*], [*Solución*],
    ),
    [1], [Registro de usuario], [5], [10], [10], [0], [-], [-],
    [2], [Inicio de sesión], [5], [15], [15], [0], [-], [-],
    [3], [Cierre de sesión], [5], [5], [5], [0], [-], [-],
    [4], [Recuperación contraseña], [3], [6], [5], [1], [Validación email], [Validación backend],
    [5], [Actualizar perfil], [4], [8], [8], [0], [-], [-],
    [6], [Validación tokens JWT], [3], [9], [8], [1], [Expiración], [Ajustar a 24h],
    table.cell(colspan: 2)[*TOTAL*], [*25*], [*53*], [*51*], [*2*], [], [],
  ),
  caption: [Prueba de software – Módulo de autenticación],
) <tabla-prueba-autenticacion>
#v(0.5em)
#align(center)[_Fuente: Elaborado según ISTQB_]

*Análisis de resultados:*

Mediante pruebas y revisiones de las funciones del módulo se encontraron 2 defectos, los cuales fueron corregidos en su totalidad.

*Cálculo de DRE (Eficiencia de Remoción de Defectos):*
- Defectos encontrados (DEF) = 2
- Defectos corregidos (DEF#sub[C]) = 2

$ "DRE" = (2 / 2) times 100% = 100% $

*Cálculo de Densidad de Defectos:*
- Defectos encontrados (DEF) = 2
- Líneas de código (LOC) = 1250

$ "DD" = (2 / 1250) times 1000 = 1.6 " defectos/KLOC" $

Esto equivale a una densidad del *0.16%*, lo cual indica que el módulo de autenticación tiene una calidad excelente (DD \< 2 defectos/KLOC).


=== Ficha de Pruebas de Software - Módulo de Gestión de Productos

*Descripción:* Prueba de caja negra – Módulo de productos y categorías \
*Actores:* Administrador

*Proceso realizado en el sistema:*

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (center, left, center, center, center, center, left, left),
    table.header(
      [*Nro.*], [*Proceso*], [*Usuarios*], [*Intentos*], [*Respuestas*], [*Defectos*], [*Tipo Error*], [*Solución*],
    ),
    [1], [Crear producto], [3], [12], [11], [1], [Subida imágenes], [Límite tamaño],
    [2], [Modificar producto], [3], [9], [9], [0], [-], [-],
    [3], [Eliminar producto], [3], [6], [6], [0], [-], [-],
    [4], [Crear categoría], [2], [5], [5], [0], [-], [-],
    [5], [Modificar categoría], [2], [4], [4], [0], [-], [-],
    [6], [Eliminar categoría], [2], [3], [3], [0], [-], [-],
    [7], [Gestionar stock], [3], [8], [7], [1], [Cantidades negativas], [Validación],
    table.cell(colspan: 2)[*TOTAL*], [*17*], [*47*], [*45*], [*2*], [], [],
  ),
  caption: [Prueba de software – Módulo de gestión de productos],
) <tabla-prueba-productos>
#v(0.5em)
#align(center)[_Fuente: Elaborado según ISTQB_]

*Análisis de resultados:*

Mediante pruebas y revisiones de las funciones del módulo se encontraron 2 defectos, los cuales fueron corregidos en su totalidad.

*Cálculo de DRE (Eficiencia de Remoción de Defectos):*
- Defectos encontrados (DEF) = 2
- Defectos corregidos (DEF#sub[C]) = 2

$ "DRE" = (2 / 2) times 100% = 100% $

*Cálculo de Densidad de Defectos:*
- Defectos encontrados (DEF) = 2
- Líneas de código (LOC) = 1580

$ "DD" = (2 / 1580) times 1000 = 1.27 " defectos/KLOC" $

Esto equivale a una densidad del *0.13%*, lo cual indica que el módulo de gestión de productos tiene una calidad excelente (DD \< 2 defectos/KLOC).


=== Ficha de Pruebas de Software - Módulo de Carrito y Checkout

*Descripción:* Prueba de caja negra – Módulo de carrito de compras y proceso de checkout \
*Actores:* Cliente

*Proceso realizado en el sistema:*

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (center, left, center, center, center, center, left, left),
    table.header(
      [*Nro.*], [*Proceso*], [*Usuarios*], [*Intentos*], [*Respuestas*], [*Defectos*], [*Tipo Error*], [*Solución*],
    ),
    [1], [Agregar al carrito], [6], [24], [24], [0], [-], [-],
    [2], [Modificar cantidad], [5], [15], [14], [1], [Sincronización stock], [Verificación real],
    [3], [Eliminar del carrito], [5], [10], [10], [0], [-], [-],
    [4], [Calcular total], [5], [12], [12], [0], [-], [-],
    [5], [Proceso checkout], [5], [15], [13], [2], [Validación dirección], [Mejorar validación],
    [6], [Integración Stripe], [4], [12], [11], [1], [Webhook], [Configurar webhook],
    [7], [Confirmación pedido], [5], [10], [10], [0], [-], [-],
    table.cell(colspan: 2)[*TOTAL*], [*35*], [*98*], [*94*], [*4*], [], [],
  ),
  caption: [Prueba de software – Módulo de carrito y checkout],
) <tabla-prueba-carrito>
#v(0.5em)
#align(center)[_Fuente: Elaborado según ISTQB_]

*Análisis de resultados:*

Mediante pruebas y revisiones de las funciones del módulo se encontraron 4 defectos, los cuales fueron corregidos en su totalidad.

*Cálculo de DRE (Eficiencia de Remoción de Defectos):*
- Defectos encontrados (DEF) = 4
- Defectos corregidos (DEF#sub[C]) = 4

$ "DRE" = (4 / 4) times 100% = 100% $

*Cálculo de Densidad de Defectos:*
- Defectos encontrados (DEF) = 4
- Líneas de código (LOC) = 2150

$ "DD" = (4 / 2150) times 1000 = 1.86 " defectos/KLOC" $

Esto equivale a una densidad del *0.19%*, lo cual indica que el módulo de carrito y checkout tiene una calidad excelente (DD \< 2 defectos/KLOC).


=== Ficha de Pruebas de Software - Módulo de Gestión de Pedidos

*Descripción:* Prueba de caja negra – Módulo de pedidos \
*Actores:* Administrador y Cliente

*Proceso realizado en el sistema:*

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (center, left, center, center, center, center, left, left),
    table.header(
      [*Nro.*], [*Proceso*], [*Usuarios*], [*Intentos*], [*Respuestas*], [*Defectos*], [*Tipo Error*], [*Solución*],
    ),
    [1], [Crear pedido], [5], [15], [15], [0], [-], [-],
    [2], [Ver pedidos (Admin)], [3], [9], [9], [0], [-], [-],
    [3], [Ver historial (Cliente)], [5], [12], [12], [0], [-], [-],
    [4], [Actualizar estado], [3], [12], [11], [1], [Notificación interna], [Sistema webhooks],
    [5], [Filtrar por estado], [3], [8], [8], [0], [-], [-],
    [6], [Ver detalles pedido], [5], [10], [10], [0], [-], [-],
    table.cell(colspan: 2)[*TOTAL*], [*24*], [*66*], [*65*], [*1*], [], [],
  ),
  caption: [Prueba de software – Módulo de gestión de pedidos],
) <tabla-prueba-pedidos>
#v(0.5em)
#align(center)[_Fuente: Elaborado según ISTQB_]

*Nota:* El defecto de "Notificación interna" se refiere a notificaciones mediante webhooks internos del sistema, no a notificaciones por correo electrónico (funcionalidad excluida del alcance del MVP).

*Análisis de resultados:*

Mediante pruebas y revisiones de las funciones del módulo se encontró 1 defecto, el cual fue corregido.

*Cálculo de DRE (Eficiencia de Remoción de Defectos):*
- Defectos encontrados (DEF) = 1
- Defectos corregidos (DEF#sub[C]) = 1

$ "DRE" = (1 / 1) times 100% = 100% $

*Cálculo de Densidad de Defectos:*
- Defectos encontrados (DEF) = 1
- Líneas de código (LOC) = 1420

$ "DD" = (1 / 1420) times 1000 = 0.70 " defectos/KLOC" $

Esto equivale a una densidad del *0.07%*, lo cual indica que el módulo de gestión de pedidos tiene una calidad excelente (DD \< 1 defecto/KLOC).


=== Resumen de Métricas de Calidad por Módulo

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1fr, 1fr, 1.2fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Módulo*], [*DEF*], [*DEF#sub[C]*], [*LOC*], [*DRE*], [*DD (def/KLOC)*],
    ),
    [Autenticación], [2], [2], [1250], [100%], [1.60],
    [Gestión de productos], [2], [2], [1580], [100%], [1.27],
    [Carrito y checkout], [4], [4], [2150], [100%], [1.86],
    [Gestión de pedidos], [1], [1], [1420], [100%], [0.70],
    [*TOTAL*], [*9*], [*9*], [*6400*], [*100%*], [*1.41*],
  ),
  caption: [Resumen de métricas de calidad por módulo],
) <tabla-resumen-metricas>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

La densidad de defectos promedio del sistema es de *1.41 defectos/KLOC*, lo cual se encuentra dentro del rango de calidad excelente para software comercial.


== Pruebas de Rendimiento

Para las pruebas de rendimiento se utilizó la herramienta Artillery para simular diferentes escenarios de carga y medir el comportamiento del sistema bajo condiciones de uso normal, pico de tráfico y estrés.

=== Escenario de Carga Normal

*Parámetros de prueba:*
- Usuarios concurrentes: 50
- Duración: 10 minutos
- TPS objetivo: 5-10 transacciones por segundo

*Resultados obtenidos:*

#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Métrica*], [*Valor*], [*Estado*],
    ),
    [Tiempo de respuesta promedio (APIs)], [320ms], [✓ Aprobado (\<500ms)],
    [Tiempo de carga de página (SSR)], [1.5s], [✓ Aprobado (\<2s)],
    [Percentil 95], [780ms], [✓ Aprobado (\<1s)],
    [Tasa de error], [0.2%], [✓ Aprobado (\<1%)],
    [TPS alcanzado], [8.5], [✓ Aprobado],
  ),
  caption: [Resultados de prueba de carga normal],
) <tabla-carga-normal>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

=== Escenario de Pico de Tráfico

*Parámetros de prueba:*
- Usuarios concurrentes: 200
- Duración: 5 minutos
- TPS objetivo: 20-30 transacciones por segundo

*Resultados obtenidos:*

#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Métrica*], [*Valor*], [*Estado*],
    ),
    [Tiempo de respuesta promedio (APIs)], [485ms], [✓ Aprobado (\<500ms)],
    [Tiempo de carga de página (SSR)], [1.8s], [✓ Aprobado (\<2s)],
    [Percentil 95], [950ms], [✓ Aprobado (\<1s)],
    [Tasa de error], [0.8%], [✓ Aprobado (\<1%)],
    [TPS alcanzado], [25.3], [✓ Aprobado],
  ),
  caption: [Resultados de prueba de pico de tráfico],
) <tabla-pico-trafico>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

=== Escenario de Estrés

*Parámetros de prueba:*
- Usuarios concurrentes: 500
- Duración: 2 minutos
- TPS objetivo: 50+ transacciones por segundo

*Resultados obtenidos:*

#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Métrica*], [*Valor*], [*Estado*],
    ),
    [Tiempo de respuesta promedio (APIs)], [1.2s], [⚠ Advertencia],
    [Tiempo de carga de página (SSR)], [3.5s], [⚠ Advertencia],
    [Percentil 95], [2.8s], [⚠ Advertencia],
    [Tasa de error], [2.5%], [⚠ Advertencia],
    [TPS alcanzado], [48.7], [⚠ Advertencia],
  ),
  caption: [Resultados de prueba de estrés],
) <tabla-estres>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

*Análisis del escenario de estrés:*

Los resultados muestran que el sistema comienza a degradarse con 500 usuarios concurrentes. Esto es aceptable considerando que el tráfico esperado en condiciones normales es de 50-100 usuarios concurrentes. Para escenarios de mayor demanda, se recomiendan las siguientes acciones:

1. Implementar índices adicionales en la base de datos MongoDB
2. Configurar sistema de caché con Redis
3. Aumentar el pool de conexiones a la base de datos
4. Considerar escalado horizontal con balanceador de carga
5. Implementar CDN para recursos estáticos
6. Optimizar consultas costosas identificadas en los logs


== Pruebas de Seguridad

Para las pruebas de seguridad se validaron las amenazas del OWASP Top 10, utilizando herramientas como OWASP ZAP (versión 2.14.0) y Postman, además de pruebas manuales. Las pruebas fueron ejecutadas el 10 de noviembre de 2024 en ambiente de desarrollo.

=== Validación de Amenazas

#figure(
  table(
    columns: (1.2fr, 1.5fr, 1fr, 1.5fr, 0.8fr),
    inset: 6pt,
    align: center,
    table.header(
      [*Amenaza*], [*Prueba Realizada*], [*Herramienta*], [*Resultado*], [*Estado*],
    ),
    [Inyección SQL/NoSQL], [Inputs maliciosos en formularios y APIs], [OWASP ZAP], [Sin vulnerabilidades], [✓ Aprobado],
    [XSS], [Scripts en campos de entrada], [OWASP ZAP], [Sin vulnerabilidades], [✓ Aprobado],
    [CSRF], [Requests no autorizados], [Postman], [Tokens implementados], [✓ Aprobado],
    [Autenticación débil], [Fuerza bruta controlada], [Manual], [Rate limiting OK], [✓ Aprobado],
    [Exposición de datos], [Revisión de responses], [DevTools], [Datos protegidos], [✓ Aprobado],
    [Almacenamiento inseguro], [Revisión de cookies], [DevTools], [httpOnly OK], [✓ Aprobado],
  ),
  caption: [Resultados de pruebas de seguridad],
) <tabla-seguridad>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

*Nota:* Los reportes completos de OWASP ZAP se encuentran disponibles en los anexos del proyecto. Las pruebas de fuerza bruta fueron ejecutadas únicamente en ambiente de desarrollo con autorización previa.

=== Checklist de Seguridad Implementado

- ✓ Contraseñas hasheadas utilizando bcrypt (10 rounds)
- ✓ Sesiones implementadas con httpOnly cookies
- ✓ Variables sensibles (API keys, secrets) almacenadas en archivo .env
- ✓ Validación de inputs tanto en cliente como en servidor
- ✓ Rate limiting implementado en APIs críticas (login, registro, checkout)
- ✓ HTTPS configurado para ambiente de producción
- ✓ Verificación de webhooks de Stripe mediante firma digital
- ✓ Sanitización de inputs para prevenir XSS
- ✓ Tokens JWT con tiempo de expiración de 24 horas
- ✓ Protección CORS configurada correctamente


== Costos del Proyecto

=== Costos de Personal

*COSTOS DE DESARROLLO (Expresado en bolivianos)*

#figure(
  table(
    columns: (2fr, 0.8fr, 1.2fr, 0.8fr, 1.2fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Rol*], [*Cantidad*], [*Sueldo Mensual (Bs.)*], [*Meses*], [*Subtotal (Bs.)*],
    ),
    [Desarrollador Full Stack Senior], [1], [8000], [2], [16000],
    [Desarrollador Backend], [1], [6000], [2], [12000],
    [Diseñador UI/UX], [1], [5000], [1], [5000],
    [QA Tester], [1], [4500], [1], [4500],
    table.cell(colspan: 4)[*TOTAL*], [*Bs. 37500*],
  ),
  caption: [Costos de desarrollo del proyecto],
) <tabla-costos-desarrollo>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

*COSTOS DE ADMINISTRACIÓN (Expresado en bolivianos)*

#figure(
  table(
    columns: (2fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Concepto*], [*Monto (Bs.)*],
    ),
    [Gerente de Proyecto], [8000],
    [Análisis de requisitos], [3000],
    [Documentación técnica], [2500],
    [Reuniones con cliente], [1500],
    [*TOTAL*], [*Bs. 15000*],
  ),
  caption: [Costos de administración],
) <tabla-costos-admin>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

=== Costos de Hardware y Software

*COSTOS DE HARDWARE (Expresado en bolivianos)*

#figure(
  table(
    columns: (2fr, 0.8fr, 1.2fr, 1.2fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Equipo*], [*Cantidad*], [*Precio Unitario (Bs.)*], [*Subtotal (Bs.)*],
    ),
    [Laptop para desarrollo], [2], [8000], [16000],
    [Monitor adicional], [2], [1500], [3000],
    [Mouse y teclado], [2], [500], [1000],
    table.cell(colspan: 3)[*TOTAL*], [*Bs. 20000*],
  ),
  caption: [Costos de hardware],
) <tabla-costos-hardware>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

*COSTOS DE SOFTWARE Y SERVICIOS (Expresado en bolivianos)*

#figure(
  table(
    columns: (2fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Herramienta/Servicio*], [*Costo (Bs.)*],
    ),
    [Licencias de desarrollo], [2000],
    [Hosting y dominio (1 año)], [1500],
    [Servidor MongoDB Atlas], [800],
    [Servicio de email (SendGrid)], [500],
    [Servicio de almacenamiento (Cloudinary)], [600],
    [GitHub Pro], [400],
    [*TOTAL*], [*Bs. 5800*],
  ),
  caption: [Costos de software y servicios],
) <tabla-costos-software>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

=== Costos de Operación y Capacitación

*COSTOS DE OPERACIÓN MENSUAL - INFRAESTRUCTURA (Expresado en bolivianos)*

#figure(
  table(
    columns: (2fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Concepto*], [*Monto Mensual (Bs.)*],
    ),
    [Hosting y servidor (Vercel/Railway)], [500],
    [Base de datos MongoDB Atlas], [300],
    [Servicios de terceros (email, storage)], [200],
    [*TOTAL INFRAESTRUCTURA*], [*Bs. 1000*],
  ),
  caption: [Costos de operación mensual - Infraestructura],
) <tabla-costos-operacion>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

*COSTOS DE CAPACITACIÓN (Expresado en bolivianos)*

#figure(
  table(
    columns: (2fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Concepto*], [*Monto (Bs.)*],
    ),
    [Material de apoyo], [300],
    [Capacitador], [2500],
    [Sesiones de capacitación (3 sesiones)], [1500],
    [*TOTAL*], [*Bs. 4300*],
  ),
  caption: [Costos de capacitación],
) <tabla-costos-capacitacion>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

=== Resumen de Costos del Proyecto

*COSTO TOTAL DE INVERSIÓN INICIAL*

#figure(
  table(
    columns: (2fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Concepto*], [*Monto (Bs.)*],
    ),
    [Costos de desarrollo (personal)], [37500],
    [Costos de administración], [15000],
    [Costos de hardware], [20000],
    [Costos de software y servicios], [5800],
    [Costos de capacitación], [4300],
    [*INVERSIÓN INICIAL TOTAL*], [*Bs. 82600*],
  ),
  caption: [Costo total de inversión inicial del proyecto],
) <tabla-costo-total>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

#v(1em)
#align(center)[
  *Inversión inicial en Bolivianos:* Bs. 82,600 \
  *Inversión inicial en Dólares:* \$us. 11,868.97 \
  _(Tipo de cambio oficial BCB: 1 USD = 6.96 BOB, consultado el 15/11/2024)_
]


== Beneficios Proyectados

=== Costos Operacionales para Proyección Financiera

Para el cálculo del VAN y TIR, se consideran los siguientes costos operacionales mensuales:

#figure(
  table(
    columns: (2fr, 1fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Concepto*], [*Monto Mensual (Bs.)*],
    ),
    [Infraestructura (hosting, BD, servicios)], [1000],
    [Marketing digital], [2000],
    [Mantenimiento y soporte técnico], [1500],
    [Comisiones Stripe (3.5% sobre ventas)], [Variable],
    [*TOTAL FIJO*], [*Bs. 4500*],
  ),
  caption: [Costos operacionales mensuales para proyección],
) <tabla-costos-operacionales>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

=== Ingresos Mensuales Proyectados

*PROYECCIÓN DE INGRESOS (Expresado en bolivianos)*

#figure(
  table(
    columns: (1fr, 1.2fr, 1.2fr, 1.2fr),
    inset: 8pt,
    align: center,
    table.header(
      [*Mes*], [*Pedidos Estimados*], [*Ticket Promedio (Bs.)*], [*Ingreso Total (Bs.)*],
    ),
    [Mes 1], [150], [85], [12750],
    [Mes 2], [200], [85], [17000],
    [Mes 3], [250], [90], [22500],
    [Mes 4], [300], [90], [27000],
    [Mes 5], [350], [95], [33250],
    [Mes 6], [400], [95], [38000],
    [*TOTAL (6 meses)*], [*1650*], [], [*Bs. 150500*],
  ),
  caption: [Proyección de ingresos mensuales],
) <tabla-ingresos-proyectados>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]


== Cálculo de VAN y TIR

=== Valor Actual Neto (VAN)

El Valor Actual Neto es un procedimiento que permite calcular el valor presente de los flujos de caja futuros, originados por una inversión inicial. Refleja la diferencia entre el valor actual de los ingresos menos el valor actual de los egresos. La interpretación del VAN es:

- *VAN > 0* → El proyecto genera beneficio económico
- *VAN = 0* → El proyecto no genera beneficio ni pérdidas
- *VAN < 0* → El proyecto genera pérdidas en el período analizado

*Fórmula del VAN:*

$ "VAN" = -I_0 + sum_(t=1)^n F_t / (1+r)^t $

Donde:
- $I_0$ = Inversión inicial (Bs. 82,600)
- $F_t$ = Flujo de caja neto del período t
- $r$ = Tasa de descuento mensual (0.565% mensual, equivalente al 7% anual)
- $n$ = Número de períodos (6 meses)
- $t$ = Período de tiempo

*Nota:* Se utiliza una tasa de descuento del 7% anual (definida por el Estado Plurinacional de Bolivia), convertida a tasa mensual: $r_"mensual" = (1 + 0.07)^(1/12) - 1 = 0.00565 approx 0.565%$

*Cálculo de Flujos de Caja Netos:*

#figure(
  table(
    columns: (0.8fr, 1.2fr, 1fr, 1fr, 1.2fr, 1.2fr),
    inset: 7pt,
    align: center,
    table.header(
      [*Mes*], [*Ingresos (Bs.)*], [*Costos Fijos*], [*Comisión 3.5%*], [*Flujo Neto*], [*VA del Flujo*],
    ),
    [1], [12750], [4500], [446.25], [7803.75], [7759.80],
    [2], [17000], [4500], [595.00], [11905.00], [11771.57],
    [3], [22500], [4500], [787.50], [17212.50], [16923.21],
    [4], [27000], [4500], [945.00], [21555.00], [21074.15],
    [5], [33250], [4500], [1163.75], [27586.25], [26815.51],
    [6], [38000], [4500], [1330.00], [32170.00], [31104.68],
    [*Total*], [*150500*], [*27000*], [*5267.50*], [*118232.50*], [*115448.92*],
  ),
  caption: [Cálculo de flujos de caja y valores actuales],
) <tabla-flujos-caja>
#v(0.5em)
#align(center)[_Fuente: Elaboración propia_]

*Cálculo del VAN:*

$ "VAN" = 115448.92 - 82600 = 32848.92 $

#align(center)[
  #box(stroke: 1pt, inset: 10pt)[
    $ "VAN" = "Bs." 32,848.92 > 0 $
  ]
]

*Interpretación:* El VAN positivo indica que el proyecto genera un beneficio económico de Bs. 32,848.92 en un período de 6 meses, considerando una tasa de descuento del 7% anual. Esto demuestra la viabilidad financiera del proyecto.


=== Tasa Interna de Retorno (TIR)

La Tasa Interna de Retorno es la tasa de descuento que hace que el VAN sea igual a cero. Es el rendimiento porcentual que genera la inversión.

*Fórmula de la TIR:*

$ sum_(t=1)^n F_t / (1+"TIR")^t - I_0 = 0 $

Para calcular la TIR, se utiliza el método de interpolación:

*Con r = 10% mensual:*
$ "VA total" = 7094.32 + 9839.67 + 12930.75 + 14723.76 + 17131.20 + 18159.02 = 79878.72 $
$ "VAN" = 79878.72 - 82600 = -2721.28 $

*Con r = 8% mensual:*
$ "VA total" = 7225.69 + 10209.02 + 13665.97 + 15845.53 + 18774.26 + 20266.85 = 85987.32 $
$ "VAN" = 85987.32 - 82600 = 3387.32 $

Por interpolación lineal:
$ "TIR" approx 8% + (3387.32 / (3387.32 + 2721.28)) times 2% $
$ "TIR" approx 8% + 1.11% = 9.11% " mensual" $

Convertido a tasa anual:
$ "TIR"_"anual" = (1 + 0.0911)^12 - 1 = 185.6% $

#align(center)[
  #box(stroke: 1pt, inset: 10pt)[
    $ "TIR"_"mensual" = 9.11% $
    $ "TIR"_"anual" = 185.6% $
  ]
]

*Interpretación:* La TIR del 9.11% mensual (equivalente a 185.6% anual) es significativamente superior a la tasa de descuento del 7% anual, lo cual confirma que el proyecto es altamente rentable y viable desde el punto de vista financiero.

=== Conclusiones del Análisis Financiero

1. *VAN positivo (Bs. 32,848.92):* El proyecto genera valor económico y recupera la inversión inicial en el período de 6 meses.

2. *TIR superior a la tasa de descuento:* Con una TIR mensual del 9.11%, el proyecto supera ampliamente el costo de oportunidad del capital.

3. *Período de recuperación:* La inversión se recupera aproximadamente en el mes 4-5 de operación.

4. *Recomendaciones para maximizar rentabilidad:*
   - Implementar estrategias de marketing digital para aumentar el volumen de pedidos
   - Optimizar costos operacionales mediante automatización
   - Expandir el catálogo de productos para aumentar el ticket promedio
   - Considerar expansión a delivery propio para reducir dependencia de terceros
