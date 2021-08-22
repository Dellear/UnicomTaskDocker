#!/bin/bash
set -e

if [ ! -d /config ]; then
  echo -e "没有映射容器的/config配置到宿主机，请先按教程映射config配置目录...\n"
  exit 1
fi

echo -e "\n========================1. 更新脚本源代码========================\n"
cd ${SCRIPT_DIR}
git fetch --all
git reset --hard origin/${SCRIPT_BRANCH}
# echo -e "因容易封库，先不更新代码了\n"
echo

echo -e "========================2. 检测配置文件========================\n"

if [ ! -s /config/crontab.list ]; then
  echo -e "检测到config配置目录下不存在crontab.list，从脚本中复制一份用于初始化...\n"
  cp -fv ${SCRIPT_DIR}/config/crontab.list /config/crontab.list
  echo -e "成功添加默认定时任务...\n"
fi

if [ ! -s /config/config.json ]; then
  echo -e "检测到config配置目录下不存在config.json，从脚本中复制一份用于初始化...\n"
  cp -fv ${SCRIPT_DIR}/config/config.json /config/config.json
  echo
fi

echo -e "容器启动成功...\n"
echo -e "定时任务如下...\n"
crontab -l
crond -f

exec "$@"
