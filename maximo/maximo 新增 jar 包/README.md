# maximo 新增 jar 包

例如新增 pinyin4j-2.5.0.jar ,在webloigc中直接放到 maximo.ear/lib 目录下即可以了的,但是websphere是无法生效,需要在 businessobjects.jar\META-INF\MANIFEST.MF 修改,在该文件最后添加 lib/pinyin4j-2.5.0.jar 后重启服务即可
