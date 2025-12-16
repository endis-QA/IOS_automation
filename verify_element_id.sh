#!/bin/bash

# 요소 ID 검증 스크립트

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}마케팅 팝업 요소 ID 검증${NC}"
echo ""

# Appium 서버 확인
if ! curl -s http://localhost:4723/status > /dev/null; then
    echo -e "${RED}❌ Appium 서버가 실행 중이지 않습니다.${NC}"
    echo -e "${YELLOW}다음 명령으로 Appium 서버를 시작하세요: appium${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Appium 서버 연결 확인${NC}"
echo ""

# 요소 ID 검증 테스트 실행
echo -e "${YELLOW}요소 ID 검증 테스트 실행 중...${NC}"
python3 -m robot tests/verify_popup_element.robot

# 결과 확인
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ 검증 완료!${NC}"
    echo ""
    echo "결과 확인:"
    echo "  - report.html: 테스트 결과 리포트"
    echo "  - log.html: 상세 로그 및 화면 소스"
    echo "  - popup_verification_result.png: 스크린샷"
else
    echo ""
    echo -e "${YELLOW}⚠️ 검증 중 오류가 발생했습니다.${NC}"
    echo "log.html에서 상세 내용을 확인하세요."
fi


