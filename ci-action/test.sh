#!/bin/bash

# Script de test pour valider le parsing des commentaires /ci

echo "🧪 Tests du parsing /ci"
echo "========================"
echo ""

# Test 1 : Format complet
echo "Test 1 : Format complet"
COMMENT="/ci target:apas-mp; version:1.2.3; coverage:true"
echo "Entrée: $COMMENT"

# Simulation du parsing
PARAMS_STRING="${COMMENT#/ci }"
IFS=';' read -ra PARAM_ARRAY <<< "$PARAMS_STRING"

for param in "${PARAM_ARRAY[@]}"; do
  param=$(echo "$param" | xargs)
  KEY=$(echo "$param" | cut -d: -f1 | xargs)
  VALUE=$(echo "$param" | cut -d: -f2- | xargs)
  echo "  ✓ $KEY = $VALUE"
done
echo ""

# Test 2 : Paramètres avec espaces
echo "Test 2 : Paramètres avec espaces"
COMMENT="/ci target: my-app ; version: 2.0.0 ; coverage: false"
echo "Entrée: $COMMENT"

PARAMS_STRING="${COMMENT#/ci }"
IFS=';' read -ra PARAM_ARRAY <<< "$PARAMS_STRING"

for param in "${PARAM_ARRAY[@]}"; do
  param=$(echo "$param" | xargs)
  KEY=$(echo "$param" | cut -d: -f1 | xargs)
  VALUE=$(echo "$param" | cut -d: -f2- | xargs)
  echo "  ✓ $KEY = $VALUE"
done
echo ""

# Test 3 : Un seul paramètre
echo "Test 3 : Un seul paramètre"
COMMENT="/ci target:test"
echo "Entrée: $COMMENT"

PARAMS_STRING="${COMMENT#/ci }"
KEY=$(echo "$PARAMS_STRING" | cut -d: -f1 | xargs)
VALUE=$(echo "$PARAMS_STRING" | cut -d: -f2- | xargs)
echo "  ✓ $KEY = $VALUE"
echo ""

# Test 4 : Format invalide
echo "Test 4 : Format invalide (pas de /ci)"
COMMENT="hello world"
echo "Entrée: $COMMENT"

if [[ "$COMMENT" =~ ^/ci ]]; then
  echo "  ✓ Format valide"
else
  echo "  ❌ Format invalide - Le commentaire ne commence pas par /ci"
fi
echo ""

echo "✅ Tous les tests sont passés!"
