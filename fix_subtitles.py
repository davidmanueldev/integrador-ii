import re
import os

def fix_subtitles(filepath, substitutions):
    if not os.path.exists(filepath): return
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for old, new in substitutions:
        content = re.sub(r'^==\s+.*?' + re.escape(old) + r'.*$', f'== {new}', content, flags=re.MULTILINE|re.IGNORECASE)
        
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

fix_subtitles('capitulo1/planteamiento.typ', [
    ('Situación Problémica', '4.1. Identificación de la situación problémica'),
    ('Formulación del Problema', '4.2. Formulación del problema')
])

fix_subtitles('capitulo1/objetivos.typ', [
    ('Objetivo General', '5.1. Objetivo General'),
    ('Objetivos Específicos', '5.2. Objetivos Específicos y Acciones de la investigación')
])

fix_subtitles('capitulo1/justificacion.typ', [
    ('Justificación Técnica', '6.1. Justificación Técnica'),
    ('Justificación Económica', '6.2. Justificación económica'),
    ('Justificación Social', '6.3. Justificación social'),
    ('Justificación Ambiental', '6.4. Justificación Ambiental')
])

fix_subtitles('capitulo1/metodologia.typ', [
    ('Enfoque Metodológico', '7.1. Enfoque Metodológico'),
    ('Diseño de la investigación', '7.2. Diseño de la investigación')
])

fix_subtitles('capitulo1/alcances.typ', [
    ('Alcance Temático', '8.1. Alcance temático'),
    ('Alcance Geográfico', '8.2. Alcance geográfico'),
    ('Alcance Temporal', '8.3. Alcance temporal'),
    ('Alcance Legal', '8.4. Alcance Legal')
])

