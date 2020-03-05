package javaBasic;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class AssertionsTest {
	
	Person person = new Person("siyoung",1997);
	
	@Test
	void standardAssertions() {
		
		assertEquals(7, 7);
		assertNotEquals(3, 7);
		assertTrue(3 < 7);
		assertEquals("siyoung", person.getName());
		assertTrue(2020 > person.getYear());
		
	}
	
	@Test
	void groupedAssertions() {
		
		assertAll("Person",
				() -> assertEquals("siyoung", person.getName()),
				() -> assertEquals("1997", Integer.toString(person.getYear()))
				);
	}

}
