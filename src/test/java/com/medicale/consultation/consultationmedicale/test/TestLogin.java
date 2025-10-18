package com.medicale.consultation.consultationmedicale.test;

import com.medicale.consultation.consultationmedicale.utils.PasswordUtils;

public class TestLogin {
    public static void main(String[] args) {
        // Le hash stocké en base pour tous les utilisateurs
        String storedHash = "$2a$12$GXWeoiXrp5w02qodZ.7lUeY8oOkFw0nuBlocBdUK6fDkWnMMpfvkm";
        
        // Le mot de passe que l'utilisateur entre
        String userPassword = "1234";
        
        // Test de vérification
        boolean isValid = PasswordUtils.checkPassword(userPassword, storedHash);
        
        System.out.println("==============================================");
        System.out.println("TEST DE VÉRIFICATION DU LOGIN");
        System.out.println("==============================================");
        System.out.println("Mot de passe saisi : " + userPassword);
        System.out.println("Hash en base       : " + storedHash.substring(0, 30) + "...");
        System.out.println("Résultat           : " + (isValid ? "✅ VALIDE" : "❌ INVALIDE"));
        System.out.println("==============================================");
        
        if (isValid) {
            System.out.println("\n✅ LE LOGIN DEVRAIT FONCTIONNER !");
            System.out.println("\nConnectez-vous avec :");
            System.out.println("  Email    : nora.benali@hospital.com");
            System.out.println("  Password : 1234");
        } else {
            System.out.println("\n❌ ERREUR : Le mot de passe ne correspond pas !");
        }
    }
}

