package com.doker.app.dcv;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class CertPasswordEncoder {

    // MUST be 16 bytes for AES-128
    private static final String key = "00000000";
    private static final String initVector = "00000000";

    public static void main(String[] args) {

        String originalPassword = "sayan";

        // Encrypt
        String encrypted = encrypt(originalPassword);
        System.out.println("Encrypted: " + encrypted);

        // Decrypt
        String decrypted = decrypt(encrypted);
        System.out.println("Decrypted: " + decrypted);
    }

    // 🔐 ENCRYPT
    public static String encrypt(String value) {
        try {
            IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
            SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);

            byte[] encrypted = cipher.doFinal(value.getBytes("UTF-8"));

            return Base64.getEncoder().encodeToString(encrypted);

        } catch (Exception ex) {
            System.err.println("Exception in encrypting: " + ex.getMessage());
            return null;
        }
    }

    // 🔓 DECRYPT
    public static String decrypt(String encrypted) {
        try {
            IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
            SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);

            byte[] original = cipher.doFinal(Base64.getDecoder().decode(encrypted));

            return new String(original, "UTF-8");

        } catch (Exception ex) {
            System.err.println("Exception in decrypting: " + ex.getMessage());
            return null;
        }
    }
}