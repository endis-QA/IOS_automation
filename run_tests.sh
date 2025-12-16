#!/bin/bash

# iOS 자동화 테스트 실행 스크립트

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}iOS 자동화 테스트 시작${NC}"

# 가상환경 활성화 (있는 경우)
if [ -d "venv" ]; then
    echo -e "${GREEN}가상환경 활성화 중...${NC}"
    source venv/bin/activate
fi

# Appium 서버 확인
echo -e "${YELLOW}Appium 서버 상태 확인 중...${NC}"
if ! curl -s http://localhost:4723/status > /dev/null; then
    echo -e "${YELLOW}경고: Appium 서버가 실행 중이지 않습니다.${NC}"
    echo -e "${YELLOW}다음 명령으로 Appium 서버를 시작하세요: appium${NC}"
    read -p "계속하시겠습니까? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 테스트 실행 (실패해도 모든 테스트 실행)
echo -e "${GREEN}테스트 실행 중... (실패해도 모든 테스트 실행)${NC}"
python3 -m robot tests/test_suite.robot

# 테스트 결과 확인
if [ $? -eq 0 ]; then
    echo -e "${GREEN}테스트 완료!${NC}"
else
    echo -e "${YELLOW}일부 테스트가 실패했습니다.${NC}"
fi

