# Bundle ID 설정 가이드

## ⚠️ 중요: WebDriverAgentRunner는 사용하지 마세요!

`com.dreamusqa.WebDriverAgentRunner`는 **WebDriverAgentRunner**의 Bundle ID입니다.
- 이것은 Appium이 iOS 디바이스를 제어하기 위해 사용하는 **시스템 앱**입니다
- **실제로 테스트할 앱의 Bundle ID가 아닙니다!**
- Xcode에서 WebDriverAgent 프로젝트를 열어본 경우 보이는 Bundle ID일 수 있으나, 테스트 앱용이 아닙니다

## 올바른 Bundle ID 찾는 방법

### 방법 1: Xcode에서 테스트 앱 프로젝트 확인 (권장)

테스트하려는 **Flo 앱**의 Xcode 프로젝트를 열어 확인:

1. Xcode에서 Flo 앱 프로젝트 열기
2. 프로젝트 네비게이터에서 프로젝트 선택
3. TARGETS에서 앱 타겟 선택
4. **General** 탭 → **Identity** 섹션
5. **Bundle Identifier** 확인

일반적인 Flo 앱 Bundle ID:
- `com.dreamus.flo`
- `com.dreamus.flo.player`
- 또는 프로젝트에 따라 다른 값

### 방법 2: 실제 디바이스에서 확인

Xcode Organizer 사용:
1. Xcode 실행
2. **Window** → **Devices and Simulators**
3. 연결된 디바이스 선택 (UDID: 00008120-001119160168C01E)
4. **Installed Apps** 섹션에서 Flo 앱 찾기
5. 앱 선택 → **Bundle Identifier** 확인

### 방법 3: 앱스토어에서 다운로드한 앱

앱스토어에서 설치한 경우:
- 일반적으로 `com.dreamus.flo` 또는 `com.dreamusqa.flo` 형태
- 정확한 값은 위 방법으로 확인 필요

### 방법 4: 터미널로 확인 (libimobiledevice 설치 시)

```bash
# libimobiledevice 설치 (Homebrew)
brew install libimobiledevice

# 설치된 앱 목록 확인
ideviceinstaller -u 00008120-001119160168C01E -l | grep -i flo
```

## 설정 예시

### 올바른 설정 (Flo 앱 테스트)

```python
IOS_BUNDLE_ID = "com.dreamus.flo"  # Flo 앱의 실제 Bundle ID
IOS_APP_PATH = ""  # 비워두기
```

### 잘못된 설정 (사용하지 마세요!)

```python
IOS_BUNDLE_ID = "com.dreamusqa.WebDriverAgentRunner"  # ❌ 잘못됨!
```

## 확인 체크리스트

- [ ] Xcode에서 **테스트할 Flo 앱 프로젝트**를 열었나요? (WebDriverAgent 프로젝트가 아님!)
- [ ] Bundle ID가 `com.dreamus.flo` 또는 유사한 형태인가요?
- [ ] 해당 Bundle ID의 앱이 실제 디바이스에 설치되어 있나요?

## 여전히 확인이 어려운 경우

Xcode Organizer에서 확인하는 것이 가장 확실합니다:
1. Xcode → Window → Devices and Simulators
2. 실제 디바이스 선택
3. Installed Apps에서 Flo 앱 찾기
4. Bundle Identifier 복사


