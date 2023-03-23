package com.bsk.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * @author scmie
 */
public class Base64Util {


    /**
     * Base64加密
     * @param key
     * @return
     * @throws Exception
     */
    public static String encryptBASE64(byte[] key) throws Exception {
        return (new BASE64Encoder()).encodeBuffer(key);
    }


    /**
     * Base64解密
     * @param key
     * @return
     * @throws Exception
     */
    public static byte[] decryptBASE64(String key) throws Exception {
        return (new BASE64Decoder()).decodeBuffer(key);
    }
}
