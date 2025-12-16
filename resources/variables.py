# iOS 테스트를 위한 변수 설정
import os

# Appium 서버 설정
APPIUM_SERVER_URL = "http://localhost:4723"

# iOS 디바이스 설정
IOS_PLATFORM_NAME = "iOS"
IOS_PLATFORM_VERSION = "17.4.1"  # 사용하는 iOS 버전에 맞게 수정
IOS_DEVICE_NAME = "iPhone 14 pro"  # 테스트할 디바이스 이름에 맞게 수정
IOS_UDID = "00008120-001119160168C01E"  # 특정 디바이스 UDID가 필요한 경우 입력

# 앱 설정
# ⚠️ 중요: 테스트하려는 앱의 Bundle ID를 넣어야 합니다!
# WebDriverAgentRunner는 Appium 시스템 앱이므로 사용하지 마세요.

# 방법 1: 이미 설치된 앱 테스트 (권장) - Bundle ID만 설정
# 실제 테스트할 앱의 Bundle ID를 입력하세요
# 
# ⚠️ Bundle ID 확인 방법:
# 1. Xcode: Cmd+Shift+2 → Devices → Installed Apps → Flo 앱 → Bundle Identifier
# 2. 터미널: ./install_and_check_bundle_id.sh 실행
# 3. 또는 테스트 실행 후 오류 메시지에서 확인
#
# 일반적인 Flo 앱 Bundle ID 후보:
# - com.dreamus.flo
# - com.dreamusqa.flo
# - com.dreamus.flo.player
IOS_BUNDLE_ID = "kr.co.musicmates.radio"  # 디바이스에 이미 설치된 테스트 앱의 Bundle ID (여기에 올바른 값 입력)
IOS_APP_PATH = ""  # 비워두기 (이미 설치된 앱을 사용할 경우)

# 방법 2: 앱 파일로 새로 설치하고 테스트 - App Path 설정
# IOS_BUNDLE_ID = ""  # 비워두기
# IOS_APP_PATH = "/Users/denny_share01/apps/Flo.app"  # 시뮬레이터용 .app 파일 경로
# 또는
# IOS_APP_PATH = "/Users/denny_share01/apps/Flo.ipa"  # 실제 디바이스용 .ipa 파일 경로

# 기타 설정
AUTOMATION_NAME = "XCUITest"
NO_RESET = True  # 앱 재설치 없이 데이터 유지
FULL_RESET = False  # 앱을 완전히 삭제하고 다시 설치

# WebDriverAgent 설정
# Xcode 의 `WebDriverAgentRunner` 타겟의 Bundle Identifier 와 동일해야 합니다.
WDA_BUNDLE_ID = "com.facebook.WebDriverAgentRunner"
# WDA가 사용할 포트 (기본 8100, 충돌 시 다른 값으로 변경)
WDA_LOCAL_PORT = 8101

# 타임아웃 설정
IMPLICIT_TIME_OUT = 10
EXPLICIT_TIME_OUT = 30

