package javaBasic;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.*;

@DisplayName("라이프사이클 설명을 위한 클래스")
class JunitLifecycle {

	@BeforeAll
	static void initializeBeforeAll() {
		System.out.println("initialize BeforeAll...");
	}
	
	@BeforeEach
	void initializeBeforeEach() {
		System.out.println("initialize BeforeEach....");
	}
	
	@Test
	@DisplayName("@Test를 사용하는 첫번째 테스트")
	void firstTest() {
		System.out.println("first test.....");
		assertTrue(true);
	}
	
	@Test
	@DisplayName("@Test를 사용하는 두번째 테스트")
	void secondTest() {
		assertTrue(true);
		System.out.println("second test.....");
		assertNotEquals(1,2,"");
	}
	
	@Test
	@Disabled
	@DisplayName("@Disabled를 사용하는 스킵 테스트")
	void disabledTest() {
		System.out.println("disabled....");
	}
	
	@AfterEach
	void afterEach() {
		System.out.println("afterEach...");
	}
	
	@AfterAll
	static void afterAll() {
		System.out.println("afterAll...");
	}

}
