package net.tp.lc2j.base;

import java.util.Map;


public class BaseAction {

	public static String S() {
		return "";
	}
	
	public static class SplitAction {
		
		public SplitAction() {
			
		}
		
		public SplitAction(String gatewayName) {
			
		}
		
		public void wait_or() {
			
		}
		public void wait_and() {
			
		}
		public void wait_none() {
			
		}
	}

	public static Map map(Object...objects) {
		return null;
	}
	
	public static String go(String name) {
		return "";
	}
	
	public static String jumpTo(int step) {
		return "";
	}

	public static String jumpTo(int step, String route) {
		return "";
	}
	
	public static String asyncRoute(int step, String route) {
		return "";
	}

	public static void end() {
		
	}
	
	public static int x(String str) {
		return 1;
	}

	public static int xpath(String str) {
		return 1;
	}
	
	public void setProcessData(String xpath, Object value) {
		
	}
	
	public void dispatchEvent(BaseEvent event) {
		
	}

}