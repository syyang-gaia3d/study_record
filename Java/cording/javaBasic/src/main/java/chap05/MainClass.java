package chap05;

public class MainClass {
	//5강. 특수 문자와 서식 문자
	public static void main(String[] args) {
		
		//특수문자
		System.out.println("Good Morning~");
		//tab => 반복 가능(\t\t)
		System.out.println("Good\tMorning~");
		//개행 => 반복 가능(\n\n)
		System.out.println("Good\nMorning~");
		//작은 따옴표
		System.out.println("Good \'Morning~\'");
		//큰 따옴표
		System.out.println("Good \"Morning~\"");
		
		//주석~ 컴파일 무시됨~ -> 코딩 내용 설명이나 코멘드를 남기는 용도
		
		/*
		 * 여러 줄 생략하고 싶을 때~
		 * 이렇게 넣으면 된다~
		 * 
		 */
		
		//서식문자 -> printf()사용. 자동 개행(엔터기능) 없음.. 따라서 \n을 붙여줘야 함
		System.out.println("오늘의 기온은 10도 입니다."); //println은 자동 개행
		System.out.printf("오늘의 기온은 %d도 입니다.\n", 10); //printf -> f는 format(형식)을 뜻함.
		
		int num1 = 20;
		System.out.println("오늘의 기온은 " + num1 + "도 입니다.");
		System.out.printf("오늘의 기온은 %d도 입니다.\n", num1);
		
		System.out.printf("홍길동's Info : %d학년 %d반 %d번 \n", 6, 2, 10);
		
		//정수
		int num2 = 30;
		System.out.printf("num2(10진수): %d\n", num2);
		System.out.printf("num2(8진수) : %o\n", num2);
		System.out.printf("num2(16진수) : %x\n", num2);
		
		//문자
		System.out.printf("소문자 \'%c\'의 대문자는 \'%c\'입니다.\n", 'a', 'A');
		
		//문자열
		System.out.printf("\'%s\'을 대문자로 바꾸면 \'%s\'입니다.\n", "java", "JAVA");
		
		//실수
		float f = 1.24f;
		System.out.printf("f = %f\n", f);
		
		double d = 1.23456d;
		System.out.printf("d = %f\n", d);
		
		//서식 문자를 이용한 출력 문자의 정렬 및 소수점 제한
		System.out.printf("%d\n", 123);
		System.out.printf("%d\n", 1234);
		System.out.printf("%d\n", 12345);
		
		System.out.println();
		
		System.out.printf("%5d\n", 123);
		System.out.printf("%5d\n", 1234);
		System.out.printf("%5d\n", 12345);
		
		System.out.println();
		
		//소수점 제한
		System.out.printf("%f\n", 1.23);
		System.out.printf("%.0f\n", 1.23);
		System.out.printf("%.1f\n", 1.23);
		System.out.printf("%.2f\n", 1.23);
		System.out.printf("%.3f\n", 1.23);
		
	}
}
