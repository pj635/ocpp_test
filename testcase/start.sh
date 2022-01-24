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

if [[ $# -gt 1 ]]; then
  echo "Ĭ�ϣ�û�в�������ִ��ȫ��������1��ִ����Ҫˢ����������2��ִ�в���Ҫˢ��������"
  echo "�����������󣬽ű��˳���"
  exit 1
fi

# ����ֵΪ1ʱ��ִ����Ҫˢ��������
if [[ $# -eq 0 || $# -eq 1 && $1 -eq 1 ]]; then
  echo "��Ҫˢ����������"
  for e in ${array[@]}; do
  echo "ִ����Ҫˢ��������_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_swipe_card"
  cd ..
  done


# ����ֵΪ2ʱ��ִ�в���Ҫˢ��������
elif [[ $# -eq 0 || $# -eq 1 && $1 -eq 2 ]]; then
  echo "����Ҫˢ����������"
  for e in ${array[@]}; do
  echo "ִ�в���Ҫˢ��������_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card"
  cd ..
  done

else
  echo "Ĭ�ϣ�û�в�������ִ��ȫ��������1��ִ����Ҫˢ����������2��ִ�в���Ҫˢ��������"
  echo "����ֵ���󣬽ű��˳���"
  exit 1
fi

allure generate report/ -o report/html --clean
allure serve report/ # ����allure �������
exit 0
