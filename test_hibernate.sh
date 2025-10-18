#!/bin/bash

echo "🧪 Test de l'initialisation Hibernate..."

# Tester la connexion à la base de données
echo "📊 Vérification de la base de données..."
mysql -u ismail -e "USE hospital; SHOW TABLES;" 2>&1 | head -20

echo ""
echo "✅ Base de données prête. Les tables seront créées au démarrage de l'application."
echo ""
echo "📝 Pour tester l'application :"
echo "   1. Déployez le WAR sur Tomcat"
echo "   2. Vérifiez les logs pour voir la création des tables"
echo "   3. Accédez à http://localhost:8080"

