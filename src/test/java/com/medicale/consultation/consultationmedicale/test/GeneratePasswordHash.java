package com.medicale.consultation.consultationmedicale.test;

import com.medicale.consultation.consultationmedicale.utils.PasswordUtils;

public class GeneratePasswordHash {
    public static void main(String[] args) {
        String password = "1234";
        String hash = PasswordUtils.hashPassword(password);
        System.out.println("Password: " + password);
        System.out.println("BCrypt Hash: " + hash);
        System.out.println("\nTest verification:");
        System.out.println("Matches: " + PasswordUtils.checkPassword(password, hash));
    }
}

