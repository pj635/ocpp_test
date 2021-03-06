#!/usr/bin/env bash

#cd ..
#pip install -r requirements.txt
#cd testcase

#python -m pip install --upgrade pip || python3 -m pip install --upgrade pip # 更新pip工具
#pip install -r requirements.txt

rm -rf report  # 删除上一次的allure报告
reprot_path="../report"

# 执行的测试目录
array=(01 02 03 04 05 06 07 08 09 10
        11 12 13 14 15 16 17 18 19
        20 21 23 25 51 52)


# 无参数时，默认执行全量用例
if [[ $# -eq 0 ]]; then
  # 先执行半自动化用例
  for e in ${array[@]}; do
  echo "执行需要刷卡测试套_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_swipe_card or need_power_down and not socket"
  cd ..
  done
  # 再执行自动化用例
  for e in ${array[@]}; do
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card and not socket not need_power_down"
  cd ..
  done

# 参数值为0时，执行不需要刷卡不需要掉电并且不需要socket桩的用例(执行自动化用例)
elif [[ $# -eq 1 && $1 -eq 0 ]]; then
  for e in ${array[@]}; do
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card and not socket and not need_power_down"
  cd ..
  done

# 参数值为1时，执行不需要刷卡不需要socket桩不需要掉电并且不需要长时间运行不需要socket桩的用例
elif [[ $# -eq 1 && $1 -eq 1 ]]; then
  echo "不需要刷卡测试用例"
  for e in ${array[@]}; do
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card and not need_long_time and not socket not need_power_down"
  cd ..
  done

# 参数值为2时，执行需要刷卡和需要掉电的用例(执行半自动化用例)
elif [[ $# -eq 1 && $1 -eq 2 ]]; then
  for e in ${array[@]}; do
  echo "执行需要刷卡测试套_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_swipe_card or need_power_down"
  cd ..
  done

# 参数值为3时，执行需要长时间运行的用例
elif [[ $# -eq 1 && $1 -eq 3 ]]; then
  echo "需要刷卡测试用例"
  for e in ${array[@]}; do
  echo "执行需要刷卡测试套_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_long_time"
  cd ..
  done

else
  echo "默认（没有参数）：执行全量用例；"
  echo "1：执行不需要刷卡,不需要长时间运行,不需要socket桩的用例；"
  echo "2：执行需要刷卡的用例；"
  echo "3：执行需要长时间运行的用例"
  echo "参数值错误，脚本退出！"
  exit 1
fi

allure generate report/ -o report/html --clean
allure serve report/ # 生成allure 报告服务
exit 0
