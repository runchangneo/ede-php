# 使用 Xdebug 调试

### 在配置文件 `.env` 中, 配置 `xdebug` 扩展,如：
```
PHP82_EXTENSIONS=opcache,xdebug
```

### 重新构建镜像以安装扩展
```
docker compose up -d --build php82
```

### 配置 `xdebug`  
Xdebug v3 和 V2 配置不同  
PHP版本 >= 7.2 时安装的是 Xdebug v3  
PHP版本 <7.2 时安装的是 Xdebug V2   

> 参考文档 [Xdebug PHP Version Support](https://xdebug.org/docs/compat#supported-versions)


> 参考文档 [Xdebug V3 docs](https://xdebug.org/docs)

Xdebug配置信息可以配置在 `php.ini` 或 `docker-php-ext-xdebug.ini` 

对于 Xdebug v3.x.x(php7.2+):
```
[xdebug]
xdebug.mode=debug 
xdebug.start_with_request=yes
xdebug.client_host=${Your_IDE_Host}
xdebug.client_port=${Your_IDE_Port}
```

对于 Xdebug v2.x.x:
```
[xdebug]
xdebug.remote_enable=1
xdebug.remote_autostart=1
xdebug.remote_host=${Your_IDE_Host}
xdebug.remote_port=${Your_IDE_Port}
```

**配置中的变量要替换成自己的**  
配置变量说明：
- `${Your_IDE_Host}`: IDE所在主机host, 在 Linux 系统中可以用下面命令获取:
```
hostname -I
```
- `${Your_IDE_Port}`: IDE Debugger 的端口, 如果不配置的话将使用默认配置:  
  xdebug v3.x.x 默认端口 9003  
  xdebug v2.x.x 默认断就 9000

### 配置完成后重启容器
```
docker compose restart php82
```

### 配置 IDE Debugger
#### `VSCode`  
安装扩展 [PHP Debugger extension](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug)

配置调试器配置，下面是一个配置示例:  
`launch.json`
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": ${Your_IDE_Port},
            "pathMappings": {
                "/www/${workspaceRootFolderName}": "${workspaceFolder}"
            }
        }
    ]
}
```

设置断点,按 `F5` 开始调试
