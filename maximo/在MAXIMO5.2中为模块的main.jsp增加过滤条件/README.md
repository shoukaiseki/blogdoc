# 在MAXIMO5.2中为模块的main.jsp增加过滤条件  

文章来自:http://blog.csdn.net/yf6456/article/details/1123119

当客户要求对当前模块查询做默认的过滤时,有以下方法可以实现:

实例:

## 1.为选项设置默认值

### 方法1:在D:/ROOT/MaximoDev/maximo/maximoui/jsp/app/wotrack/main.jsp页面中,增加以下代码:

```Xml
    <psdi:standardappsets mboname="WORKORDER" recordclass="psdi.jsp.app.wotrack.WorkOrderBean" actionclass="psdi.jsp.app.wotrack.Actions" >
        <psdi:appdefault mboattribute="changechildstatus" defaultvalue="Y"/>
        <psdi:appdefault mboattribute="worktype" defaultvalue="DA"/>
    </psdi:standardappsets>
```
<psdi:appdefault mboattribute="worktype" defaultvalue="DA"/>,设置了字段worktype的默认值为DA,则工单跟踪将只能查询worktype为"DA"的工单


### 方法2:使用class来设置默认值:

package custom.jsp.app.wotrack;
```Java

import java.io.IOException;
import java.rmi.RemoteException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.jsp.PageContext;
import psdi.jsp.beans.MboSetBean;
import psdi.jsp.util.*;
import psdi.util.MXException;
import psdi.util.MXSession;
import psdi.security.UserInfo;
import org.apache.log4j.Logger;

public class MySearchHandler {
    public MySearchHandler() {
    }

    public static boolean handleRequest(PageContext pagecontext)
        throws RemoteException,IOException,ServletException{
        HttpServletRequest httpservletrequest = (HttpServletRequest) pagecontext.getRequest();
        HttpSession httpsession = httpservletrequest.getSession(false);
        SAContext sacontext = SAContext.get(httpservletrequest);
        try {
            String s1 = (String) sacontext.getValue("init");
            if (s1 == null) {
                MboSetBean mbosetbean1 = (MboSetBean) sacontext.getValue("set");
                mbosetbean1.setQbe("worktype", "=DA");
                sacontext.putValue("init", "true");
                mbosetbean1.reset();
            }
        } catch (MXException mxexception) {
            httpsession.setAttribute("MXMessage", Resource.getMessage(httpservletrequest, mxexception));
        }

        return false;
    }
}
```

在D:/ROOT/MaximoDev/maximo/maximoui/jsp/app/wotrack/search.jsp页面中,增加以下代码

<psdi:handlerequest classname="custom.jsp.app.wotrack.MySearchHandler" />

### 2.设置过滤条件

在D:/ROOT/MaximoDev/maximo/maximoui/jsp/app/wotrack/main.jsp页面中,修改为以下代码:

```Xml
   <psdi:standardappsets mboname="WORKORDER" recordclass="psdi.jsp.app.wotrack.WorkOrderBean" actionclass="psdi.jsp.app.wotrack.Actions" apprestrictions=" (WORKTYPE!='MR' AND WORKTYPE!='DA' )" >
```
 apprestrictions=" (WORKTYPE!='MR' AND WORKTYPE!='DA' )"相当于为当前页面查询设置默认过滤条件" (WORKTYPE!='MR' AND WORKTYPE!='DA' )" 

