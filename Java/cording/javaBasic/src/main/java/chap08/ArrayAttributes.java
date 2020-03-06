package chap08;

import java.util.Arrays;

public class ArrayAttributes {
	
	public static void main(String[] args) {
		/*
		 * 배열의 기본 속성
		 * - 기본 자료형 데이터를 담고 있는 변수와 달리, 배열 변수는 배열 데이터의 주소를 담고 있다. -> 객체 자료형
		 */
		
		//배열 기본속성
		int[] arrAtt1 = {10, 20, 30, 40, 50, 60};
		int[] arrAtt2 = null;
		int[] arrAtt3 = null;
		
		//배열 길이
		System.out.println("arrAtt1.length : " + arrAtt1.length);
		
		//배열 요소 출력
		System.out.println("arrAtt1 : " + Arrays.toString(arrAtt1));
		
		//배열 요소 복사
		//같은 배열 주소를 가리키는 것XXXX -> 원본 배열의 "값"을 복사하여 새롭게 메모리에 배열을 "생성"! arrAtt1 != arrAtt3 (같은 객체 아님!)
		arrAtt3 = Arrays.copyOf(arrAtt1, arrAtt1.length); 
		System.out.println("arrAtt3 : " + Arrays.toString(arrAtt3));
		
		//배열 레퍼런스
		arrAtt2 = arrAtt1; //이렇게 하면 같은 배열 주소를 가리킴
		System.out.println("arrAtt1 : " + arrAtt1);
		System.out.println("arrAtt2 : " + arrAtt2);
		System.out.println("arrAtt3 : " + arrAtt3);
	}

}
