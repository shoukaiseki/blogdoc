package com.wmc.webclient.test2;

import psdi.mbo.MboRemote;
import psdi.mbo.MboSetRemote;
import psdi.util.MXException;
import psdi.webclient.system.beans.AppBean;
import psdi.webclient.system.beans.DataBean;

import java.rmi.RemoteException;

/**
 * com.wmc.webclient.test2.TestAdjustmentAppBean<br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  2017-12-18 17:45:472017-12-18グ17:46:03shoukaiseki.blog.163.com/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
public class TestAdjustmentAppBean extends AppBean{

    public TestAdjustmentAppBean(){
       super();
    }

    @Override
    public int INSERT() throws MXException, RemoteException {
        super.INSERT();
        if(sessionContext.getPreviousApp()!=null){
            DataBean poBean = sessionContext.getPreviousApp().getAppBean();
            MboRemote po = poBean.getMbo();
            System.out.println("po.toBeAdded="+po.toBeAdded());
            System.out.println("poBean."+po.getUniqueIDName()+"="+po.getUniqueIDValue());
            MboSetRemote polineSet = po.getMboSet("TEST2A");
            MboSetRemote prlineSet = this.app.getDataBean("testprline").getMboSet();
            String[] targetAttributes = {"A", "B", "DESCRIPTION"};
            String[] sourceAttributes = {"A", "B", "DESCRIPTION"};
            MboRemote poline ;
            for (int i=0;(poline = polineSet.getMbo(i))!=null;i++){
                System.out.println("polineSet.for.i="+i);
                MboRemote prline = prlineSet.add();
                prline.setValue("TEST2ID",this.getMbo().getLong("TEST2ID"),2L);
                prline.copyValue(poline,sourceAttributes,targetAttributes,2L);
            }
        }
        return 1;
    }

    @Override
    public int SAVE() throws MXException, RemoteException {
        boolean toBeAdded = getMbo().toBeAdded();
        super.SAVE();
        if(sessionContext.getPreviousApp()!=null) {
            DataBean poBean = sessionContext.getPreviousApp().getAppBean();

            String appId = sessionContext.getPreviousApp().getApp();
            System.out.println("poBean.appid="+ appId);
            if(toBeAdded&&"TESTPO".equalsIgnoreCase(appId)){
                MboSetRemote polineSet = sessionContext.getPreviousApp().getDataBean("poline").getMboSet();
                MboRemote poline;
                MboSetRemote prlineSet=this.getMbo().getMboSet("TEST2A");
                MboRemote prline;
                for (int i=0;(prline=prlineSet.getMbo(i))!=null;i++){
                    poline=polineSet.getMbo(i);
                    if(poline!=null){
                       poline.setValue("DESCRIPTION",String.valueOf(prline.getLong("TEST2AID")),2L);
                    }
                }

            }
        }
        return 1;
    }

}
