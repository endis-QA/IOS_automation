#!/usr/bin/env python3
"""
iOS 디바이스에 설치된 앱의 Bundle ID를 찾는 스크립트
"""

import subprocess
import sys
import re

def run_command(cmd):
    """명령어 실행 후 결과 반환"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=30)
        return result.stdout.strip(), result.stderr.strip(), result.returncode
    except subprocess.TimeoutExpired:
        return "", "명령어 실행 시간 초과", 1
    except Exception as e:
        return "", str(e), 1

def find_bundle_id_method1():
    """방법 1: ideviceinstaller 사용 (libimobiledevice 필요)"""
    print("\n=== 방법 1: ideviceinstaller 사용 ===")
    print("실제 디바이스에 설치된 앱 목록을 확인합니다...\n")
    
    # 디바이스 UDID
    udid = "00008120-001119160168C01E"
    
    cmd = f"ideviceinstaller -u {udid} -l"
    stdout, stderr, code = run_command(cmd)
    
    if code == 0 and stdout:
        print(stdout)
        print("\n위 목록에서 Flo 앱을 찾아보세요.")
        print("형식: com.회사명.앱이름")
        return True
    else:
        print("❌ ideviceinstaller를 사용할 수 없습니다.")
        print("설치하려면: brew install libimobiledevice")
        return False

def find_bundle_id_method2():
    """방법 2: Xcode Organizer 안내"""
    print("\n=== 방법 2: Xcode Organizer 사용 ===")
    print("가장 확실한 방법입니다:\n")
    print("1. Xcode 실행")
    print("2. Window → Devices and Simulators (또는 Cmd+Shift+2)")
    print("3. 왼쪽에서 연결된 디바이스 선택 (iPhone 14 pro)")
    print("4. 'Installed Apps' 섹션 클릭")
    print("5. Flo 앱 찾기 → 선택")
    print("6. Bundle Identifier 복사\n")
    return True

def find_bundle_id_method3():
    """방법 3: 시뮬레이터에서 확인"""
    print("\n=== 방법 3: 시뮬레이터에서 확인 ===")
    print("시뮬레이터에 설치된 앱을 확인합니다...\n")
    
    cmd = "xcrun simctl listapps booted | grep -i -A 5 'dreamus\|flo'"
    stdout, stderr, code = run_command(cmd)
    
    if code == 0 and stdout:
        print(stdout)
        print("\n위에서 CFBundleIdentifier 값을 찾으세요.")
        return True
    else:
        print("❌ 시뮬레이터가 실행 중이지 않거나 앱이 설치되지 않았습니다.")
        return False

def find_bundle_id_method4():
    """방법 4: iOS 설정 앱에서 확인"""
    print("\n=== 방법 4: iOS 디바이스에서 직접 확인 ===")
    print("(정확한 Bundle ID는 아니지만 앱 이름 확인 가능)\n")
    print("1. iOS 디바이스에서 '설정' 앱 열기")
    print("2. '일반' → 'VPN 및 기기 관리' (또는 '프로파일 및 기기 관리')")
    print("3. 설치된 앱 목록에서 Flo 앱 찾기")
    print("4. 앱 정보 확인\n")
    return True

def find_bundle_id_method5():
    """방법 5: 앱스토어 URL에서 확인"""
    print("\n=== 방법 5: App Store URL에서 확인 ===")
    print("App Store에서 Flo 앱 페이지를 열면 URL에 ID가 있습니다:\n")
    print("예: https://apps.apple.com/app/id123456789")
    print("App ID는 Bundle ID와 다를 수 있지만 참고 가능합니다.\n")
    return True

def suggest_common_bundle_ids():
    """일반적인 Bundle ID 제안"""
    print("\n=== 일반적인 Flo 앱 Bundle ID (참고용) ===")
    print("아래 중 하나일 가능성이 높습니다:\n")
    
    common_ids = [
        "com.dreamus.flo",
        "com.dreamusqa.flo",
        "com.dreamus.flo.player",
        "com.dreamusqa.flo.player",
        "com.dreamus.Flo",
        "com.dreamusqa.Flo",
    ]
    
    for idx, bid in enumerate(common_ids, 1):
        print(f"{idx}. {bid}")
    
    print("\n⚠️ 정확한 Bundle ID는 위 방법들로 확인하는 것이 좋습니다.\n")

def main():
    print("=" * 60)
    print("iOS 앱 Bundle ID 찾기 도구")
    print("=" * 60)
    
    methods = [
        find_bundle_id_method1,
        find_bundle_id_method2,
        find_bundle_id_method3,
        find_bundle_id_method4,
        find_bundle_id_method5,
    ]
    
    for method in methods:
        method()
        print("-" * 60)
    
    suggest_common_bundle_ids()
    
    print("\n💡 권장: 방법 2 (Xcode Organizer)가 가장 확실합니다!")
    print("=" * 60)

if __name__ == "__main__":
    main()


