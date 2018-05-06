package mybean.db;

public class Util {
	public static String nullChk(String str){	//null일 경우 공백으로 반환
		if(str == null){
			return "";
		}
		else{
			return str;
		}
	}
}