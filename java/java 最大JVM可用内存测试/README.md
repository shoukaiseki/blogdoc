# java 最大JVM可用内存测试

编译之后运行方式
```Shell
java -Xms3448M -Xmx3448M TestJdkCG
```
以这种方式修改内存配置参数运行，调节过程中[增量次数越多]，运行时所能够正常使用的内存就越大

切记，不可过分调到系统剩余内存之外，小心卡死

```Java
import java.util.HashMap;
import java.util.Random;  

public class TestJdkCG {

	public TestJdkCG(){
		HashMap<Long, String> map=new HashMap<Long, String>();
		StringBuffer sb=new StringBuffer();
		long i=0L;
		while(true){
			//每次增量1MB
			map.put(i,randomString(1024*1024));
//			sb.append(randomString(1024*1024));
			++i;
			
			printMemoryMSG(i,sb);
			
//			try {
//				Thread.sleep(50);
//			} catch (InterruptedException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
		}
	}

	public static void main(String[] strs){
		//java -Xms3448M -Xmx3448M TestJdkCG
		//以这种方式修改内存配置参数运行，调节过程中[增量次数越多]，运行时所能够正常使用的内存就越大
		//切记，不可过分调到系统剩余内存之外，小心卡死
		System.out.println("java -Xms3448M -Xmx3448M TestJdkCG");
		System.out.println("以这种方式修改内存配置参数运行，调节过程中[增量次数越多]，运行时所能够正常使用的内存就越大");
		System.out.println("切记，不可过分调到系统剩余内存之外，小心卡死");
		new TestJdkCG();
	}


	public void printMemoryMSG(long frequency	,StringBuffer sb){
		long totalMemory=Runtime.getRuntime().totalMemory()/1024/1024;
		long maxMemory=Runtime.getRuntime().maxMemory()/1024/1024;
		long freeMemory=Runtime.getRuntime().freeMemory()/1024/1024;

		if(osName.equalsIgnoreCase("linux")){
			moveToFirstLine();
			clearToEndOfLine();
			print("增量次数["+frequency+"]");
			print("虚拟机中的内存总量="+printFormatColor(totalMemory+"", "36m")+"MB,");
			print("虚拟机试图使用的最大内存量="+printFormatColor(maxMemory+"", "36m")+"MB,");
			print("虚拟机中的空闲内存量="+printFormatColor(freeMemory+"", "36m")+"MB");
		}else{
//			moveToFirstLine();
			clearToEndOfLine();
			print("增量次数["+frequency+"]");
			print("虚拟机中的内存总量="+totalMemory+"MB,");
			print("最大内存量="+maxMemory+"MB,");
			print("空闲内存量="+freeMemory+"MB");
		}
		
	}
	
	/**
	 * @param str 颜色内容
	 * @param colorCode 颜色代码
	 * @return
	 */
	public  String printFormatColor(String str,String colorCode) {
		// TODO Auto-generated method stub

		return new StringBuffer("\033[").append(colorCode).append(str).append("\033[0m").toString();
	}

	/**
	 * 产生随机字符串
	 * */
	private static Random randGen = null;
	private static char[] numbersAndLetters = null;

	public static final String randomString(int length) {
		if (length < 1) {
			return null;
		}
		if (randGen == null) {
			randGen = new Random();
			numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz" +
					"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();
			//numbersAndLetters = ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();
		}
		char [] randBuffer = new char[length];
		for (int i=0; i<randBuffer.length; i++) {
			randBuffer[i] = numbersAndLetters[randGen.nextInt(71)];
			//randBuffer[i] = numbersAndLetters[randGen.nextInt(35)];
		}
		return new String(randBuffer);
	}





	




	/**
	 * 隱藏光標
	 */
	public static final String HIDETHECURSOR="\033[?25l\033[0m";
	/**
	 * 顯示光標
	 */
	public static final String SHOWTHECURSOR="\033[?25h\033[0m";
	/**
	 * 清除从光标到行尾的内容 
	 */
	public static final String CLEARTOENDOFLINE="\033[K\033[0m";
	
	/**
	 * 清屏
	 */
	public static final String CLEARALL="\033[2J\033[0m";
	/**
	 * 移動到行首
	 */
	public static final String MOVETOFIRSTLINE="\033[888D\033[0m";
	
	private String osName=System.getProperty("os.name").toLowerCase();
	
	/**
	 *  @see #CLEARTOENDOFLINE
	 */
	public void clearToEndOfLine(){
		if(osName.equalsIgnoreCase("linux")){
			print(CLEARTOENDOFLINE);	
		}else{
			print("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b");
//			for (int i = 0; i < 200; i++) {
//				print("\b");
//			}
		}
	}
	/**
	 *  @see #CLEARALL
	 */
	public void clear(){
		if(osName.equalsIgnoreCase("linux")){
			print(CLEARALL);
		}
	}
	
	/**
	 *  @see #MOVETOFIRSTLINE
	 */
	public void moveToFirstLine(){
		if(osName.equalsIgnoreCase("linux")){
			print(MOVETOFIRSTLINE);
		}
		
	}
	
	/**
	 *  @see #HIDETHECURSOR
	 */
	public void hideTheCursor(){
		if(osName.equalsIgnoreCase("linux")){
			print(HIDETHECURSOR);
		}
	}
	
	/**
	 *  @see #SHOWTHECURSOR
	 */
	public void showTheCursor(){
		if(osName.equalsIgnoreCase("linux")){
			print(SHOWTHECURSOR);
		}
	}
	


	/** 終端輸出,如果不為 linux 系統則不輸出
	 * @param o
	 */
	public void print(Object o){
		if(osName.equalsIgnoreCase("linux")){
			System.out.print(o);
		}else{
			System.out.print(o);
		}
	}
	
}



```
