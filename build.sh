#!/bin/bash
# 本地构建时可以使用该脚本

docker build -t mufeng3421/leaf-server .

docker image prune -f

echo build success!