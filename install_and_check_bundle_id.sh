#!/bin/bash

# libimobiledevice 설치 및 Bundle ID 확인 스크립트

echo "========================================="
echo "libimobiledevice 설치 및 Bundle ID 확인"
echo "========================================="
echo ""

# libimobiledevice 설치 확인
if ! command -v ideviceinstaller &> /dev/null; then
    echo "libimobiledevice가 설치되어 있지 않습니다."
    echo "설치를 시작합니다..."
    echo ""
    
    if command -v brew &> /dev/null; then
        brew install libimobiledevice
    else
        echo "❌ Homebrew가 설치되어 있지 않습니다."
        echo "먼저 Homebrew를 설치해주세요: https://brew.sh"
        exit 1
    fi
else
    echo "✅ libimobiledevice가 이미 설치되어 있습니다."
    echo ""
fi

# 디바이스 확인
UDID="00008120-001119160168C01E"
echo "디바이스 연결 확인 중... (UDID: $UDID)"
echo ""

# 설치된 앱 목록 확인
echo "설치된 앱 목록 확인 중..."
echo "========================================="
ideviceinstaller -u $UDID -l | grep -i -E "dreamus|flo" || echo "Flo 관련 앱을 찾지 못했습니다. 전체 목록을 확인합니다..."
echo ""

echo "전체 설치된 앱 목록:"
echo "========================================="
ideviceinstaller -u $UDID -l
echo ""
echo "========================================="
echo "위 목록에서 'Flo' 또는 'dreamus'가 포함된 앱을 찾으세요."
echo "형식: com.회사명.앱이름"


