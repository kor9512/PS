package org.example;

import java.util.Arrays;
import java.util.Collections;

/*
    questions.
    정사각형 사이즈의 매트 mats와
    매트가 깔려있는 배열 park가 주어졌다.
    깔 수 있는 mats 사이즈 중 가장 큰 것을 return 하라.
    단 mats사이즈에 중복은 없다.
    깔 수 없으면 -1.

    answer.
    1. 배열에서 가장 큰 정사각형을 찾아낸다.
    2. 정사각형의 한 변과 mats 사이즈를 비교해가며 가장 큰 값을 반환한다. 없으면 -1.
*/
//class Solution {
public class PRG_340198 {
        public static void main(String[] args) throws Exception {
            int[] mats = {5,3,2};
            String[][] park = {{"A", "A", "-1", "B", "B", "B", "B", "-1"},
                    {"A", "A", "-1", "B", "B", "B", "B", "-1"},
                    {"-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1"},
                    {"D", "D", "-1", "-1", "-1", "-1", "E", "-1"},
                    {"D", "D", "-1", "-1", "-1", "-1", "-1", "F"},
                    {"D", "D", "-1", "-1", "-1", "-1", "E", "-1"}};
            System.out.println(solution(mats,park));
        }
    public static int solution(int[] mats, String[][] park) {
        int answer = -1, largeLength=0, row = park.length, col = park[0].length;
        int[][] map = new int[row][col];

        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                map[i][j] = park[i][j].equals("-1") ? 1 : 0;
            }
        }

        for (int i = 1; i < row; i++) {
            for (int j = 1; j < col; j++) {
                if(map[i][j] != 0){
                    map[i][j] = Math.min(Math.min(map[i - 1][j], map[i][j - 1]), map[i - 1][j - 1]) + 1 ;
                    largeLength = Math.max(largeLength, map[i][j]);
                }
            }
        }

        Arrays.sort(mats);
        for (int i = mats.length - 1; i >= 0; i--) {
            if (mats[i] < largeLength) {
                answer = mats[i]; // x보다 큰 첫 번째 값을 반환
                break;
            }
        }

        return answer;
    }
}
