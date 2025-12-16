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
        # WDA 자동 시작 옵션: Appium이 자동으로 WDA를 빌드하고 시작
        "usePrebuiltWDA": False,  # Appium이 자동으로 WDA 빌드 및 시작
        "useNewWDA": True,  # 매번 새로운 WDA 세션 생성 (안정성 향상)
        "updatedWDABundleId": WDA_BUNDLE_ID,  # WDA Bundle ID 지정
        "showXcodeLog": True,  # 디버깅을 위해 Xcode 로그 표시
        # WDA 연결 안정성 향상
        "wdaStartupRetries": 5,  # WDA 시작 재시도 횟수 증가
        "wdaStartupRetryInterval": 3000,  # 재시도 간격 증가 (ms)
        "newCommandTimeout": 3600,  # 명령 타임아웃 (초)
        # Xcode 서명 정보 (필요시 주석 해제)
        # "xcodeOrgId": "YOUR_TEAM_ID",  # Xcode Team ID (8자리 문자열)
        # "xcodeSigningId": "iPhone Developer",  # Signing ID
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


