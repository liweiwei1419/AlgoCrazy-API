#!/bin/bash

# 脚本名称：deploy_algocrazy.sh
# 功能：打包并部署 algo-crazy-api 到远程服务器
# 使用方法：./deploy_algocrazy.sh

# 设置变量
JAR_NAME="algo-crazy-api-0.0.1-SNAPSHOT.jar"
LOCAL_TARGET_DIR="./target"
REMOTE_SERVER="dance8.fun"
REMOTE_DIR="/root/springboot-projects/algocrazy"
SSH_USER="root"  # 根据实际情况修改用户名
RUN_SCRIPT="run.sh"  # 远程服务器上的启动脚本

# 1. 执行 Maven 打包（跳过测试）
echo "正在执行 Maven 打包（跳过测试）..."
mvnd clean package -DskipTests

if [ $? -ne 0 ]; then
    echo "Maven 打包失败，请检查错误"
    exit 1
fi

# 检查生成的 JAR 文件是否存在
if [ ! -f "$LOCAL_TARGET_DIR/$JAR_NAME" ]; then
    echo "错误：找不到打包生成的 JAR 文件: $LOCAL_TARGET_DIR/$JAR_NAME"
    exit 1
fi

# 2. 上传 JAR 文件到远程服务器
echo "正在上传 JAR 文件到远程服务器..."
scp "$LOCAL_TARGET_DIR/$JAR_NAME" "$SSH_USER@$REMOTE_SERVER:$REMOTE_DIR/"

if [ $? -ne 0 ]; then
    echo "文件上传失败"
    exit 1
fi

# 3. 执行远程服务器上的 run.sh 脚本
echo "正在远程执行启动脚本 $RUN_SCRIPT..."
ssh "$SSH_USER@$REMOTE_SERVER" "cd $REMOTE_DIR && chmod +x $RUN_SCRIPT && ./$RUN_SCRIPT"

if [ $? -ne 0 ]; then
    echo "远程启动脚本执行失败"
    exit 1
fi

echo "部署成功完成！"
echo "JAR 文件已上传到: $REMOTE_SERVER:$REMOTE_DIR/$JAR_NAME"
echo "并已执行启动脚本: $REMOTE_DIR/$RUN_SCRIPT"