package org.shoukaiseki.webclient.login;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;


import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;


public class JsEncryptUtil {


    public static String publicKey = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKEnFfgtVH5jR51goNfJ/P+dMVG4vZfmPU+RJ/xRfSfnwANHAmYHTF7DRlPekQIyQEdoaaVzw2rjErA59tilvhMCAwEAAQ==";
    public static String privateKey = "MIIBVgIBADANBgkqhkiG9w0BAQEFAASCAUAwggE8AgEAAkEAoScV+C1UfmNHnWCg18n8/50xUbi9l+Y9T5En/FF9J+fAA0cCZgdMXsNGU96RAjJAR2hppXPDauMSsDn22KW+EwIDAQABAkALFcExHQ0e1H1smeT2cvJwMsPdtzNza2b0Pivd800EnZRfQc7kWab8PJDWBJOt1xFILX1Str/CstVdDak6MquhAiEA1q/B39Dj8x6mRD1mTuuWF6J2Jgm7CxDYJomYSFH2VAUCIQDAKg38TGsqk7sLez6xQWK9PpIX+816QdE470MOnoq9NwIhAMB6AULt4IEHOKAzwDb/hqiX8n919+ka5//dGte0DDoVAiEAwA2H2r8ZX/0ztD7holAh+dc+NaAgdW6wRwHBeCv1pzMCIQDDcDJp7r1XTdA7Gwv1Cn82k99l/PAMamF37I4ZFnrTDA==";

        public static PublicKey getPublicKey(String base64PublicKey){
            PublicKey publicKey = null;
            try{
//                X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(base64PublicKey.getBytes()));
                X509EncodedKeySpec keySpec = new X509EncodedKeySpec(Base64.decode(base64PublicKey));
                KeyFactory keyFactory = KeyFactory.getInstance("RSA");
                publicKey = keyFactory.generatePublic(keySpec);
                return publicKey;
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            } catch (InvalidKeySpecException e) {
                e.printStackTrace();
            }
            return publicKey;
        }

        public static PrivateKey getPrivateKey(String base64PrivateKey){
            PrivateKey privateKey = null;
//            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(base64PrivateKey.getBytes()));
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(Base64.decode(base64PrivateKey));
            KeyFactory keyFactory = null;
            try {
                keyFactory = KeyFactory.getInstance("RSA");
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            try {
                privateKey = keyFactory.generatePrivate(keySpec);
            } catch (InvalidKeySpecException e) {
                e.printStackTrace();
            }
            return privateKey;
        }

        public static byte[] encrypt(String data, String publicKey) throws BadPaddingException, IllegalBlockSizeException, InvalidKeyException, NoSuchPaddingException, NoSuchAlgorithmException {
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.ENCRYPT_MODE, getPublicKey(publicKey));
            return cipher.doFinal(data.getBytes());
        }

        public static String decrypt(byte[] data, PrivateKey privateKey) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            return new String(cipher.doFinal(data));
        }

        public static String decrypt(String data, String base64PrivateKey) throws IllegalBlockSizeException, InvalidKeyException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException {
            return decrypt(Base64.decode(data), getPrivateKey(base64PrivateKey));
        }

        public static void main(String[] args) throws IllegalBlockSizeException, InvalidKeyException, NoSuchPaddingException, BadPaddingException {
            try {
                String encryptedString = Base64.encode(encrypt("Dhiraj is the author", publicKey));
                System.out.println(encryptedString);
                String decryptedString = JsEncryptUtil.decrypt(encryptedString, privateKey);
                System.out.println(decryptedString);
			//这个我没测试过的,你们自己测试,有问题百度 RSA加密
                String s = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCd+fHiQNWknm1ZcjnTK20XKRkUtY7B1h5DH+hAzlVSlMpZfVkDjHAc7rYDcNEdLz2LmA9+UD2BZ4lgckpzfRw5b2PHVlbpDeWMxKx0El10vJx0jP3LH71mKEYsjDuV3pryT/sRaylS3BY30sAcmvBOv/RyhuUAh247XChcNgOTywIDAQAB";
                System.out.println(JsEncryptUtil.decrypt(s, privateKey));
            } catch (NoSuchAlgorithmException e) {
                System.err.println(e.getMessage());
            }

        }
}
