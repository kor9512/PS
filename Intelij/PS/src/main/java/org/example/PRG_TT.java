package org.example;

/*
*/
//class Solution {
public class PRG_TT {
    public static void main(String[] args) throws Exception {
        System.out.println(solution());
    }

    public static int solution() {
        int key = 664;
        while (true) {
            key++;
            if (String.valueOf(++key).contains("666")) {
                break;
            }
        }
        return 0;
    }
}
