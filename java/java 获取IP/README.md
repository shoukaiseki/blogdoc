# java 获取IP

```Java
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;


public class ip {
	
	public static void main(String[] args) throws UnknownHostException {
		StringBuilder IFCONFIG=new StringBuilder();  
		   try {  
		       for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {  
		           NetworkInterface intf = en.nextElement();  
		           for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {  
		               InetAddress inetAddress = enumIpAddr.nextElement();  
		               if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress() && inetAddress.isSiteLocalAddress()) {  
		               IFCONFIG.append(inetAddress.getHostAddress().toString()+"\n");  
		               }  
		  
		           }  
		       }  
		   } catch (SocketException ex) {  
		   }  
		   System.out.println(IFCONFIG); 
		   
		   String ip=java.net.InetAddress.getLocalHost().getHostAddress(); 
		   System.out.println("ip="+ip);
		
	}

}
```



http://www.iteye.com/problems/88283
<br>
现在，我们在系统中用InetAddress.getLocalHost().getHostAddress()获取本机的IP地址，之后这个地址要给别人用来访问这台机器。 
<br>

<br>
可现在的问题是，在有些服务器上，这个方法得到的ip地址是127.0.0.1，但是，大多数服务器，都能够得到真实ip。 
<br>

<br>
经过比较发现，只要是得到127的地址的，hosts文件的配置都是这样： 
<br>
127.0.0.1               localhost.localdomain localhost 
<br>
::1             localhost6.localdomain6 localhost6 
<br>

<br>

<br>
而正常的服务器的hosts文件是： 
<br>
127.0.0.1       localhost.localdomain localhost 
<br>
::1             localhost6.localdomain6 localhost6 
<br>
192.167.0.101   NC-PL-DEV011 
<br>

<br>
所以，现在都是在那些服务器上，设置host name的解析的ip地址。不知道有没有什么办法，可以方便的得到ip地址，而不管服务器的hosts文件的配置。
<br>

