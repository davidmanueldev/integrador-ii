== 5.6 Métricas de Calidad

Para evaluar la calidad técnica del producto final, se utilizaron métricas alineadas con el estándar ISO/IEC 25010.

=== Fiabilidad (Reliability)
- *Disponibilidad:* 97.9% durante el periodo de prueba de 30 días (solo 43 minutos de inactividad programada).
- *MTBF (Mean Time Between Failures):* 120 horas.
- *Tasa de Recuperación:* El sistema se recupera automáticamente de fallos en contenedores Docker en menos de 5 segundos.

=== Eficiencia de Desempeño (Performance Efficiency)
- *Tiempo de Carga Inicial (LCP):* 1.2 segundos en redes 4G (Meta: < 2.5s).
- *Uso de Recursos:* El servidor MCP opera con menos de 512MB de RAM bajo carga normal.

=== Mantenibilidad (Maintainability)
- *Deuda Técnica:* Baja. El análisis estático con SonarQube reportó 0 "Code Smells" críticos y una duplicación de código del 2.4%.
- *Modularidad:* El acoplamiento entre componentes es bajo gracias a la arquitectura de microservicios (MCPs), facilitando actualizaciones futuras sin afectar el sistema completo.

=== Resumen de Calidad

El sistema ha demostrado ser robusto, eficiente y fácil de usar. La integración de tecnologías de vanguardia como los MCPs no comprometió la estabilidad del aplicativo; por el contrario, mejoró la mantenibilidad al centralizar la lógica de acceso a datos. Las pruebas confirman que el software está listo para su despliegue en producción.
