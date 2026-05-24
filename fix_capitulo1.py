import os
import re

files = {
    "capitulo1/resumen.typ": "== 1. Resumen ejecutivo\n\nEl presente proyecto propone el desarrollo de un Sistema Integral de Gestión para el Restaurante Bambú, integrando Inteligencia Artificial para optimizar las operaciones diarias y mejorar la experiencia del cliente. Este sistema aborda los desafíos actuales del restaurante, como la gestión ineficiente de reservaciones y el control de ventas presenciales, mediante la implementación de módulos de reservaciones en línea, punto de venta (POS) y la integración de la pasarela de pagos Red Enlace. Además, introduce funcionalidades innovadoras como un chatbot con búsqueda semántica, un sistema de recomendación de platillos, predicción de demanda y análisis de sentimiento de reseñas, proporcionando una solución tecnológica completa y adaptada al contexto boliviano.\n",
    "capitulo1/antecedentes.typ": None,
    "capitulo1/descripcion_objeto.typ": "== 3. Descripción del objeto de estudio\n\nEl objeto de estudio se centra en los procesos de gestión operativa, atención al cliente y administración de ventas del Restaurante Bambú, ubicado en la ciudad de El Alto, Bolivia. Se analiza específicamente la interacción entre el cliente y el restaurante durante el proceso de reservación y toma de pedidos, así como los mecanismos internos de control de caja y toma de decisiones basados en datos. La investigación abarca la evaluación de las herramientas tecnológicas necesarias para digitalizar y optimizar estos procesos, considerando las regulaciones locales para pagos electrónicos y la viabilidad de integrar soluciones de inteligencia artificial para mejorar la eficiencia y personalización del servicio.\n",
    "capitulo1/planteamiento.typ": None,
    "capitulo1/objetivos.typ": None,
    "capitulo1/justificacion.typ": None,
    "capitulo1/metodologia.typ": None,
    "capitulo1/alcances.typ": None
}

replacements = [
    (r'== 1\.2 Antecedentes', '== 2. Antecedentes'),
    (r'=== 1\.2\.1 Antecedentes', '=== 2.1 Antecedentes'),
    (r'=== 1\.2\.2 Antecedentes', '=== 2.2 Antecedentes'),
    (r'=== 1\.2\.3 Antecedentes', '=== 2.3 Antecedentes'),
    (r'==== Antecedentes Internacionales', '==== 2.3.1 Antecedentes Internacionales'),
    (r'==== Antecedentes Nacionales', '==== 2.3.2 Antecedentes Nacionales'),
    (r'==== Antecedentes Locales', '==== 2.3.3 Antecedentes Locales'),
    (r'=== 1\.2\.4 Diferenciación', '=== 2.4 Diferenciación'),
    (r'== 1\.3 Planteamiento del Problema', '== 4. Planteamiento del problema'),
    (r'=== 1\.3\.1 Identificación de la Situación Problemática', '=== 4.1. Identificación de la situación problémica'),
    (r'== 4\.2\. Formulación del problema', '=== 4.2. Formulación del problema'),
    (r'== 1\.4 Objetivos', '== 5. Objetivos'),
    (r'=== 1\.4\.1 Objetivo General', '=== 5.1. Objetivo General'),
    (r'=== 1\.4\.2 Objetivos Específicos', '=== 5.2. Objetivos Específicos y Acciones de la investigación'),
    (r'== 1\.5 Justificación', '== 6. Justificación de la investigación'),
    (r'=== 1\.5\.1 Justificación Técnica', '=== 6.1. Justificación Técnica'),
    (r'=== 1\.5\.2 Justificación Económica', '=== 6.2. Justificación económica'),
    (r'=== 1\.5\.3 Justificación Social', '=== 6.3. Justificación social'),
    (r'== 5\.1 Enfoque de Investigación', '=== 7.1. Enfoque Metodológico'),
    (r'== 7\.2\. Diseño de la investigación', '=== 7.2. Diseño de la investigación (según el enfoque metodológico)'),
    (r'= 8\. Alcances y aportes', '== 8. Alcances y aportes'),
    (r'== Alcances del Proyecto', '=== 8.1. Alcance temático'),
    (r'=== 1\.6\.2 Alcance Tecnológico', '=== Alcance Tecnológico'),
    (r'=== 1\.6\.3 Alcance Geográfico', '=== 8.2. Alcance geográfico'),
    (r'Limitaciones del Proyecto', '8.3. Alcance temporal'),
    (r'Consideraciones Finales de Alcance', '8.4. Alcance Legal')
]

for filepath, new_content in files.items():
    if os.path.exists(filepath):
        if new_content is not None:
            with open(filepath, 'w') as f:
                f.write(new_content)
        else:
            with open(filepath, 'r') as f:
                content = f.read()
            for old, new in replacements:
                content = re.sub(old, new, content)
            with open(filepath, 'w') as f:
                f.write(content)
