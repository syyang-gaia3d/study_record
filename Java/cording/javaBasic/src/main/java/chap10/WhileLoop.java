package chap10;

import java.util.Scanner;

public class WhileLoop {
	
	public static void main(String[] args) {
		//while문
		System.out.println("INPUT NUMBER : ");
		Scanner scanner = new Scanner(System.in);
		int num = scanner.nextInt();
		int i = 1;
		while (i < 10) {
			System.out.printf("%d * %d = %d\n", num, i, (num*i));
			i++;
		}
		
		//do ~ while문
		do {
			System.out.println("while문의 조건에 상관없이 무조건 1번 실행합니다.");
		} while(false);
		
		i = 10;
		do {
			System.out.println("while문 실행 전 무조건 실행됩니다.");
			i++;
		} while(i < 13);
		
	}
}
