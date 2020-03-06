package chap07;

import java.util.Scanner;

public class ScoreManagement {
	
	public static void main(String[] args) {
		
		System.out.println("배열을 이용한 학사관리\n");
		
		String[] name = {"박찬호", "이승엽", "박병호", "이병규", "류현진"};
		int[] score = new int[5];
		
		Scanner scanner = new Scanner(System.in);
		System.out.printf("%s의 점수를 입력하시오. : ", name[0]);
		score[0] = scanner.nextInt();
		
		System.out.printf("%s의 점수를 입력하시오. : ", name[1]);
		score[1] = scanner.nextInt();
		
		System.out.printf("%s의 점수를 입력하시오. : ", name[2]);
		score[2] = scanner.nextInt();
		
		System.out.printf("%s의 점수를 입력하시오. : ", name[3]);
		score[3] = scanner.nextInt();
		
		System.out.printf("%s의 점수를 입력하시오. : ", name[4]);
		score[4] = scanner.nextInt();
		
		System.out.printf("%s의 점수 : \t%.2f\n", name[0], (double)score[0]);
		System.out.printf("%s의 점수 : \t%.2f\n", name[1], (double)score[1]);
		System.out.printf("%s의 점수 : \t%.2f\n", name[2], (double)score[2]);
		System.out.printf("%s의 점수 : \t%.2f\n", name[3], (double)score[3]);
		System.out.printf("%s의 점수 : \t%.2f\n", name[4], (double)score[4]);
		
		double ave = (double)(score[0] + score[1] + score[2] + score[3] + score[4]) / 5;
		System.out.printf("-------------------------\n평  점 : \t%.2f", ave);
		
		scanner.close();
		
	}

}
