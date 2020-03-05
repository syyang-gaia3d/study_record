package chap04;

public class CastSample {
	public static void main(String[] args) {
		
		//자동(묵시적) 형 변환:
		//작은 공간의 메모리에서 큰 공간의 메모리로 이동
		byte by = 10;
		int in = by;
		System.out.println("in = " + in);
		
		//명시적 형 변환:
		//큰 공간의 메모리에서 작은 공간의 메모리로 이동
		int iVar = 100;
		byte bVar = (byte)iVar;
		System.out.println("bVar = " + bVar);
		
		iVar = 123456;
		bVar = (byte)iVar;
		System.out.println("bVar = " + bVar);
		//명시적 형 변환은 데이터가 누실될 수 있음
	}
}
