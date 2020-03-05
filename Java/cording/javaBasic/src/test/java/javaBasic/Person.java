package javaBasic;

public class Person {
	

	public class Gender {
		
		String name;
		int year;
		String gender;
		
		final static String F = "female";
		
		public Gender(String name, int year) {
			this.name = name;
			this.year = year;
			this.gender = F;
		}

	}

	String name;
	int year;
	
	Person(String name, int year) {
		this.name = name;
		this.year = year;
	}
	
	public String getName() {
		return name;
	}
	
	public int getYear() {
		return year;
	}

	public static Gender getGender() {
		Gender gender = null;
		// TODO Auto-generated method stub
		return gender;
	}
}
