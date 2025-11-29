# Parse /ci Comment Action

Une action composite GitHub qui parse les commentaires `/ci` et extrait les paramètres.

## 📝 Description

Cette action composite :
- ✅ Détecte les commentaires commençant par `/ci`
- ✅ Parse les paramètres séparés par `;`
- ✅ Extrait les paires `clé:valeur`
- ✅ Exporte les paramètres comme outputs GitHub
- ✅ Gère les erreurs gracieusement
- ✅ Fournit des messages informatifs dans les logs

## 🚀 Utilisation

### Configuration du Workflow

```yaml
name: CI Comment Parser

on:
  issue_comment:
    types: [created, edited]

jobs:
  parse_ci_comment:
    if: startsWith(github.event.comment.body, '/ci')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - id: parse
        uses: ./ci-action
      
      - name: Use parameters
        run: |
          echo "Target: ${{ steps.parse.outputs.target }}"
          echo "Version: ${{ steps.parse.outputs.version }}"
          echo "Coverage: ${{ steps.parse.outputs.coverage }}"
```

### Format des Commentaires

Format accepté :
```
/ci target:apas-mp; version:1.2.3; coverage:true
```

Exemples valides :
```
/ci target:my-target; version:2.0.0; coverage:false
/ci target:test; version:1.0.0
/ci coverage:true
```

## 📤 Outputs

L'action exporte les paramètres suivants :

| Output | Description |
|--------|-------------|
| `target` | Valeur du paramètre `target` |
| `version` | Valeur du paramètre `version` |
| `coverage` | Valeur du paramètre `coverage` |
| `parameters` | Tous les paramètres en JSON |

## 🔍 Exemple de Sortie

Quand tu commentes :
```
/ci target:apas-mp; version:1.2.3; coverage:true
```

Les logs affichent :
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 CI Command Parameters Parsed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 Target:   apas-mp
📦 Version:  1.2.3
📈 Coverage: true
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 All parameters:
{"target":"apas-mp","version":"1.2.3","coverage":"true"}
```

## ⚠️ Gestion des Erreurs

L'action gère les erreurs suivantes :

- ❌ Commentaire ne commençant pas par `/ci`
- ❌ Aucun paramètre après `/ci`
- ❌ Format invalide (paramètre sans `:`)
- ❌ Paramètres incomplets (clé ou valeur manquante)
- ❌ Aucun paramètre valide trouvé

En cas d'erreur, un commentaire sera posté automatiquement dans l'issue.

## 🛠️ Technologie

- **Framework** : `actions/github-script@v7`
- **Langage** : JavaScript
- **Contexte** : GitHub Actions

## 📄 Licence

MIT
