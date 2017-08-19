# JS代码语法着色

```Html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title> lJSParser        : Little JavaScript Parser v2.0 </title>
<meta name="author" content="CN.LEI" />
<meta name="copyright" content="scriptpower@qq.com , http://www.cnlei.com" />
<script type="text/javascript">
if(typeof(window["lJSF"])=="undefined")window["lJSF"]={
        Version        :"2.5.2<std_lv_n_-10>",
        Author        :"CN.LEI",
        EMail                :"scriptpower@qq.com",
        Website        :"http://www.cnlei.com"
};
lJSF.obj={};
lJSF.obj.JSParser={};
/*
* lJSParser        : Little JavaScript Parser v2.0
****************************************************
* Author        : CN.LEI
* Mail        : scriptpower@qq.com
* WebSite        : http://www.cnlei.com
* Created        : 2010-01-01
* Update        : 2010-01-23
****************************************************
* 1. 解析JavaScript语法
    分析JS代码中的纯代码、字符串、正则、注释等等对其进行归类，按序存入数组中，并返回该数组以供其它API接口使用。
* 2. 扩展功能：
    以此解析器的返回结果为基础，可方进行以下各种功能扩展和实现
    a. JS语法标亮着色、
    b. JS代码压缩合并、
    c. JSON数据安全检测
    d. 等等
****************************************************
* lJSF.obj.JSParser.parse(jscode)
* @param
  jscode        : 待解析的JavaScript代码, String类型
* @return        :
  >> 格式:
  [code,flag,value,code,flag,value...,code,flag,value,code,-1,空串]
  即:
  [js,0,正则值,js,1,单引号字符串值,js,2,双引号字符串值,js,7,单行注释内容,js,8,多行注释内容,s,-1,空串]
  >> flag含义：
        -1        : 空串
        0        : 正则
        1        : 单引号
        2        : 双引号
        7        : 单行注释
        8        : 多行注释
*/
lJSF.obj.JSParser.parse=function(string){
        string=string.replace(/([^\r])\n/g,"$1\r\n");
        var i=0,length=string.length,end,last=0;
        var c,cr,ret=[],js,mode,tmp;
        var regStart=false,regTest=/[\,\=\?\:\&\!\(\[\;\|\+\-\*\%\~\<\>]\s*$/;//正则前缀特征检测
        function endFlag(string,c,i,length){//查找后缀位置
                var n=-1,x;
                while(i++<length){
                        x=string.charAt(i);
                        if(x==c){
                                n=i;
                                break;
                        } else if(x=="\\"){
                                i++;
                        }
                }
                return n;
        }
        function endReg(string,i,length){//查找正则结束位置
                var end=endFlag(string,"\/",i,length);
                var startZ=endFlag(string,"\[",i,length);
                if(startZ<0 || startZ>end){//正则中无中括号
                        return end;
                } else {//startZ<end : 正则中有中括号
                        var endZ=endFlag(string,"\]",startZ,length);
                        if(endZ<0){//正则非法
                                return -1;
                        } else {//继续往后找
                                return endReg(string,endZ,length);
                        }
                }
        }
        function isRegPre(A,js){//判断是否为正则前缀
                var b=true,t;
                for(var i=A.length-3;i>=0;i-=3){
                        t=A[i+1];
                        if(t>=7){//多行注释
                                if(!/^\s*$/.test(A[i])){
                                        b=regTest.test(A[i]);
                                        if(!b)b=/\/\s*$/.test(A[i]);//正则作为除数
                                        break;
                                }
                        } else {
                                b=!!js && /\/\s*$/.test(js);
                                break;
                        }
                }
                return b;
        }
        for(i=0;i<length;){
                c=string.charAt(i);
                if(c=="\""){
                        end=endFlag(string,"\"",i,length);
                        if(end>i){//找到字符串
                                end++;
                                ret.push(string.substring(last,i),2,string.substring(i,end));
                                i=last=end;
                        } else {//字符串中断
                                break;
                        }
                } else if(c=="\'"){
                        end=endFlag(string,"\'",i,length);
                        if(end>i){//找到字符串
                                end++;
                                ret.push(string.substring(last,i),1,string.substring(i,end));
                                i=last=end;
                        } else {//字符串中断
                                break;
                        }
                } else if(c=="\/"){
                        cr=string.charAt(i+1);
                        if(!cr)break;
                        if(cr=="\/"){//单行注释
                                end=string.indexOf("\r\n",i+2);
                                if(end<0){
                                        end=length;
                                } else {
                                        end+=2;
                                }
                                ret.push(string.substring(last,i),7,string.substring(i,end));
                                i=last=end;
                        } else if(cr=="*"){//多行注释
                                end=string.indexOf("*\/",i+2);
                                if(end>i){
                                        end+=2;
                                        ret.push(string.substring(last,i),8,string.substring(i,end));
                                        i=last=end;
                                } else {//多行注释中断
                                        break;
                                }
                        } else {//正则、除法分析
                                js=string.substring(last,i);
                                regStart=false;
                                if(regTest.test(js)){//正则开始
                                        regStart=true;
                                } else{ //if(/^\s*$/.test(js))
                                        if(/\/\s*$/.test(js)){//正则作为除数
                                                var retLen=ret.length;
                                                if(retLen>0){
                                                        if(ret[retLen-2]==8){//向前查找特征符
                                                                regStart=isRegPre(ret,js);
                                                        } else {
                                                                regStart=true;
                                                        }
                                                } else {
                                                        regStart=true;
                                                }
                                        } else if(/^\s*$/.test(js)){//向前查找特征符
                                                regStart=isRegPre(ret,js);
                                        }
                                }
                                if(regStart){
                                        end=endReg(string,i,length);
                                        if(end>i){//找到正则
                                                mode=string.substring(end,end+4);
                                                mode=mode.match(/^\/[igm]*/);
                                                mode=mode[0];
                                                ret.push(js,0,string.substring(i,end)+mode);
                                                i=last=end+mode.length;
                                                //i=end;
                                        } else {//正则中断
                                                break;
                                        }
                                } else {//除法
                                        i++;
                                }
                        }//正则、除法分析 end
                } else if(c=="\\"){//转义符后的字符直接跳过
                        i+=2;
                } else {
                        i++;
                }
        }
        ret.push(string.substring(last,length),-1,"");
        return ret;
};
/*
JavaScirpt语法关键词词库,可自行定义、修改
*/
lJSF.obj.JSParser.Keys=(function(){
        var object=function(arr){
                        var obj={};
                        for(var i=0,l=arr.length; i<l;i++) {
                                obj[arr[i]]=arr[i];
                        }
                        return obj;
                };
        var Keys={};
        Keys.key=object("break|case|catch|class|const|continue|debugger|default|delete|do|else|export|extends|false|finally|for|function|if|import|in|instanceof|new|null|protected|return|super|switch|this|throw|true|try|typeof|var|while|with|abstract|boolean|byte|char|decimal|double|enum|final|float|get|implements|int|interface|internal|long|package|private|protected|public|sbyte|set|short|static|uint|ulong|ushort|void|assert|ensure|goto|invariant|namespace|native|require|synchronized|throws|transient|use|volatile".split("|"));
        Keys.object=object("arguments|screen|window|self|parent|opener|event|document|navigator|Math|Array|String|Function|Object|Number|Date|Boolean|Error|Image|Option|location|history|cookie|DOMParser|ActiveXObject|VBArray|XMLHttpRequest|Enumerator".split("|")),
        Keys.func=object("eval|isFinite|isNaN|parseFloat|parseInt|escape|unescape|encodeURIComponent|decodeURIComponent|decodeURI|encodeURI|alert|confirm|prompt|setTimeout|setInterval|clearTimeout|clearInterval".split("|"));
        Keys.method=object("getElementById|getElementsByTagName|getElementsByName|prototype|concat|join|pop|push|reverse|shift|slice|sort|splice|toLocaleString|unshift|getDate|getDay|getFullYear|getHours|getMilliseconds|getMinutes|getMonth|getSeconds|getTime|getTimezoneOffset|getUTCDate|getUTCDay|getUTCFullYear|getUTCHours|getUTCMilliSeconds|getUTCMinutes|getUTCMonth|getUTCSeconds|getVarDate|getYear|setDate|setFullYear|setHours|setMilliSeconds|setMinutes|setMonth|setSeconds|setTime|setUTCDate|setUTCFullYear|setUTCHours|setUTCMilliseconds|setUTCMinutes|setUTCMonth|setUTCSeconds|setYear|toGMTString|toLocaleString|toUTCString|toString|valueOf|parse|toLocaleString|compile|exec|test|charAt|charCodeAt|concat|fromCharCode|indexOf|lastIndexOf|match|replace|search|slice|split|substr|substring|toLowerCase|toUpperCase|isPrototypeOf|hasOwnProperty|abs|acos|asin|atan|atan2|ceil|cos|exp|floor|log|max|min|pow|random|round|sin|sqrt|tan|apply|call".split("|"));
        return Keys;
})();
/*
* lJSColoration        : Little JavaScript Coloration v2.0
****************************************************
* Author        : CN.LEI
* Mail        : scriptpower@qq.com
* WebSite        : http://www.cnlei.com
* Created        : 2010-01-01
* Update        : 2010-1-23
****************************************************
* 以lJSParser为基础，扩展实现JavaScript语法着色
****************************************************
* lJSF.obj.JSCode.color(strCode,isEncoded)
* @param
  strCode        : 待着色JavaScript代码, String类型
  isEncoded: 待着色代码是否已进行过htmlEncode处理, Boolean类型
* @return        :
  返回着色后的HTML代码
*/
lJSF.obj.JSParser.color=function(code,encoded){
        var parse=lJSF.obj.JSParser.parse;//JavaScirpt语法解析器
        var Keys=lJSF.obj.JSParser.Keys;//JavaScirpt语法词库
        var htmlEncode=function(s){
                return s.replace(/&/g,"&").replace(/>/g,"&gt;").replace(/</g,"&lt;");
        };
        var space=function(s){
                s=s.replace(/\s+/g,function(ss){
                        var aa=[],bb=" \t\r\n",ii;
                        for(var i=0,l=ss.length; i<l;i++) {
                                cc=ss.charAt(i);
                                ii=bb.indexOf(cc);
                                if(ii){
                                        if(ii>1){
                                                aa.push(cc);
                                        } else {
                                                aa.push("    ");
                                        }
                                } else {
                                        if(ss.charAt(i+1) && bb.indexOf(ss.charAt(i+1))>-1){
                                                aa.push("  ");
                                        } else {
                                                aa.push(cc);
                                        }
                                }
                        }
                        return aa.join("");
                });
                return s;
        };
        var loop=function(array,callback,step,start){//正向循环
                step=typeof(step)=="number"?(step>1?step:1):1;
                start=typeof(start)=="number"?(start>0?start:0):0;
                var end=array.length;
                while(start<end){
                        callback(array[start],start,array);
                        start+=step;
                }
        };
        var keys={"toString":"toString","valueOf":"valueOf"},
        suf="</span>",
        pre='<span class="',
        mid="\">",
        preK=pre+"key"+mid,
        preO=pre+"object"+mid,
        preF=pre+"function"+mid,
        preM=pre+"method"+mid,
        preR=pre+"regexp"+mid,
        preS=pre+"string"+mid,
        preC=pre+"comment"+mid,
        preN=pre+"number"+mid,
        regVar=/\b[a-zA-Z\_\$]\w*?\b/gm,//关键字匹配
        regNum=/((?:^|[^\$]))\b((?:\d*\.?\d+|0x[\da-fA-F]+))\b/g,        //数字匹配
        regBR=/\r?\n/,
        RN="\r\n",
        BR="<br />";
        var A=parse(encoded?code:htmlEncode(code)),N=[],line=1;
        function html(s,pre,suf){
                s=space(s);
                s=pre+s.replace(regBR,suf+RN+pre)+suf;
                return s;
        }
        //统计keys
        loop(A,function(v,i,a){
                v.replace(regVar,function(rr){
                        keys[rr]=rr;
                        return rr;
                });
        },3);
        //分析关键词
        var AK=Keys.key;        //JS保留字
        var AO=Keys.object;        //内置对象、常用对象
        var AF=Keys.func;        //内置函数
        var AM=Keys.method;        //常用对象方法
        for(var x in keys) {
                if(x==AK[x]){
                        keys[x]=preK+x+suf;
                } else if(x==AO[x]){
                        keys[x]=preO+x+suf;
                } else if(x==AF[x]){
                        keys[x]=preF+x+suf;
                } else if(x==AM[x]){
                        keys[x]=preM+x+suf;
                }
        }
        //解决 toString、valueOf 无法标亮
        keys["toString"]=preM+"toString"+suf;
        keys["valueOf"]=preM+"valueOf"+suf;
        //转换为HTML
        loop(A,function(v,i,a){
                var s=v.replace(regVar,function(rr){
                        return keys[rr];
                }).replace(regNum,function(rr,xx,yy){
                        return xx+preN+yy+suf;
                });
                a[i]=space(s);
                var t=a[i+1];
                if(t==2||t==1){
                        a[i+2]=html(a[i+2],preS,suf);
                } else if(t==0){
                        a[i+2]=preR+a[i+2]+suf;
                } else if(t==7){
                        a[i+2]=preC+a[i+2].slice(0,-2)+suf+RN;
                } else if(t==8){
                        a[i+2]=html(a[i+2],preC,suf);
                }
                a[i+1]="";
        },3);
        A=A.join("").replace(/\r\n/g,function(r){
                N.push(line++);
                return BR;
        });
        N.push(line);
        N="<div>"+N.join(BR)+"</div>";
        A="<div>"+A+"</div>";
        A='<table class="jscode" cellspacing="0" cellpadding="0"><tr><td class="no">'+N+'</td><td class="js">'+A+'</td></tr></table>';
        return A;
};
</script>
<style type="text/css">
/*JS语法标亮样式，可自行修改*/
.jscode {border:2px solid #ccffcc;color:#333;}
.jscode td {vertical-align:top;padding:10px;line-height:175%;font-family:Geneva,Arial,sans-serif;font-size:14px;}
.jscode .no {background:#ccffcc;text-align:right;color:#0099cc;}
.jscode .key {color:#00f;}
.jscode .object        {color:#f00;}
.jscode .regexp {background:#9900ff;color:#fff;padding:0 3px;}
/*.jscode .division {color:#ff8080;}*/
.jscode .string        {color:#ff33cc;}
.jscode .function {color:#0099cc;}
.jscode .method {color:#ff9900;}
.jscode .comment {color:#090;}
.jscode .number {color:#ff0000;font-weight:bold;}
</style>
</head>
<body>
<h1>lJSColoration  : Little JavaScript Coloration v2.0</h1>
<p><input type="button" value="源码-完整注释版" onclick="JSColor(document.getElementsByTagName('script')[0].text);" />
<input type="button" value="JS语法案例测试" onclick="JSColor(document.getElementById('Case').value);" />
</p>
<p>请输入JS代码：<br /><textarea id="JS" rows="15" cols="100"></textarea></p>
<p style="display:none;"><textarea id="Case" rows="15" cols="100">
var num=a / /**除法中的释注1**//reg// /**除法中的释注2**/2;
var str="引号"//紧跟在引号后的注释
/**释注**///紧跟在多行注释后的单行释注
var num=/reg//2/*注释夹杂在除法当中*//2/3/5/6/*注释夹杂在除法当中*//7/8/9;
var reg=/reg///我是紧跟在正则后的注释
var num=/**释注**//reg// /**除号的行注释**/2;
var num=/reg/ / /reg/;        //正则除以正则
/*******************************************/
var num=/reg//2/*注释夹杂在除法当中*//2/3/5/6/*注释夹杂在除法当中*//7/8/9;
var reg=/reg///我是紧跟在正则后的注释
var str="绰号"//紧跟在引号后的注释
/**释注**///释注
var xxx=/**释注**//reg// /**除号的行注释**/2;
var num=/reg/ / /reg/ / 2;
//单行注释
/* 多行注释 */
  var toString = Object.prototype.toString ;
  var valueOf = Object.prototype.valueOf ;
  var xxx=null;
var s="";
var reg=/\//g;
var reg=/\///2/*注释*//3/4/5;
/******************* 字符串 *******************/
var a='单引号';
var b='xxx\'xxx\'xxx"xxx"xxxx';
var d="双引号";
var c='+"+"+'+'+\'+\'+'+'+';
var sss="xxx\
        xxx\
        xxx\
        xxx";
var yyy=ss+'xxx\
        xxx\
        xxx\
        xxx';
/******************* 字符串 end *******************/
/******************* 正则 *******************/
var a=100/50+/regx/igm;
var m = 1 - /2,n=2/ -3;        //正则夹杂在减法当中
alert(typeof(/reg/igm));
alert([/reg/igm]);
var a={reg:/reg/igm,method:function(){}};
var b={reg:/reg/igm,_method:function(){}};
var c={reg:/reg/igm,$method:function(){}};
var reg=/reg///我是紧跟在正则后的注释
var reg=/[//]///我仍然是紧跟在正则后的注释
alert(typeof(reg));
var n=1/
/reg/;        //正则用作除数
alert(n);
var reg = /[/][+]([\S\s]*?)(?:[+][/]|$)|[/][/](.*)|"((?:\\"|[^"])*)"|'((?:\\'|[^'])*)'/g;
var num=/reg/ / /reg/;        //正则除以正则
/******************* 除法 *******************/
var num=/reg//2/*注释夹杂在除法当中*//2/3/5/6/*注释夹杂在除法当中*//7/8/9;
alert(typeof(num)+":"+num);
a = 1
b = 2
g = {test:function(){return 1}}
c = a//注释夹杂在除法当中
/*
注释夹杂在除法当中
*/
/b/g.test();         //此行的 /b/g 为连除
alert(c);
/******************* 测试1 *******************/
var point = function(){
    this.x = 1;
    this.y = 2;
    this.valueOf = function(){return 'Point:('+x+','+y+')'};
}
if(c&lt;2)f();
var m = 1/2;n=2/3 //我是除法
var long_divide = long/1/2/3/4/5/6/7/8/'a'/'b'/  //我是吓人的长除法~~~
  line2
var P = new point();
alert(P.valueOf());
var rex_factory = function(){return {x:/re/g,y:/rere/g,z:[/re/,/rere/,/rerere/]}};
/******************* 测试2 *******************/
function f(test) {
    return (test/*
    /* //
    ' "
    { ;
    \*/ && // /* // " ' { ; \
    test &&
    " /* //\" \
    \" ' \
    { ;" &&
    ' /* // \
    " \' \
    { ;' &&
    test);
}
/******************* 测试3 *******************/
// test 1
function myfun(id) {
        /* this is mutilcomments "string" keyword: function */
        var str = "this is a string, /*fasasdf*/ //fdsasdf /^reg/";
        var reg = /^fdadfasdf$/ig;
        return "myvalue"; // hahah
}
//test 2
if(str.match(/(?:(?:[!=(,:]|<\/var>|\[|\n)[ \t]*\/$)|^\n?[\t ]*\/$/)){}
//test 3
a = 1
b = 2
g = {test:function(){return 1}}
c = a//
/*
*/
/b/g.test();
alert(c);
// test 4
function t4(test) {

        return (test/*
        /* //
        ' "
        { ;
        \*/ && // /* // " ' { ; \
        test &&
        " /* // \
        \" ' \
        { ;" &&
        ' /* // \
        " \' \
        { ;' &&
        test);

}
// test 5
var rexT5 = /[/][+]([\S\s]*?)(?:[+][/]|$)|[/][/](.*)|"((?:\\"|[^"])*)"|'((?:\\'|[^'])*)'/g;
/******************* 测试4 *******************/
var chunker = /((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^[\]]*\]|['"][^'"]*['"]|[^[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?/g,
  done = 0,
  toString = Object.prototype.toString;
        for ( var i = 0, l = Expr.order.length; i < l; i++ ) {
                var type = Expr.order[i], match;
                if ( (match = Expr.match[ type ].exec( expr )) ) {
                        var left = RegExp.leftContext;
                        if ( left.substr( left.length - 1 ) !== "\\" ) {
                                match[1] = (match[1] || "").replace(/\\/g, "");
                                set = Expr.find[ type ]( match, context, isXML );
                                if ( set != null ) {
                                        expr = expr.replace( Expr.match[ type ], "" );
                                        break;
                                }
                        }
                }
        }</textarea>
</p>
<p><input type="button" value="开始着色" onclick="JSColor(document.getElementById('JS').value);" /> <input type="button" value="清空代码" onclick="document.getElementById('JS').value='';" /> 本次着色用时<strong id="TIME">0</strong>毫秒</p>
<div id="JS2"></div>
<script type="text/javascript">
var JSColor=function(code){
        document.getElementById("JS").value=code;
        if(code.indexOf("\r\n")<0)code=code.replace(/\n/g,"\r\n");        //非IE下，不含有\r\n
        var color=lJSF.obj.JSParser.color,d;
        d=(new Date()).getTime();
        code=color(code,false);
        d=(new Date()).getTime()-d;
        document.getElementById("JS2").innerHTML=code;
        document.getElementById("TIME").innerHTML=d;
};
var code=document.getElementsByTagName("script")[0].text;
JSColor(code);
</script>
</body>
</html>
```
