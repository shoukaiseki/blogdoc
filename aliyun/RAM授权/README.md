# RAM授权


## Resource
例如oss访问权限配置

```
{
	"Version": "1",
		"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"oss:ListObjects",
			"oss:PutObject",
			"oss:GetObject"
			],
			"Resource": [
				"acs:oss:*:*:test-001a", 
			"acs:oss:*:*:test-001a/*"
			]
		}
		]
}
```

"acs:oss:*:*:test-001a"  其中的 test-001a 填写  bucket 名称
