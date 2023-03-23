package com.bsk.test;

import org.junit.Test;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * @author scmie
 */
public class Base64Test {

    @Test
    public void test01() {
        String str = "000000";

        try {
            String result1 = encryptBASE64(str.getBytes());
            System.out.println("result1=====加密数据==========" + result1);

            byte result2[] = decryptBASE64(result1);
            String str2 = new String(result2);
            System.out.println("str2========解密数据========" + str2);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String encryptBASE64(byte[] key) throws Exception {
        return (new BASE64Encoder()).encodeBuffer(key);
    }

    public static byte[] decryptBASE64(String key) throws Exception {
        return (new BASE64Decoder()).decodeBuffer(key);
    }


}
