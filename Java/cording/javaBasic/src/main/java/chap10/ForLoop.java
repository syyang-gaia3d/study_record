package chap10;

import java.util.Scanner;

public class ForLoop {
	
	public static void main(String[] args) {
		//반복문 : 프로그램 진행을 특정 조건에 따라 반복적으로 시행
		
		//for문
		System.out.println("INPUT NUMBER : ");
		Scanner scanner = new Scanner(System.in);
		int inputNum = scanner.nextInt();
		
		for(int i = 1; i <10; i++) {
			System.out.printf("%d * %d = %d\n", inputNum, i, (inputNum * i));
		}
	}
}
