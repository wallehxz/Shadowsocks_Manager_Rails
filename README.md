基于 ruby on rails 开发的 ShadowSocks 翻墙后台数据管理

主要功能：

1、自定义配置文件路径

2、服务器端配置参数定义

3、多账户后台管理

4、当前活动链接数展示

5、设置好参数后，可以一键部署即可

安装说明：

由于 shadowsocks 是系统级命令，所以项目需要部署到 root 用户目录下

否则会导致配置的参数无法写入到系统里面

部署说明：

1、编辑 /config/online.rb 文件服务器信息
2、上传服务器配置
```
cap online puma:config
```
3、部署代码
```
cap online deploy
```

转载说明：

欢迎大家使用，转载请标明出处。
ruby on rails service for you ：）