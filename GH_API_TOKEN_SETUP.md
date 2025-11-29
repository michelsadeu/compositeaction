# 🔐 Configuration du Secret GH_API_TOKEN

## ⚠️ Action requise

Tu dois créer un secret nommé `GH_API_TOKEN` dans les paramètres de ton repository GitHub.

## 📋 Étapes pour configurer le secret

### 1. Sur GitHub, va à Settings > Secrets and variables > Actions
```
https://github.com/Michel-SG/compositeaction/settings/secrets/actions
```

### 2. Clique sur "New repository secret"

### 3. Configure le secret
- **Name** : `GH_API_TOKEN`
- **Value** : Colle ton token GitHub (Personal Access Token ou Fine-grained token)

### 4. Clique sur "Add secret"

## 🔑 Générer un Personal Access Token

### Option 1 : Personal Access Token (Classique)
1. Va à https://github.com/settings/tokens
2. Clique sur "Generate new token" > "Generate new token (classic)"
3. Donne un nom au token (ex: "CI Parser Token")
4. Sélectionne les scopes :
   - `repo` (accès complet aux repos)
   - `write:packages` (optionnel)
5. Clique sur "Generate token"
6. Copie le token et ajoute-le comme secret `GH_API_TOKEN`

### Option 2 : Fine-grained Personal Access Token (Recommandé)
1. Va à https://github.com/settings/tokens?type=beta
2. Clique sur "Generate new token"
3. Configure :
   - **Name** : "CI Parser Token"
   - **Expiration** : 30 days / 90 days / Custom
   - **Repository access** : "Only select repositories" (sélectionne compositeaction)
4. **Permissions** :
   - Issues: Read and write
   - Pull requests: Read and write
5. Clique sur "Generate token"
6. Copie et ajoute-le comme secret `GH_API_TOKEN`

## ✅ Vérification

Après avoir configuré le secret, le workflow utilisera `${{ secrets.GH_API_TOKEN }}` au lieu de `${{ secrets.GITHUB_TOKEN }}`.

## 🎯 Avantages

- ✅ Token personnalisé avec permissions limitées
- ✅ Plus sécurisé que le token par défaut
- ✅ Peut être révoqué indépendamment
- ✅ Meilleur contrôle des permissions

## 📝 Rappel

Le token est utilisé dans les trois endroits :
1. ✅ Action composite (`ci-action`)
2. ✅ Post success comment
3. ✅ Post failure comment
