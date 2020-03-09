package chap12;

public class Grandeur { //클래스 이름 : 일반적으로 첫글자는 대문자
	
	//클래스는 멤버 변수(속성), 메서드(기능), 생성자 등으로 구성된다.
	
	public String color;
	public String gear; 	//멤버 변수(속성)
	public int price;
	
	public Grandeur() {		//생성자 : 클래스와 동일한 이름
		System.out.println("Granduer constructor");
	}
	
	public void run() {		//메서드(기능)
		System.out.println("-- run --");
	}
	
	public void stop() {	//메서드(기능)
		System.out.println("-- stop --");
	}

	public void info() {	//메서드(기능)
		System.out.println("-- info --");
		System.out.println("color : " + color);
		System.out.println("gear : " + gear);
		System.out.println("price : " + price);
	}
}
