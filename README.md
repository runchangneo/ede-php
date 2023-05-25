# Easy Development Environment - PHP
容易搭建的开发环境 - PHP
- Docker
- PHP 

| PHP版本 | 支持 |
| -- | -- |
| 5.6 | &check; |
| 7.0 | &check; |
| 7.1 | &check; |
| 7.2 | &check; |
| 7.3 | &check; |
| 7.4 | &check; |
| 8.0 | &check; |
| 8.1 | &check; |
| 8.2 | &check; |

## 使用说明
### 先创建一个 `dev` 网络，所有服务都加入同一网络下便于容器互通
```
docker network create dev
```

### 配置文件
复制 `.env.example` 命名为 `.env`
```
cp .env.example .env
```
根据需要修改 `.env` 里的配置

支持的PHP扩展参考: [support extensions](./docs/support_extensions)

### 启动容器
启动一个容器 php v8.2.x
```
docker compose up -d php82
```
启动所有容器
```
docker compose up -d
```

## 使用 Xdebug 调试
参考 [xdebug usage](./docs/debug.md)
