import re

def fix_file(path, replacements):
    try:
        with open(path, 'r') as f:
            content = f.read()
        for old, new in replacements:
            content = re.sub(old, new, content)
        with open(path, 'w') as f:
            f.write(content)
    except FileNotFoundError:
        pass

fix_file('capitulo1/alcances.typ', [
    (r'== 8\. Alcances y aportes', '== 8. Alcances y aportes'),
    (r'=== 8\.1\. Alcance temático', '=== 8.1. Alcance temático'),
    (r'=== 8\.2\. Alcance geográfico', '=== 8.2. Alcance geográfico'),
    (r'== 8\.3\. Alcance temporal', '=== 8.3. Alcance temporal'),
    (r'== 8\.4\. Alcance Legal', '=== 8.4. Alcance Legal (Sólo si corresponde)'),
    (r'== Limitaciones del Proyecto', '=== 8.3. Alcance temporal\n\nEl proyecto se desarrollará a lo largo de los hitos académicos establecidos por la universidad, culminando con la presentación y defensa final. El alcance temporal considera las fases de planificación, diseño, desarrollo, pruebas e implementación dentro del periodo lectivo correspondiente.\n'),
    (r'== Consideraciones Finales de Alcance', '=== 8.4. Alcance Legal\n\nEl sistema considerará las regulaciones vigentes en Bolivia relacionadas con el comercio electrónico y el manejo de datos de usuarios (Ley de Telecomunicaciones y políticas de privacidad básicas). Además, la integración con pasarelas de pago se apegará a las normativas de la Autoridad de Supervisión del Sistema Financiero (ASFI).\n')
])

