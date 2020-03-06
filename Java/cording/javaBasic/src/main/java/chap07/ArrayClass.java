package chap07;

import java.util.Scanner;

public class ArrayClass {
	
	public static void main(String[] args) {

		//배열 : 인덱스를 이용해서 자료형이 같은 데이터를 관리
		//선언과 초기화를 거쳐 사용
		int[] arr1 = new int[5];
		arr1[0] = 100;
		arr1[1] = 200;
		arr1[2] = 300;
		arr1[3] = 400;
		arr1[4] = 500;
		
		System.out.println("arr1[0] = " + arr1[0]);
		System.out.println("arr1[1] = " + arr1[1]);
		System.out.println("arr1[2] = " + arr1[2]);
		System.out.println("arr1[3] = " + arr1[3]);
		System.out.println("arr1[4] = " + arr1[4]);
		
		//선언과 초기화를 동시에
		int[] arr2 = {10, 20, 30, 40, 50}; //배열의 크기는 한번 지정하면 고정된다. 
		System.out.println("arr2[0] = " + arr2[0]);
		System.out.println("arr2[1] = " + arr2[1]);
		System.out.println("arr2[2] = " + arr2[2]);
		System.out.println("arr2[3] = " + arr2[3]);
		System.out.println("arr2[4] = " + arr2[4]);
		
		//크기 이상의 인덱스를 참조하면 에러 발생!!
		
		//배열은 주로 많은 데이터를 쉽게(효율적으로) 관리하기 위해 사용
		
	}
}
