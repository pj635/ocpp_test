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
        20 21 23 25 51 52)


# �޲���ʱ��Ĭ��ִ��ȫ������
if [[ $# -eq 0 ]]; then
  # ��ִ�а��Զ�������
  for e in ${array[@]}; do
  echo "ִ����Ҫˢ��������_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_swipe_card or need_power_down and not socket"
  cd ..
  done
  # ��ִ���Զ�������
  for e in ${array[@]}; do
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card and not socket not need_power_down"
  cd ..
  done

# ����ֵΪ0ʱ��ִ�в���Ҫˢ������Ҫ���粢�Ҳ���Ҫsocket׮������(ִ���Զ�������)
elif [[ $# -eq 1 && $1 -eq 0 ]]; then
  for e in ${array[@]}; do
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card and not socket and not need_power_down"
  cd ..
  done

# ����ֵΪ1ʱ��ִ�в���Ҫˢ������Ҫsocket׮����Ҫ���粢�Ҳ���Ҫ��ʱ�����в���Ҫsocket׮������
elif [[ $# -eq 1 && $1 -eq 1 ]]; then
  echo "����Ҫˢ����������"
  for e in ${array[@]}; do
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "not need_swipe_card and not need_long_time and not socket not need_power_down"
  cd ..
  done

# ����ֵΪ2ʱ��ִ����Ҫˢ������Ҫ���������(ִ�а��Զ�������)
elif [[ $# -eq 1 && $1 -eq 2 ]]; then
  for e in ${array[@]}; do
  echo "ִ����Ҫˢ��������_$e"
  cd test_2_${e}*
  pytest test*.py --alluredir ${reprot_path} -m "need_swipe_card or need_power_down"
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
  echo "1��ִ�в���Ҫˢ��,����Ҫ��ʱ������,����Ҫsocket׮��������"
  echo "2��ִ����Ҫˢ����������"
  echo "3��ִ����Ҫ��ʱ�����е�����"
  echo "����ֵ���󣬽ű��˳���"
  exit 1
fi

allure generate report/ -o report/html --clean
allure serve report/ # ����allure �������
exit 0
