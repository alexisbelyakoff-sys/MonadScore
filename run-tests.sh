#!/bin/bash
set -e

cd /workspace

# Запуск виртуального дисплея
Xvfb :99 -screen 0 1366x768x24 & sleep 3

# Старт записи экрана
ffmpeg -y -video_size 1366x768 -framerate 15 -f x11grab -i :99 \
  -codec:v libx264 -pix_fmt yuv420p screen_recording.mp4 > /dev/null 2>&1 & echo $! > ffmpeg_pid.txt

# Запуск Maven-тестов
mvn -B clean test -Dgroups=Second -DsuiteXmlFile='src/test/resources/StartNodes.xml' \
    -DPASSWORD="$DPASSWORD" -DPIN="$DPIN" \
    -DSEED_PHRASE_10="$DSEED_PHRASE_10" -DEMAIL_10="$DEMAIL_10" \
    -DSEED_PHRASE_9="$DSEED_PHRASE_9" -DEMAIL_9="$DEMAIL_9" \
    -DSEED_PHRASE_8="$DSEED_PHRASE_8" -DEMAIL_8="$DEMAIL_8" \
    -DSEED_PHRASE_7="$DSEED_PHRASE_7" -DEMAIL_7="$DEMAIL_7" \
    -DSEED_PHRASE_6="$DSEED_PHRASE_6" -DEMAIL_6="$DEMAIL_6" \
    -DSEED_PHRASE_5="$DSEED_PHRASE_5" -DEMAIL_5="$DEMAIL_5" \
    -DSEED_PHRASE_4="$DSEED_PHRASE_4" -DEMAIL_4="$DEMAIL_4" \
    -DSEED_PHRASE_3="$DSEED_PHRASE_3" -DEMAIL_3="$DEMAIL_3" \
    -DSEED_PHRASE_2="$DSEED_PHRASE_2" -DEMAIL_2="$DEMAIL_2" \
    -DSEED_PHRASE_1="$DSEED_PHRASE_1" -DEMAIL_1="$DEMAIL_1" \
    -DSEED_PHRASE_0="$DSEED_PHRASE_0" -DEMAIL_0="$DEMAIL_0"

# Остановка записи
kill -INT $(cat ffmpeg_pid.txt) && sleep 2

# Сохраняем видео для Allure
mkdir -p target/allure-results
cp screen_recording.mp4 target/allure-results/
