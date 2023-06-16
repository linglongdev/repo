#!/bin/bash

for pkg in `ls`; do
  # 更新包
  if [ -d "$pkg/.osc" ]; then
    echo $pkg "ok"
    cd $pkg
    osc addremove
    osc status | grep service && osc up && osc commit -m "auto commit"
    cd ..
  # 新增包
  else
    osc mkpac $pkg
    cd $pkg
    osc commit -m "auto commit"
    cd ..
  fi
done

# 删除包
for pkg in `cat .osc/_packages | grep -oP 'package name="\K[^"]*'`; do
  if [ ! -d "$pkg/.osc" ]; then
    osc rdelete linglong:repo:`basename $PWD` $pkg -m "auto commit"
  fi
done

# 更新数据
osc up