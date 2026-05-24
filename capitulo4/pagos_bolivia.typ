== Pasarelas de Pago en Bolivia

=== Contexto del Comercio Electrónico en Bolivia

El comercio electrónico en Bolivia ha experimentado un crecimiento significativo, especialmente después de la pandemia de COVID-19. Sin embargo, el mercado presenta características particulares:

- *Preferencia por pagos en efectivo:* Históricamente dominante, aunque en declive
- *Adopción creciente de pagos QR:* Impulsada por bancos y entidades financieras
- *Limitada penetración de tarjetas de crédito:* Mayor uso de tarjetas de débito
- *Regulación estricta:* ASFI supervisa todas las operaciones financieras

=== Red Enlace

Red Enlace es la empresa líder en gestión de medios de pago electrónico en Bolivia, operando como procesador de pagos autorizado y supervisado por la Autoridad de Supervisión del Sistema Financiero (ASFI).

==== Servicios Principales

*Para comercios presenciales:*
- Terminales POS para cobro con tarjeta
- NewPOS con tecnología contactless
- Pagos con QR Simple

*Para comercios en línea:*
- CyberSource: Pasarela de pagos para e-commerce
- EON (Enlázate Online): Plataforma de cobros por internet
- Plugins para CMS (WordPress, Magento, PrestaShop)

==== Características de Red Enlace

- *Cobertura:* Acepta tarjetas VISA, Mastercard y American Express
- *Moneda:* Procesa en bolivianos (BOB) y dólares americanos (USD)
- *Seguridad:* Certificación PCI DSS y autenticación 3D Secure
- *Liquidación:* Depósito automático a cuenta bancaria boliviana
- *Comisión:* Hasta 2.5% por transacción

=== CyberSource

CyberSource es la pasarela de pagos de Red Enlace para comercio electrónico, basada en la tecnología de Visa.

==== Modalidades de Integración

*Secure Acceptance Hosted Checkout*
- Redirige al cliente a la página de pago de CyberSource
- Menor esfuerzo de integración
- CyberSource maneja la captura de datos de tarjeta

```
Usuario → Checkout del comercio → Redirect a CyberSource → Pago → Callback al comercio
```

*Secure Acceptance API*
- Formulario de pago personalizado en el sitio del comercio
- Mayor control sobre la experiencia de usuario
- Requiere cumplimiento de estándares PCI adicionales

*SOAP/REST API*
- Integración completa con web services
- Máxima flexibilidad y personalización
- Permite funcionalidades avanzadas (reversiones, consultas, reportes)

==== Flujo de Pago con CyberSource

```
1. Cliente completa pedido en el sistema
2. Sistema genera solicitud de pago a CyberSource
3. CyberSource procesa con el banco emisor
4. Autenticación 3D Secure (si aplica)
5. CyberSource retorna resultado (aprobado/rechazado)
6. Sistema confirma pedido y genera comprobante
7. Liquidación automática al cierre del día
```

==== Seguridad

*PCI DSS (Payment Card Industry Data Security Standard)*
- Red Enlace está certificada en PCI DSS
- Los datos de tarjeta nunca pasan por el servidor del comercio
- Tokenización de tarjetas para pagos recurrentes

*3D Secure 2.0*
- Autenticación adicional del tarjetahabiente
- Reduce fraudes y contracargos
- Verificación mediante OTP o app del banco

=== QR Simple

El QR Simple de Red Enlace es un método de pago mediante código QR estandarizado.

==== Funcionamiento

```
1. Comercio genera código QR con monto de la transacción
2. Cliente escanea QR con app de su banco
3. Cliente confirma pago en su aplicación bancaria
4. Banco notifica a Red Enlace
5. Red Enlace notifica al comercio (webhook o polling)
6. Comercio confirma recepción del pago
```

==== Ventajas del QR Simple

- *Sin hardware adicional:* No requiere terminal POS
- *Interoperabilidad:* Funciona con cualquier banco que soporte QR estándar
- *Costo reducido:* Comisiones menores que pagos con tarjeta
- *Experiencia familiar:* Los usuarios bolivianos están habituados a pagos QR

==== Tipos de QR

*QR Estático*
- Código fijo asociado al comercio
- El cliente ingresa el monto manualmente
- Útil para negocios pequeños

*QR Dinámico*
- Generado por cada transacción
- Incluye monto específico
- Mayor seguridad y trazabilidad

=== Requisitos de Afiliación

Para afiliarse a Red Enlace, el Restaurante Bambú debe cumplir:

*Documentación requerida:*
- Certificado de Inscripción (NIT)
- Cédula de identidad del propietario o representante legal
- Respaldo de cuenta bancaria boliviana

*Proceso de afiliación:*
1. Solicitud en línea o presencial
2. Verificación de documentos
3. Firma de contrato de adquirencia
4. Configuración técnica (credenciales API)
5. Pruebas en ambiente de desarrollo
6. Paso a producción

=== Integración Técnica

==== Credenciales y Configuración

```typescript
// Variables de entorno requeridas
const config = {
  merchantId: process.env.CYBERSOURCE_MERCHANT_ID,
  apiKeyId: process.env.CYBERSOURCE_API_KEY_ID,
  secretKey: process.env.CYBERSOURCE_SECRET_KEY,
  environment: process.env.NODE_ENV === 'production' 
    ? 'production' 
    : 'sandbox'
};
```

==== Manejo de Webhooks

CyberSource notifica eventos mediante webhooks:

```typescript
// Endpoint para recibir notificaciones
app.post('/api/webhooks/cybersource', async (req, res) => {
  const signature = req.headers['x-cybersource-signature'];
  
  // Verificar firma del webhook
  if (!verifySignature(req.body, signature)) {
    return res.status(401).send('Invalid signature');
  }
  
  const { transactionId, status, amount } = req.body;
  
  // Actualizar estado del pedido
  await actualizarEstadoPedido(transactionId, status);
  
  res.status(200).send('OK');
});
```

=== Comparativa con Pasarelas Internacionales

| Aspecto | Red Enlace | Stripe | PayPal |
|---------|------------|--------|--------|
| *Disponibilidad Bolivia* | Nativa | Limitada | Limitada |
| *Liquidación* | Cuenta local | Cuenta internacional | Cuenta PayPal |
| *Moneda* | BOB y USD | USD principalmente | USD |
| *Regulación* | ASFI | Internacional | Internacional |
| *QR nativo* | Sí | No | No |
| *Soporte local* | Sí (español) | No | No |

La selección de Red Enlace para este proyecto se justifica por su adaptación al contexto boliviano, la liquidación directa en cuenta local y el soporte para pagos QR ampliamente adoptados en el país.
