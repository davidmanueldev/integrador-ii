import os
import re

def replace_header(filepath, old_pattern, new_header):
    if not os.path.exists(filepath):
        print(f"No existe {filepath}")
        return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Very basic replacement or just prepend if not found
    # Actually, it's easier to just rewrite the file replacing the first occurrences of = or ==
    # Or just use regex to replace the first level 1 heading
    content = re.sub(r'^= .*$', f'= {new_header}', content, count=1, flags=re.MULTILINE)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

# 1. Resumen ejecutivo
with open('capitulo1/resumen.typ', 'w', encoding='utf-8') as f:
    f.write('= 1. Resumen ejecutivo\n\n[El presente proyecto propone el desarrollo de un Sistema Integral de Gestión para el Restaurante Bambú, integrando Inteligencia Artificial...]\n')

# 2. Antecedentes
replace_header('capitulo1/antecedentes.typ', '', '2. Antecedentes')

# 3. Descripción del objeto de estudio
with open('capitulo1/descripcion_objeto.typ', 'w', encoding='utf-8') as f:
    f.write('= 3. Descripción del objeto de estudio\n\n[El objeto de estudio se centra en los procesos de gestión operativa, atención al cliente y administración de inventarios del Restaurante Bambú...]\n')

# 4. Planteamiento del problema
replace_header('capitulo1/planteamiento.typ', '', '4. Planteamiento del problema')

# 5. Objetivos
replace_header('capitulo1/objetivos.typ', '', '5. Objetivos')

# 6. Justificación
replace_header('capitulo1/justificacion.typ', '', '6. Justificación de la investigación')

# 7. Metodologia (Mover de capitulo5)
if os.path.exists('capitulo5/metodologia.typ'):
    os.rename('capitulo5/metodologia.typ', 'capitulo1/metodologia.typ')
replace_header('capitulo1/metodologia.typ', '', '7. Metodología y Técnicas de Investigación')

# 8. Alcances
replace_header('capitulo1/alcances.typ', '', '8. Alcances y aportes')

