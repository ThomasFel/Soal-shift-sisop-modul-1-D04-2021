#!/bin/bash

# SOAL 1A
listLog=$(grep -o "ticky.*" syslog.log | cut -f -2)

# echo $listLog

# SOAL 1B
listError=$(grep -o "ERROR.*" syslog.log | cut -d " " -f 2- | cut -d "(" -f 1 | sort -V | uniq -c | sort -n -r)

# echo $listError

#SOAL 1C
userError=$(grep -o "ERROR.*" syslog.log | cut -f 2- -d"(" | cut -d ")" -f 1 | sort | uniq -c | sort -n)
userInfo=$(grep -o "INFO.*" syslog.log | cut -f 2- -d"(" | cut -d ")" -f 1 | sort | uniq -c | sort -n)

# echo $userError
# echo $userInfo

#SOAL 1D
listUser=$(cut -d"(" -f 2 < syslog.log | cut -d ")" -f 1 | sort | uniq)

echo "Error,Count" > error_message.csv
echo "$listError" | while read errors

do
    errorName=$(echo $errors | cut -d " " -f 2-)
    errorTotal=$(echo $errors | cut -d " " -f 1)
    echo "$errorName,$errorTotal" >> error_message.csv
done

#SOAL 1E
echo "Username,INFO,ERROR" > user_statistic.csv
echo "$listUser" | while read users

do
    totalUserError=$(grep --count "ERROR.*($users)" syslog.log)
    totalUserInfo=$(grep --count "INFO.*($users)" syslog.log)
    echo "$users,$totalUserInfo,$totalUserError" >> user_statistic.csv
done
