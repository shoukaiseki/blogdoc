# maximo打包配置

businessobjects.jar/META-INF/MANIFEST.MF 添加信息

修改 IBM/SMP/maximo/deployment/buildmaximoear.xml 配置文件中的 36行 <property name="maximo.businessobjectsclasspath" ..../>


## 自定义ear包结构

自定义 businessobjects 类放入 customizeclass 目录, properties 不打包,修改后的 buildmaximoear 如下

自定义添加 jar 放入 customizelib 目录

C:\IBM\SMP\maximo\applications\maximo 新建 customizeclass 目录,并把添加的class放入其中

C:\IBM\SMP\maximo\applications\maximo 新建 customizelib 目录,并把添加的jar放入其中
```Xml
<?xml version="1.0"?>

<project name="MAXIMO" default="earBuild" basedir=".">
	<description>
		This buildfile is used to build the MAXIMO Enterprise Archive File(maximo.ear). 
	</description>
        
	<target name="init" 
	        description="Initializes the directories and file names">
		
		<property name="maximo.basedir" value="${basedir}\..\applications\maximo"/>
		<property name="maximo.properties" value="maximo.properties"/>
		<property name="maximo.deploydir" value="${basedir}\default"/>
		<property name="maximo.deploydir.temp" value="${maximo.deploydir}\temp"/>

		<property name="maximo.earfile" value="maximo.ear"/>
		<property name="maximo.businessobjectsjarfile" value="businessobjects.jar"/>
		<property name="maximo.commonwebjarfile" value="commonweb.jar"/>
		<property name="maximo.mbowarfile" value="mboweb.war"/>
		<property name="maximo.maximouiwarfile" value="maximouiweb.war"/>
		<property name="maximo.maxrestwarfile" value="maxrestweb.war"/>
		<property name="maximo.mboejbclientjarfile" value="mboejbclient.jar"/>
		<property name="maximo.mboejbjarfile" value="mboejb.jar"/>
		<property name="maximo.meawarfile" value="meaweb.war"/>
		<property name="maximo.propertiesjarfile" value="properties.jar"/>
		<property name="maximo.mbojavajarfile" value="mbojava.jar"/>
		
		<property name="maximo.appxmlfile" value="${maximo.basedir}/META-INF/deployment-application.xml"/>
		<property name="maximo.axis2" value="lib/axis2.jar"/>
		<property name="maximo.xmlbeans" value="lib/xmlbeans-2.3.0.jar"/>
		<property name="maximo.jaxen" value=""/>
		<property name="maximo.jaxwsprovider" value="WEB-INF/classes/psdi/iface/webservices/MaxWebServiceProvider.class"/>
		<property name="maximo.jaxwsproviderdyn" value="WEB-INF/classes/psdi/iface/webservices/JAXWSWebServiceProvider.class"/>


		<!-- ${maximo.propertiesjarfile}
		     -->
		<property name="maximo.businessobjectsclasspath" 
			    value="properties lib/ldapbp.jar lib/log4j-1.2.16.jar lib/db2jcc.jar lib/db2jcc_license_cu.jar lib/oraclethin.jar lib/sqljdbc.jar lib/k2client.jar lib/idapi.jar lib/xmlParserAPIs.jar lib/acweb.jar lib/commons-net-1.4.0.jar lib/jsr181.jar lib/remoteaccess.jar lib/platform-model.jar lib/ssh.jar /lib/api-client.jar /lib/api-dep.jar /lib/oal-api.jar /lib/oal-topomgr.jar /lib/oal-common.jar lib/edm-server.jar /lib/api-dl.jar  /lib/maxcom.jar /lib/icu4j.jar /lib/json4j.jar /lib/jviews-gantt.jar /lib/jviews-diagrammer.jar lib/jviews-framework-lib.jar lib/jhbasic-2.0_05.jar lib/contentloader.jar lib/oslcquery.jar lib/commons-codec.jar lib/oauth.jar lib/commons-httpclient.jar lib/tdb-0.8.7-patched.jar lib/jena-2.6.3-patched.jar lib/slf4j-log4j12-1.6.4.jar lib/slf4j-api-1.6.4.jar lib/iri-0.8.jar lib/sdb-1.3.2.jar lib/xercesImpl-2.7.1.jar customizelib/kotlin-runtime.jar customizelib/importexcel.jar customizelib/bsh-2.0b4.jar customizeclass"/>
		<property name="maximo.mbowarclasspath" 
			    value="${maximo.businessobjectsjarfile} ${maximo.mboejbclientjarfile} ${maximo.commonwebjarfile} ${maximo.propertiesjarfile} lib/ldapbp.jar ${maximo.axis2} lib/log4j-1.2.16.jar lib/db2jcc.jar lib/db2jcc_license_cu.jar lib/oraclethin.jar lib/sqljdbc.jar lib/k2client.jar lib/jdom.jar lib/axis.jar lib/axis-ant.jar lib/commons-discovery.jar lib/commons-logging.jar lib/jaxrpc.jar lib/saaj.jar lib/idapi.jar lib/acweb.jar lib/remoteaccess.jar lib/platform-model.jar lib/ssh.jar /lib/maxcom.jar lib/icu4j.jar lib/junit-4.4.jar lib/jython.jar ${maximo.jaxen}"/>
		<property name="maximo.maximouiwarclasspath" 
			    value="${maximo.businessobjectsjarfile} ${maximo.mboejbclientjarfile} ${maximo.commonwebjarfile} ${maximo.propertiesjarfile} lib/k2client.jar lib/lowagie.jar lib/soap.jar ${maximo.mboejbjarfile} lib/icu4j.jar lib/bcel-5.2.jar"/>
		<property name="maximo.commonwebclasspath" 
			    value="${maximo.businessobjectsjarfile} ${maximo.mboejbclientjarfile} lib/icu4j.jar "/>
		<property name="maximo.mboejbclientclasspath" 
			    value="${maximo.businessobjectsjarfile} lib/icu4j.jar"/>

		<echo>maximo.deploydir=${maximo.deploydir}</echo>
		<echo>maximo.basedir=${maximo.basedir}</echo>

		<mkdir dir="${maximo.deploydir}"/>
		<mkdir dir="${maximo.deploydir.temp}"/>
		
		<move todir="${basedir}\..\applications\maximo\businessobjects\classes\psdi\app\signature\apps" includeemptydirs="false" >
			<fileset dir="${basedir}\..\applications\maximo\businessobjects\classes\psdi\app\signature\apps" >
				<exclude name="*.key"/>
			</fileset>
			<mapper type="glob" from="*.class" to="*.key"/>
		</move>		
		
	</target>

	<target name="mboWarBuild" 
	        depends="init" 
	        description="Builds the MAXIMO Web Application Archive File for Business Objects (mbo.war) file">
	        
		<echo>mboWarBuild war file=${maximo.deploydir.temp}/${maximo.mbowarfile}</echo>
		<war destfile="${maximo.deploydir.temp}/${maximo.mbowarfile}" 
			 webxml="${maximo.basedir}/mboweb/webmodule/WEB-INF/web.xml" 
			 index="true">
			<fileset dir="${maximo.basedir}/mboweb/webmodule">
				<include name="**/*.*"/>
				<exclude name="WEB-INF/web.xml"/>
				<exclude name="META-INF/MANIFEST.MF"/>
			</fileset>
			<manifest>
				<attribute name="Class-Path" value="${maximo.mbowarclasspath}"/>
			</manifest>
  		</war>
	</target>
	
	<target name="maximouiWarBuild" 
	        depends="init" 
	        description="Builds the MAXIMO UI Web Application Archive File (maximoui.war) file">
	        
		<echo>maximouiWarBuild war file=${maximo.deploydir.temp}/${maximo.maximouiwarfile}</echo>
		<war destfile="${maximo.deploydir.temp}/${maximo.maximouiwarfile}" 
			 webxml="${maximo.basedir}/maximouiweb/webmodule/WEB-INF/web.xml" 
			 index="true">
			<fileset dir="${maximo.basedir}/maximouiweb/webmodule">
				<include name="**/*.*"/>
				<exclude name="WEB-INF/web.xml"/>
				<exclude name="META-INF/MANIFEST.MF"/>
			</fileset>
			<classes dir="${maximo.basedir}/maximouiweb/webmodule" >
				<include name="jsp/**/*.txt"/>
			</classes>
			<manifest>
				<attribute name="Class-Path" value="${maximo.maximouiwarclasspath}"/>
			</manifest>
  		</war>
	</target>



	<target name="mboEJBClientBuild" 
	        depends="init,businessObjectsBuild" 
	        description="Builds the MAXIMO EJB Client Application Archive File for (mboejbclient.jar) file">
	        
		<echo>mboEJBClientBuild jar file=${maximo.deploydir.temp}/${maximo.mboejbclientjarfile}</echo>
		<jar destfile="${maximo.deploydir.temp}/${maximo.mboejbclientjarfile}" 
			 index="true">
			<fileset dir="${maximo.basedir}/mboejbclient/classes">
				<include name="**/*.*"/>
				<exclude name="META-INF/MANIFEST.MF"/>
			</fileset>
			<manifest>
				<attribute name="Class-Path" value="${maximo.mboejbclientclasspath}"/>
			</manifest>
  		</jar>
	</target>

	
	<target name="mboEJBBuild" 
	        depends="init" 
	        description="Builds the MAXIMO EJB Application Archive File for (mboejb.jar) file">
	        
		<echo>mboEJBBuild jar file=${maximo.deploydir.temp}/${maximo.mboejbjarfile}</echo>
		<jar destfile="${maximo.deploydir.temp}/${maximo.mboejbjarfile}" 
			 index="true">
			<fileset dir="${maximo.basedir}/mboejb/ejbmodule">
				<include name="**/*.*"/>
				<exclude name="META-INF/MANIFEST.MF"/>
			</fileset>
			<manifest>
				<attribute name="Class-Path" value="${maximo.mbowarclasspath}"/>
			</manifest>
  		</jar>
	</target>

	<target name="meaWarBuild" 
	        depends="init" 
	        description="Builds the MEA Web Application Archive File it's Servlet (meaweb.war) file">
	        
		<echo>meaWarBuild war file=${maximo.deploydir.temp}/${maximo.meawarfile}</echo>
		<war destfile="${maximo.deploydir.temp}/${maximo.meawarfile}" 
			 webxml="${maximo.basedir}/meaweb/webmodule/WEB-INF/web.xml" 
			 index="true">
			<fileset dir="${maximo.basedir}/meaweb/webmodule">
				<include name="**/*.*"/>
				<exclude name="WEB-INF/web.xml"/>
				<exclude name="META-INF/MANIFEST.MF"/>
				<exclude name="${maximo.jaxwsprovider}"/>
				<!--exclude name="${maximo.jaxwsproviderdyn}"/-->
			</fileset>
			<manifest>
				<attribute name="UseWSFEP61ScanPolicy" value="true"/>
				<attribute name="UseEJB61FEPScanPolicy" value="true"/>
				<attribute name="Class-Path" value="${maximo.mbowarclasspath}"/>
			</manifest>
  		</war>
	</target>


	<target name="maxrestWarBuild" 
	        depends="init" 
	        description="Builds the REST Web Application Archive File for (maxrestweb.war) file">
	        
		<echo>maxrestWarBuild war file=${maximo.deploydir.temp}/${maximo.maxrestwarfile}</echo>
		<war destfile="${maximo.deploydir.temp}/${maximo.maxrestwarfile}" 
			 webxml="${maximo.basedir}/maxrestweb/webmodule/WEB-INF/web.xml" 
			 index="true">
			<fileset dir="${maximo.basedir}/maxrestweb/webmodule">
				<include name="**/*.*"/>
				<exclude name="WEB-INF/web.xml"/>
				<exclude name="META-INF/MANIFEST.MF"/>
			</fileset>
			<manifest>
				<attribute name="Class-Path" value="${maximo.mbowarclasspath}"/>
			</manifest>
  		</war>
	</target>

	<target name="businessObjectsBuild" 
	        depends="init" 
	        description="Builds the MAXIMO Business Objects Archive File (businessobjects.jar) file">
	        
		<echo>businessobjects.jar file=${maximo.deploydir.temp}/${maximo.businessobjectsjarfile}</echo>
		<mkdir dir="${maximo.deploydir.temp}/importreports"/>
		<delete>
			<fileset dir="${maximo.deploydir.temp}/importreports">
				<include name="reports.zip"/>
			</fileset>
		</delete>

		<zip destfile="${maximo.deploydir.temp}/importreports/reports.zip">
			<fileset dir="${maximo.basedir}/../../reports/birt">
				<include name="libraries/**/*.*"/>
				<include name="reports/**/*.*"/>
			</fileset>
		</zip>

		<mkdir dir="${maximo.deploydir.temp}/mxoptimization"/>
		<delete>
			<fileset dir="${maximo.deploydir.temp}/mxoptimization">
				<include name="mxoptimization.zip"/>
			</fileset>
		</delete>

		<zip destfile="${maximo.deploydir.temp}/mxoptimization/mxoptimization.zip">
			<fileset dir="${maximo.basedir}/optimization">
				<include name="**/*.*"/>
				<exclude name="mxodmepackages/*.*"/>
				<exclude name="mxodme/src/**/*.*"/>
			</fileset>
		</zip>
		
		<jar destfile="${maximo.deploydir.temp}/${maximo.businessobjectsjarfile}" 
			 index="true">
			<fileset dir="${maximo.basedir}/businessobjects/classes">
				<include name="**/*.*"/>
			</fileset>
			<fileset dir="${maximo.basedir}/resources">
				<include name="**/*.*"/>
				<exclude name="importreports/*.*"/>
			</fileset>
			<fileset dir="${maximo.deploydir.temp}">
				<include name="importreports/reports.zip"/>
			</fileset>
			<fileset dir="${maximo.deploydir.temp}">
				<include name="mxoptimization/mxoptimization.zip"/>
			</fileset>
			<fileset dir="${maximo.basedir}/optimization">
				<include name="mxodmepackages/*.*"/>
			</fileset>
			<manifest>
				<attribute name="Class-Path" value="${maximo.businessobjectsclasspath}"/>
			</manifest>
  		</jar>
	</target>

	<target name="commonWebBuild" 
	        depends="init" 
	        description="Builds the Common Web Archive File (commonweb.jar) file">
	        
		<echo>commonweb.jar file=${maximo.deploydir.temp}/${maximo.commonwebjarfile}</echo>
		<jar destfile="${maximo.deploydir.temp}/${maximo.commonwebjarfile}" 
			 index="true">
			<fileset dir="${maximo.basedir}/commonweb/classes">
				<include name="**/*.*"/>
			</fileset>
			<manifest>
				<attribute name="Class-Path" value="${maximo.commonwebclasspath}"/>
			</manifest>
  		</jar>
	</target>

	<target name="propertiesBuild" 
	        depends="init" 
	        description="Builds the MAXIMO properties Archive File (properties.jar) file">
	        
		<ant antfile="ui-schema-generator.xml" dir="${maximo.basedir}/properties" inheritAll="false" target="all" />

		<echo>properties.jar file=${maximo.deploydir.temp}/${maximo.propertiesjarfile}</echo>
		<copy todir="${maximo.deploydir.temp}/properties" >
			<fileset dir="${maximo.basedir}/properties">
				<include name="**/*.*"/>
                <exclude name="version/*.*"/>
			</fileset>
		</copy>
		<copy todir="${maximo.deploydir.temp}/customizeclass" >
			<fileset dir="${maximo.basedir}/customizeclass">
				<include name="**/*.*"/>
                <exclude name="version/*.*"/>
			</fileset>
		</copy>
		<jar destfile="${maximo.deploydir.temp}/${maximo.propertiesjarfile}" 
			 index="true">
			<fileset dir="${maximo.deploydir.temp}/properties">
				<include name="**/*.*"/>
			</fileset>
  		</jar>
	</target>

	<target name="mboJavaBuild" 
	        depends="init" 
	        description="Builds the MAXIMO Client Archive File (mbojava.jar) file">
	        
		<echo>mboJavaBuild jar file=${maximo.deploydir.temp}/${maximo.mbojavajarfile}</echo>
		<jar destfile="${maximo.deploydir.temp}/${maximo.mbojavajarfile}" 
			 index="true">
			<fileset dir="${maximo.basedir}/mbojava/javamodule">
				<include name="**/*.*"/>
				<exclude name="META-INF/MANIFEST.MF"/>
			</fileset>
			<manifest>
				<attribute name="Main-Class" value="psdi.client.LaunchClient"/>
				<attribute name="Class-Path" value="${maximo.maximouiwarclasspath}"/>
			</manifest>
  		</jar>
	</target>

	<target name="buildDojo">
		<echo>Building Dojo layer files</echo>
		<tstamp>
			<format property="dojo.build" pattern="yyyyMMdd-kkmm"/>
		</tstamp>
		<ant antfile="builddojo.xml" dir="${basedir}/../applications/maximo/maximouiweb" inheritAll="false" target="all">
			<property name="build" value="${dojo.build}" />
		</ant>
	</target>

	<target name="earBuild" 
	        depends="init, propertiesBuild, buildDojo, businessObjectsBuild, commonWebBuild, mboEJBClientBuild, mboWarBuild, maximouiWarBuild, mboEJBBuild, meaWarBuild, maxrestWarBuild, mboJavaBuild" 
	        description="Builds the MAXIMO Enterprise Archive File (maximo.ear) file">

		<ear destfile="${maximo.deploydir}/${maximo.earfile}" 
		     appxml="${maximo.appxmlfile}">

			<!-- WEB Application Modules files -->
			<fileset dir="${maximo.basedir}">
				<include name="**/*.*"/>
				<exclude name="businessobjects/src/**/*.xsl"/>
				<exclude name="businessobjects/src/**/*.xsd"/>
				<exclude name="*.xml"/>
				<exclude name="*.classpath"/>
				<exclude name="*.project"/>
				<exclude name="businessobjects/**/*.*"/>
				<exclude name="commonweb/**/*.*"/>
				<exclude name="lib/j2ee.jar"/>
				<exclude name="lib/weblogic.jar"/>
				<exclude name="lib/com.ibm.ws.runtime_6.1.0.jar"/>
				<exclude name="lib/com.ibm.ws.runtime.jar"/>
				<exclude name="lib/com.ibm.ws.admin.core.jar"/>
				<exclude name="lib/com.ibm.ws.admin.services.jar"/>
				<exclude name="lib/com.ibm.ws.emf_2.1.0.jar"/>
				<exclude name="lib/org.eclipse.emf.commonj.sdo.jar"/>
				<exclude name="lib/odmeall.jar"/>
				<exclude name="lib/oplall.jar"/>
				<exclude name="lib/cognos-axis.jar"/>
				<exclude name="lib/cognosClient.jar"/>
				<exclude name="lib/aspectjweaver.jar"/>
				<exclude name="${maximo.xmlbeans}"/>
				<exclude name="mboejbclient/**/*.*"/>
				<exclude name="mboejb/**/*.*"/>
				<exclude name="maximouiweb/**/*.*"/>
				<exclude name="mboweb/**/*.*"/>
				<exclude name="meaweb/**/*.*"/>
				<exclude name="maxrestweb/**/*.*"/>
				<exclude name="mbojava/**/*.*"/>
				<exclude name="META-INF/application.xml"/>
				<exclude name="META-INF/deployment-application.xml"/>
				<exclude name="optimization/**/*.*"/>

				<exclude name="properties/*.*"/>
				<!--
				<exclude name="properties/domainchecker/*.*"/>
				<exclude name="properties/iloglicense/*.*"/>
				<exclude name="properties/product/*.*"/>
				<exclude name="properties/registry-extensions/*.*"/>
				-->
				<exclude name="resources/**/*.*"/>
				<exclude name="*.bat"/>
				<exclude name="*.cmd"/>
				<exclude name="*.sh"/>
			</fileset>
			<fileset dir="${maximo.deploydir.temp}">
				<include name="**/*.war"/>
				<include name="${maximo.businessobjectsjarfile}"/>
				<include name="${maximo.commonwebjarfile}"/>
				<!--
				<include name="${maximo.propertiesjarfile}"/>
-->
				<include name="properties/*"/>
				<include name="${maximo.mboejbclientjarfile}"/>
				<include name="${maximo.mboejbjarfile}"/>
				<include name="${maximo.mbojavajarfile}"/>
			</fileset>
		</ear>
		<delete>
			<fileset dir="${maximo.deploydir.temp}">
				<include name="**/*.war"/>
				<include name="**/*.jar"/>
				<include name="**/maximo.properties"/>
			</fileset>
			<fileset dir="${maximo.deploydir.temp}/properties">
				<include name="**/*.*"/>
			</fileset>
		</delete>
		<delete dir="${maximo.deploydir.temp}"/>
	</target>

	<target name="clean" depends="init"
	        description="removes existing EAR, WAR, JAR files">
		<delete>
			<fileset dir="${maximo.deploydir.temp}">
				<include name="*.*"/>
			</fileset>
		</delete>
		<delete>
			<fileset dir="${maximo.deploydir}">
				<include name="${maximo.earfile}"/>
			</fileset>
		</delete>
		<delete dir="${maximo.deploydir.temp}"/>
	</target>

</project>
```
