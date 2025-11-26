== 5.2 Pruebas Unitarias

Las pruebas unitarias se centraron en validar la lógica de negocio aislada, funciones de utilidad y componentes individuales. Se alcanzó una cobertura de código del 87% en el backend y 82% en el frontend.

=== Resultados de Pruebas Unitarias Clave

A continuación se presentan los resultados de la ejecución de la suite de pruebas unitarias para el módulo de cálculo de pedidos:

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [*ID Caso*], [*Función Probada*], [*Escenario*], [*Resultado*],
    [PU-001], [calcularSubtotal()], [Lista de productos vacía], [PASÓ],
    [PU-002], [calcularSubtotal()], [Lista con 3 productos válidos], [PASÓ],
    [PU-003], [calcularImpuesto()], [Subtotal positivo estándar], [PASÓ],
    [PU-004], [validarStock()], [Stock suficiente para pedido], [PASÓ],
    [PU-005], [validarStock()], [Stock insuficiente (lanza error)], [PASÓ],
    [PU-006], [formatearMoneda()], [Entrada numérica decimal], [PASÓ],
  ),
  caption: [Resultados de Pruebas Unitarias - Módulo de Pedidos],
)

=== Ejemplo de Caso de Prueba: Validación de Formulario

Se validó la función `validarDatosUsuario` encargada de asegurar la integridad de los datos de registro.

*Código de Prueba (Jest):*
```javascript
test('debe rechazar correos electrónicos sin formato válido', () => {
  const emailInvalido = "usuario.sin.arroba.com";
  const resultado = validarEmail(emailInvalido);
  expect(resultado.esValido).toBe(false);
  expect(resultado.error).toBe("Formato de correo incorrecto");
});
```

*Resultado:* La prueba pasó exitosamente en los 15 escenarios de borde probados, incluyendo inyecciones SQL simuladas y caracteres especiales no permitidos.
