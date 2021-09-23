# UnicomTaskDocker

### 必要条件
#### 需要映射容器的 `/config` 目录到宿主机。
### 使用方法
#### docker
```bash
docker run -itd \
  -v $PWD/config:/config \
  --name unicom-task \
  --restart always \
  dellear/unicom-task
```

#### docker-compose

```bash
version: "2.2"
services:
  unicom-task:
    image: dellear/unicom-task
    container_name: unicom-task
    hostname: unicom-task
    restart: always
    tty: true
    network_mode: bridge  #如果网络不正常，可以改成host
    volumes:
      - ./config:/config
```

### 特别说明
#### 此docker是针对[unicom-task](https://github.com/srcrs/unicom-task.git)的封装，降低使用难度，开箱即用。
#### 容器启动后，需要修改`$PWD/config/config.json`文件为你的信息。
#### `$PWD/config/crontab.list`建议只修改定时，不建议修改执行命令。默认容器启动时已启动cron，无需进行额外操作。
