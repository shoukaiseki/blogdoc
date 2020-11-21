# ajax提交from表单额外增加属性


```javascript
var data = $("#form-productionorder-add").serializeArray();

data.push({"name": "id", "value": "1"});

var config = {
	url: "/add",
	 type: "post",
	 dataType: "json",
	 data: data,
	 beforeSend: function () {
		 $.modal.loading("正在处理中，请稍后...");
		 $.modal.disable();
	 },
	success: function(result) {
		 if (typeof callback == "function") {
			 callback(result);
		 }
		 $.operate.successCallback(result);
	 }
};
$.ajax(config)

```
