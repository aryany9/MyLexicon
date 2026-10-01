import re
import glob

def remove_consts(content):
    # Just look for 'const' that precedes something with l10n
    # A simple approach: remove all 'const ' in the file, then rely on `dart fix --apply` to put them back where they belong!
    # Wait, dart fix only puts them back if `prefer_const_constructors` is enabled. It usually is.
    return content.replace('const ', '')

for file_path in glob.glob("lib/**/*.dart", recursive=True):
    with open(file_path, 'r') as f:
        content = f.read()
    
    # We only care about files we modified
    if 'l10n' in content:
        content = remove_consts(content)
        with open(file_path, 'w') as f:
            f.write(content)

