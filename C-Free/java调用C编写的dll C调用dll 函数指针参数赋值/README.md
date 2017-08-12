# java调用C编写的dll C调用dll 函数指针参数赋值

用C-Free新建一个动态链接库的项目,项目名称为testdll

Source Files:testdll.c
```
#include <windows.h>
#define _EXPORTDLL
#include "testdll.h"

BOOL APIENTRY DllMain (HINSTANCE hInst     /* Library instance handle. */ ,
                       DWORD reason        /* Reason this function is being called. */ ,
                       LPVOID reserved     /* Not used. */ )
{
	switch (reason)
	{
		case DLL_PROCESS_ATTACH:
		break;

		case DLL_PROCESS_DETACH:
		break;

		case DLL_THREAD_ATTACH:
		break;

		case DLL_THREAD_DETACH:
		break;
	}

	/* Returns TRUE on success, FALSE on failure */
	return TRUE;
}

void getTest(char* str,char* szValue)
{
	strcpy(szValue,"213.213"); 
	_gcvt(213.2134,10,szValue);
	printf("getTest.str=%s\n", str);
}

```

Header Files:testdll.h
```
#ifndef _DLLMAIN_H
#define _DLLMAIN_H

#ifdef	_EXPORTDLL
#define _LIBAPI __declspec(dllexport)
#else
#define _LIBAPI __declspec(dllimport)
#endif

/* Export following functions */
_LIBAPI void getTest(char* str,char* szValue);

#endif
```

构建(B)-构建 生成dll文件

用C-Free新建一个控制台的项目,项目名称为testDllExe

Source Files:main.c
```
#include <stdio.h>
#include "testdll.h"
#pragma comment(lib,"testdll.lib")
void Hello(char* szValue);
int main(int argc, char *argv[])
{
	int i;
	char ch[5] = {'a','b','c','d','\0'};//方式1
	char ch2[]="hello";//方式2
	char *ch3 = "world";//方式3
	char *ch4[3] = {"welcome", "," ,"doudou745"};//字符指针数组
	char asus[32]="FYSIS.U1DCSAI.D1144";//方式2
	char szPoint[32] = "FYSIS.U1DCSAI.D1144";
	char pdValue[32] = "12323232";
	getTest(szPoint, pdValue);
	printf("%s\n",asus);
	printf("value=%s\n",pdValue);
	Hello(pdValue);
	printf("value=%s\n",pdValue);
	printf("pdValue.double=%f\n", pdValue);
	printf("%s\n", ch);
	printf("%s\n", ch2);
	printf("%s\n", ch3);
	printf("double=%f\n", 213.2134);
	for (i = 0; i < 3; i++)
	{
		printf("ch4[%d] = %s\n", i+1, ch4[i]);
	}
	return 0;
}

void Hello(char *szValue)
{
	/**方法1-start**/ 
//	char *pdValue = szValue;
//	strcpy(pdValue,"123.23"); 
	/**方法1-end**/
	/**方法2-start**/ 
	strcpy(szValue,"123.23"); 
	/**方法2-end**/ 
}


```

再点击该项目的Source Files选择"添加文件到文件夹",选择testdll项目的testdll.c

之后构建(B)-构建,构建(B)-编译,构建(B)-运行


java调用dll

将testdll.dll复制到项目根目录
```
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.xvolks.jnative.JNative;
import org.xvolks.jnative.exceptions.NativeException;
import org.xvolks.jnative.pointers.Pointer;
import org.xvolks.jnative.pointers.memory.MemoryBlockFactory;


public class testDll {

	public static void main(String[] args) throws NativeException, IllegalAccessException, ParseException {
	    JNative n = new JNative("testdll.dll", "getTest");
	    Pointer value = new Pointer(MemoryBlockFactory.createMemoryBlock(64));
	    n.setParameter(0, "asus");
	    n.setParameter(1, value);
	    n.invoke();
	    System.out.println("value="+value.getAsDouble(0));
	    System.out.println("value="+value.getAsString());
	    
		
	}
}

```
