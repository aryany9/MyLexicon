import re

def insert_l10n(file_path, methods):
    with open(file_path, 'r') as f:
        content = f.read()
    
    for method in methods:
        pattern = re.compile(re.escape(method) + r'\s*\{')
        content = pattern.sub(method + ' {\n    final l10n = AppLocalizations.of(context)!;', content)
        
    with open(file_path, 'w') as f:
        f.write(content)

# For CollectionsScreen, it's missing in _buildEmptyState, _buildEmptyCollectionState, and maybe _buildCollectionDetails
# Oh, earlier I ran sed that replaced `Widget _buildEmptyState(BuildContext context) {` with `... { final l10n = AppLocalizations.of(context)!;`
# Let's see if that worked or if they had different signatures.
