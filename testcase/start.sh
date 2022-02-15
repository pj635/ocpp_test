#!/usr/bin/env bash

#cd ..
#pip install -r requirements.txt
#cd testcase

#python -m pip install --upgrade pip || python3 -m pip install --upgrade pip # ����pip����
#pip install -r requirements.txt

rm -rf report  # ɾ����һ�ε�allure����
reprot_path="../report"

# ִ�еĲ���Ŀ¼
array=(01 02 03 04 05 06 07 08 09 10
        11 12 13 14 15 16 17 18 19
        20 21 23 25)


# �޲���ʱ��Ĭ��ִ��ȫ������
if [[ $# -eq 0 ]]; then
  echo "ִ��ȫ������"
  for e in ${array[@]}; do
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path}
  cd ..
  done

# ����ֵΪ1ʱ��ִ�в���Ҫˢ�����Ҳ���Ҫ��ʱ�����е�����
elif [[ $# -eq 1 && $1 -eq 1 ]]; then
  echo "����Ҫˢ����������"
  for e in ${array[@]}; do
  echo "ִ�в���Ҫˢ��������_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card" -m "not need_long_time"
  cd ..
  done

# ����ֵΪ2ʱ��ִ����Ҫˢ��������
elif [[ $# -eq 1 && $1 -eq 2 ]]; then
  echo "��Ҫˢ����������"
  for e in ${array[@]}; do
  echo "ִ����Ҫˢ��������_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_swipe_card"
  cd ..
  done

# ����ֵΪ3ʱ��ִ����Ҫ��ʱ�����е�����
elif [[ $# -eq 1 && $1 -eq 3 ]]; then
  echo "��Ҫˢ����������"
  for e in ${array[@]}; do
  echo "ִ����Ҫˢ��������_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_long_time"
  cd ..
  done

else
  echo "Ĭ�ϣ�û�в�������ִ��ȫ��������"
  echo "1��ִ�в���Ҫˢ�����Ҳ���Ҫ��ʱ�����е�������"
  echo "2��ִ����Ҫˢ����������"
  echo "3��ִ����Ҫ��ʱ�����е�����"
  echo "����ֵ���󣬽ű��˳���"
  exit 1
fi

allure generate report/ -o report/html --clean
allure serve report/ # ����allure �������
exit 0
