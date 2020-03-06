package chap06;

public class MainClass {
	
	public static void main(String[] args) {
		/*
		 * 피연산자 개수에 따라
		 * - 단항 연산자 : 피연산자 + 연산자 => +x, -x, !x
		 * - 이항 연산자 : 피연산자 + 연산자 + 피연산자 => x = y, x < y, x != y
		 * - 삼항 연산자 : 피연산자 + 연산자 + 피연산자 + 연산자 + 피연산자 => (조건식) ? true : false
		 * */
		
		int x = 10;
		int y = 20;
		
		System.out.println("대입연산자");
		System.out.println("x = " + x);
		System.out.println("y = " + y);
		
		x = y;
		
		System.out.println("x = " + x);
		System.out.println("y = " + y);
		
		x = 10; y = 20;
		System.out.println("\n산술연산자");
		System.out.println("덧셈) x + y = " + (x + y));
		System.out.println("뺄셈) x - y = " + (x - y));
		System.out.println("곱셈) x * y = " + (x * y));
		System.out.println("나눗셈) x / y = " + (x / y));
		System.out.println("나머지) x % y = " + (x % y));
		
		System.out.println("\n복합대입연산자");
		x = 10;
		System.out.println("x += 10 : " + (x += 10));
		x = 10;
		System.out.println("x -= 10 : " + (x -= 10));
		x = 10;
		System.out.println("x *= 10 : " + (x *= 10));
		x = 10;
		System.out.println("x /= 10 : " + (x /= 10));
		x = 10;
		System.out.println("x %= 10 : " + (x %= 10));
		
		System.out.println("\n관계연산자");
		x = 10; y = 20;
		System.out.println("x > y : " + (x > y));
		System.out.println("x < y : " + (x < y));
		System.out.println("x >= y : " + (x >= y));
		System.out.println("x <= y : " + (x <= y));
		System.out.println("x == y : " + (x == y));
		System.out.println("x != y : "+ (x != y));
		
		System.out.println("\n증감연산자");
		x = 10;
		System.out.println("++x : " + (++x)); // x = x + 1; 전위연산자 : 연산 후 출력!
		x = 10;
		System.out.println("--x : " + (--x));
		x = 10;
		System.out.println("x++ : " + (x++)); // x = x + 1; 후위연산자 : 출력! 후 연산
		System.out.println("x : " + x);
		x = 10;
		System.out.println("x-- : " + (x--));
		System.out.println("x : " + x);
		
		System.out.println("\n논리연산자");
		boolean b1 = false;
		boolean b2 = true;
		System.out.println("b1 && b2(AND) : " + (b1 && b2));
		System.out.println("b1 || b2(OR) : " + (b1 || b2));
		System.out.println("!b1(부정) : " + !b1);
		System.out.println("!b2(부정) : " + !b2);
		
		System.out.println("\n조건삼항연산자");
		x = 10; y = 20;
		int result = 0;
		result = (x > y) ? 100 : 200;
		System.out.println("x > y라는 조건에 대한 result : " + result);
		
		result = (x < y) ? 100 : 200;
		System.out.println("x < y라는 조건에 대한 result : " + result);
		
		System.out.println("\n비트연산자"); //데이터를 비트(bit)단위로 환산하여 연산 수행. 다른 연산자보다 연산 속도 향상. 자주 사용X
		x = 2; y = 3;
		System.out.println("x & y : " + (x & y)); // AND 연산 : x와 y가 모두 1이면 1
		System.out.println("x | y : " + (x | y)); // OR 연산 : x와 y 중 하나라도 1이면 1
		System.out.println("x ^ y : " + (x ^ y)); // XOR 연산 : x와 y가 같지 않으면 1

	}
}
