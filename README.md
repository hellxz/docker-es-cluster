# docker-es-cluster

本仓库使用docker-compose构建elasticsearch 7.1.0集群

更多说明详见我的博客<https://www.cnblogs.com/hellxz/p/docker_es_cluster.html>

由于空文件夹提交会被忽略，所以把启动带的日志和连接节点信息也带进来了，使用前需要删除各数据目录下的文件，请保留数据目录和日志目录。

为了对比哪些需要删除，请参考如下目录结构（均需要保留，`.sh`后缀的脚本可以保留）

## 目录结构

```bash
.
├── docker-es-data01
│   ├── data01
│   ├── data01-logs
│   ├── docker-compose.yml
│   ├── .env
│   └── es-config
│       └── elasticsearch.yml
├── docker-es-data02
│   ├── data02
│   ├── data02-logs
│   ├── docker-compose.yml
│   ├── .env
│   └── es-config
│       └── elasticsearch.yml
├── docker-es-data03
│   ├── data03
│   ├── data03-logs
│   ├── docker-compose.yml
│   ├── .env
│   └── es-config
│       └── elasticsearch.yml
├── docker-es-master
│   ├── docker-compose.yml
│   ├── .env
│   ├── es-config
│   │   └── elasticsearch.yml
│   ├── master-data
│   └── master-logs
└── docker-es-tribe
    ├── docker-compose.yml
    ├── .env
    ├── es-config
    │   └── elasticsearch.yml
    ├── tribe-data
    └── tribe-logs
```

## 各目录代表节点与端口号

| 节点目录         | 节点名称 | 协调端口号 | 说明                         | 查询端口号 |
| ---------------- | -------- | ---------- | ---------------------------- | ---------- |
| docker-es-data01 | data01   | 9301       | 数据节点1，非master节点      | 9201       |
| docker-es-data02 | data02   | 9302       | 数据节点2，非master节点      | 9202       |
| docker-es-data03 | data03   | 9303       | 数据节点3，非master节点      | 9203       |
| docker-es-master | master   | 9300       | master节点，非数据节点       | 9200       |
| docker-es-tribe  | tribe    | 9304       | 协调节点，非master非数据节点 | 9204       |

想测试这些节点是否可用，只需要修改**每个**节点目录下的`es-config/elasticsearch.yml`中的ip地址，全部换成你需要的ip即可。

## 各节点操作命令

**后台启动命令**均为`docker-compose up -d`

**关闭命令**:

- `docker-compose down`: 关闭同时移除容器与多余虚拟网卡
- `docker stop contains_name`: 根据容器名称关闭容器，不移除容器

## 简单的脚本

**docker-es-cluster-up.sh**

```bash
#/bin/bash
# please put this shell script to the root of each node folder.
# this shell script for start up the docker-es-cluster designed in the one of linux server.
cd docker-es-master && docker-compose up -d && \
cd ../docker-es-data01 && docker-compose up -d && \
cd ../docker-es-data02 && docker-compose up -d && \
cd ../docker-es-data03 && docker-compose up -d && \
cd ../docker-es-tribe && docker-compose up -d && \
cd ..
```

**docker-es-cluster-down.sh**

```bash
#/bin/bash
# please put this shell script to the root of each node folder.
# this shell script for remove the docker-es-cluster's containers and networks designed in the one of linux server.
cd docker-es-tribe && docker-compose down && \
cd ../docker-es-data03 && docker-compose down && \
cd ../docker-es-data02 && docker-compose down && \
cd ../docker-es-data01 && docker-compose down && \
cd ../docker-es-master && docker-compose down && \
cd ..
```

**docker-es-cluster-stop.sh**

```bash
#/bin/bash
# please put this shell script to the root of each node folder.
# this shell script for stop the docker-es-cluster's containers designed in the one of linux server.
docker stop es-tribe es-data03 es-data02 es-data01 es-master
```

> 如果你想让这些脚本有执行权限，不妨试试`sudo chmod +x *.sh`
>
> 这些脚本中没有使用sudo，如需要使用sudo才能启动docker,请添加当前用户到docker组

**Enjoy.**