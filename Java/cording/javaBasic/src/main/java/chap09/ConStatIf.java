package chap09;

public class ConStatIf {
	
	public static void main(String[] args) {
		//조건문 - 조건 결과에 따라 양자 택일 또는 다자 택일을 진행 
		// if문 : 양자택일 || switch문 : 다자택일
		
		//if문
		int num1 = 10;
		int num2 = 20;
		
		//if 조건식
		if(num1 < num2) {
			System.out.println("num1은 num2보다 작다.");
		}
		
		System.out.println();
		
		// if(조건식) else
		if(num1 < num2) {
			System.out.println("num1은 num2보다 작다.");
		} else {
			System.out.println("num1은 num2보다 크거나 같다.");
		}
		
		System.out.println();
		
		// if(조건식) else if(조건식)
		if(num1 < num2) {
			System.out.println("num1은 num2보다 작다.");
		} else if(num1 > num2) {
			System.out.println("num1은 num2보다 크다.");
		} else {
			System.out.println("num1과 num2는 같다.");
		}
		
		//조건식을 true로 줘서 무조건 실행하게 할 수도 있다.
		if(true) {
			System.out.println("==================");
		}
	}

}
