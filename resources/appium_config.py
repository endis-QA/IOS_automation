"""Appium iOS 설정을 생성하는 헬퍼 함수"""


def get_ios_capabilities():
    """
    iOS 자동화를 위한 Appium capabilities 반환
    
    Returns:
        dict: Appium capabilities 딕셔너리
    """
    from resources.variables import (
        IOS_PLATFORM_NAME,
        IOS_PLATFORM_VERSION,
        IOS_DEVICE_NAME,
        IOS_UDID,
        IOS_BUNDLE_ID,
        IOS_APP_PATH,
        AUTOMATION_NAME,
        NO_RESET,
        FULL_RESET,
        WDA_LOCAL_PORT,
        WDA_BUNDLE_ID,
    )
    
    capabilities = {
        "platformName": IOS_PLATFORM_NAME,
        "platformVersion": IOS_PLATFORM_VERSION,
        "deviceName": IOS_DEVICE_NAME,
        "automationName": AUTOMATION_NAME,
        "bundleId": IOS_BUNDLE_ID,
        "noReset": NO_RESET,
        "fullReset": FULL_RESET,
        # WDA 재사용 옵션: Xcode에서 미리 설치한 WebDriverAgentRunner 사용 (매번 재설치 방지)
        "usePrebuiltWDA": True,  # 기존에 설치된 WDA 사용 (재설치 안 함)
        "useNewWDA": False,  # 새 WDA 세션 생성하지 않음
        "updatedWDABundleId": WDA_BUNDLE_ID,  # WDA Bundle ID 지정
        "showXcodeLog": True,  # 디버깅을 위해 Xcode 로그 표시
        # WDA 연결 안정성 향상
        "wdaStartupRetries": 3,  # WDA 시작 재시도 횟수
        "wdaStartupRetryInterval": 2000,  # 재시도 간격 (ms)
        "newCommandTimeout": 3600,  # 명령 타임아웃 (초)
    }
    
    # UDID가 지정된 경우 추가
    if IOS_UDID:
        capabilities["udid"] = IOS_UDID
    
    # 앱 경로가 지정된 경우 추가 (시뮬레이터용 .app 파일)
    if IOS_APP_PATH:
        capabilities["app"] = IOS_APP_PATH
    
    # WDA 포트 지정 (기본 8100 충돌 시)
    if WDA_LOCAL_PORT:
        capabilities["wdaLocalPort"] = WDA_LOCAL_PORT
    
    return capabilities


