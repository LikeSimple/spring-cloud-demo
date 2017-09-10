package com.newtouch.cloud.serviceuser.utility;

import java.util.UUID;

public class ShortUUIDGenerator {

    private static final char[] charMap;

    static {
        charMap = new char[64];
        for (int i = 0; i < 10; i++) {
            charMap[i] = (char) ('0' + i);
        }
        for (int i = 10; i < 36; i++) {
            charMap[i] = (char) ('a' + i - 10);
        }
        for (int i = 36; i < 62; i++) {
            charMap[i] = (char) ('A' + i - 36);
        }
        charMap[62] = '_';
        charMap[63] = '-';
    }

    private static String hexTo64(String hex) {
        StringBuilder r = new StringBuilder();
        int index;
        int[] buff = new int[3];
        int l = hex.length();
        for (int i = 0; i < l; i++) {
            index = i % 3;
            buff[index] = Integer.parseInt("" + hex.charAt(i), 16);
            if (index == 2) {
                r.append(charMap[buff[0] << 2 | buff[1] >>> 2]);
                r.append(charMap[(buff[1] & 3) << 4 | buff[2]]);
            }
        }
        return r.toString();
    }

    public static String generate() {
        String uuid = "0" + UUID.randomUUID().toString().replace("-", "").toUpperCase();
        return hexTo64(uuid);
    }

    public static void main(String[] args) {

        System.out.println(ShortUUIDGenerator.generate());

    }
}
