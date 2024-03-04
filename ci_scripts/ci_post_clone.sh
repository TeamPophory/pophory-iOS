#!/bin/sh

#  ci_post_clone.sh
#  pophory-iOS
#
#  Created by 강윤서 on 3/4/24.
#

# *.xconfig 파일이 생성될 폴더 경로
FOLDER_PATH="/Volumes/workspace/repository/pophory-iOS"

# PARTS 배열의 두 번째 요소가 "Scheme Name"에 해당
IFS='-' read -ra PARTS <<< "$CI_XCODE_SCHEME"

# *.xconfig 파일 이름
CONFIG_FILENAME="${PARTS[1]}.xcconfig"

# *.xconfig 파일의 전체 경로 계산
CONFIG_FILE_PATH="$FOLDER_PATH/$CONFIG_FILENAME"

# 환경 변수에서 값을 가져와서 *.xconfig 파일에 추가하기
echo "BASE_URL = $BASE_URL" >> "$CONFIG_FILE_PATH"
echo "UNIT_AD_ID = $UNIT_AD_ID" >> "$CONFIG_FILE_PATH"
echo "SENTRY_DSN = $SENTRY_DSN" >> "$CONFIG_FILE_PATH"
echo "ADMOB_APP_ID = $ADMOB_APP_ID" >> "$CONFIG_FILE_PATH"

# 생성된 *.xconfig 파일 내용 출력
cat "$CONFIG_FILE_PATH"

echo "${PARTS[1]}.xcconfig 파일이 성공적으로 생성되었고, 환경변수 값이 확인되었습니다."
