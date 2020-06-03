package testPjt;

import org.springframework.context.support.GenericXmlApplicationContext;

public class MainClass {
	
	public static void main(String[] args) {
//		TranspotationWalk transpostationWalk = new TranspotationWalk();
//		transpostationWalk.move();
		
		GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("classpath:aplicationContext.xml");
		
		TranspotationWalk transpotationWalk = ctx.getBean("tWalk", TranspotationWalk.class);
		transpotationWalk.move();
		
		ctx.close();
	}

}
