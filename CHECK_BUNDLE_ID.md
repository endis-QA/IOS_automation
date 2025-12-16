# Bundle ID 확인 방법

## 1. 실제 디바이스에서 Bundle ID 확인

### 방법 A: iOS 디바이스 연결 후 확인
```bash
# 연결된 디바이스 목록 확인
instruments -s devices

# 설치된 앱 목록 확인 (Xcode 필요)
ideviceinstaller -u [UDID] -l
```

### 방법 B: Xcode Organizer 사용
1. Xcode 실행
2. Window → Devices and Simulators
3. 연결된 디바이스 선택
4. Installed Apps에서 앱 선택
5. Bundle Identifier 확인

### 방법 C: iOS 설정 앱에서 확인
1. 설정 → 일반 → VPN 및 기기 관리 (또는 프로파일)
2. 앱 정보에서 확인

## 2. 시뮬레이터에서 Bundle ID 확인

```bash
# 시뮬레이터에 설치된 앱 확인
xcrun simctl listapps booted | grep -i flo

# 또는 특정 시뮬레이터에서
xcrun simctl listapps [UDID] | grep -i flo
```

## 3. .app 파일에서 Bundle ID 확인

### Mac에서 확인
```bash
# 앱 패키지 내용 보기
defaults read /path/to/YourApp.app/Contents/Info.plist CFBundleIdentifier

# 또는
/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" /path/to/YourApp.app/Contents/Info.plist
```

### Xcode에서 확인
1. .app 파일을 Xcode에서 열기
2. Info.plist 파일 확인
3. `CFBundleIdentifier` 또는 `Bundle Identifier` 확인

## 4. .ipa 파일에서 Bundle ID 확인

```bash
# .ipa 파일 압축 해제 (실제로는 .zip 파일)
unzip -q YourApp.ipa

# Info.plist 확인
defaults read Payload/YourApp.app/Info.plist CFBundleIdentifier
```

## 5. 현재 설치된 Flo 앱 Bundle ID 확인 (예상)

Flo 앱의 일반적인 Bundle ID:
- `com.dreamus.flo` (현재 설정값)
- 또는 `com.dreamus.flo.player` 등 변형이 있을 수 있음

정확한 Bundle ID 확인을 위해:
```bash
# 실제 디바이스에서 (libimobiledevice 설치 필요)
ideviceinstaller -u 00008120-001119160168C01E -l | grep -i flo

# 시뮬레이터에서
xcrun simctl listapps booted | grep -i "dreamus\|flo"
```

## App Path 확인 방법

### .app 파일 경로 (시뮬레이터용)
- Xcode에서 빌드한 경우: `~/Library/Developer/Xcode/DerivedData/[프로젝트명]/Build/Products/Debug-iphonesimulator/[앱이름].app`
- 또는 직접 빌드한 경로

### .ipa 파일 경로 (실제 디바이스용)
- 다운로드한 .ipa 파일의 전체 경로
- 예: `/Users/denny_share01/downloads/Flo.ipa`


