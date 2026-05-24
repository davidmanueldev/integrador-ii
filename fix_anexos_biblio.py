import re

def fix_file(path, content):
    with open(path, 'w') as f:
        f.write(content)

fix_file('anexos/anexos.typ', '= Anexos\n\n#v(2em)\n')
fix_file('referencias/bibliografia.typ', '= Bibliografía (Formato APA)\n\n#bibliography("referencias.bib", title: none)\n')

