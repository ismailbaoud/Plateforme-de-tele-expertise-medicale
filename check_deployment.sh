#!/bin/bash

echo "🧪 Test de vérification post-déploiement"
echo "========================================"
echo ""

echo "📊 Vérification de la base de données..."
mysql -u ismail hospital -e "SHOW TABLES;" 2>/dev/null

echo ""
echo "👥 Nombre d'utilisateurs en base :"
mysql -u ismail hospital -e "SELECT COUNT(*) as total FROM Person;" 2>/dev/null

echo ""
echo "📋 Liste des utilisateurs (si disponibles) :"
mysql -u ismail hospital -e "SELECT first_name, last_name, email, role FROM Person ORDER BY role, first_name LIMIT 5;" 2>/dev/null

echo ""
echo "✅ Si vous voyez des utilisateurs ci-dessus, la connexion devrait fonctionner."
echo "❌ Si aucun utilisateur n'apparaît, le DataSeeder ne s'est pas exécuté."
echo ""
echo "📝 Pour vous connecter :"
echo "   Email: nora.benali@hospital.com"
echo "   Mot de passe: 1234"

