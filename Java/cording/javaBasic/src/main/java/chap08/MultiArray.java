package chap08;

import java.util.Arrays;

public class MultiArray {
	
	/*
	 * 다차원 배열
	 * - 이론상 배열 안에 배열을 계속 만들어 2차, 3차 ...n차 배열을 할 수 있음
	 * - 로직이 복잡해지고 메모리가 너무 많이 사용되어 효율성이 저하됨
	 * - 따라서, 3차원 이상은 거의 사용하지 않음
	 */
	
	public static void main(String[] args) {
		
		int[][] arrMul = new int[3][2]; //[행][열] 즉, 예시는 3행 2열의 2차원 배열
		arrMul[0][0] = 10;
		arrMul[0][1] = 100;
		arrMul[1][0] = 20;
		arrMul[1][1] = 200;
		arrMul[2][0] = 30;
		arrMul[2][1] = 300;
		
		System.out.println("arrMul[0] : " + Arrays.toString(arrMul[0]));
		System.out.println("arrMul[1] : " + Arrays.toString(arrMul[1]));
		System.out.println("arrMul[2] : " + Arrays.toString(arrMul[2]));
	}

}
