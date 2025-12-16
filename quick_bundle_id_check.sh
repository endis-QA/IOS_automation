#!/bin/bash

# 빠른 Bundle ID 확인 스크립트

echo "========================================="
echo "Bundle ID 확인 방법"
echo "========================================="
echo ""

echo "🔍 방법 1: Xcode Organizer 사용 (가장 확실함)"
echo "1. Xcode 실행"
echo "2. 단축키: Cmd + Shift + 2 (또는 Window → Devices and Simulators)"
echo "3. 왼쪽에서 'iPhone (17.4.1)' 선택"
echo "4. 'Installed Apps' 버튼 클릭"
echo "5. Flo 앱 찾기 → 선택"
echo "6. 'Bundle Identifier' 복사"
echo ""

echo "🔍 방법 2: libimobiledevice 설치 후 확인"
echo "다음 명령어로 설치하고 확인:"
echo "  brew install libimobiledevice"
echo "  ideviceinstaller -u 00008120-001119160168C01E -l | grep -i flo"
echo ""

echo "🔍 방법 3: 테스트 실행 시 오류 메시지 확인"
echo "일단 'com.dreamus.flo'로 설정하고 테스트를 실행해보세요."
echo "잘못된 Bundle ID면 Appium이 오류 메시지와 함께"
echo "사용 가능한 앱 목록을 보여줄 수 있습니다."
echo ""

echo "💡 일반적인 Flo 앱 Bundle ID 후보:"
echo "  - com.dreamus.flo"
echo "  - com.dreamusqa.flo"
echo "  - com.dreamus.flo.player"
echo ""

echo "========================================="


