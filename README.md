# iOS 자동화 테스트 - Robot Framework

Robot Framework를 사용한 iOS 앱 자동화 테스트 프로젝트입니다.

## 📋 사전 요구사항

### 필수 소프트웨어

1. **Python 3.8 이상**
   ```bash
   python3 --version
   ```

2. **Node.js 및 npm** (Appium 설치용)
   ```bash
   node --version
   npm --version
   ```

3. **Appium 서버**
   ```bash
   npm install -g appium
   npm install -g @appium/ios-driver
   ```

4. **iOS 개발 환경** (Xcode, iOS Simulator 또는 실제 iOS 디바이스)

5. **Carthage** (iOS 드라이버 의존성)
   ```bash
   brew install carthage
   ```

## 🚀 설치 방법

### 1. Python 가상환경 생성 (권장)

```bash
python3 -m venv venv
source venv/bin/activate  # macOS/Linux
# 또는
venv\Scripts\activate  # Windows
```

### 2. 의존성 설치

```bash
pip install -r requirements.txt
```

### 3. Appium 서버 설정 확인

```bash
appium doctor --ios
```

## ⚙️ 설정

### 변수 파일 수정

`resources/variables.py` 파일을 열어 다음 항목을 실제 환경에 맞게 수정하세요:

- `IOS_PLATFORM_VERSION`: 테스트할 iOS 버전 (예: "17.0")
- `IOS_DEVICE_NAME`: 시뮬레이터 또는 실제 디바이스 이름 (예: "iPhone 15")
- `IOS_BUNDLE_ID`: 테스트할 앱의 Bundle ID (예: "com.example.app")
- `IOS_APP_PATH`: 앱 파일 경로 (.app 또는 .ipa)
- `IOS_UDID`: 특정 디바이스를 사용하는 경우 UDID 입력

### Appium 서버 시작

테스트 실행 전에 Appium 서버를 시작해야 합니다:

```bash
appium
```

서버는 기본적으로 `http://localhost:4723`에서 실행됩니다.

## 📝 테스트 실행

### 전체 테스트 실행

```bash
robot tests/
```

### 특정 테스트 파일 실행

```bash
robot tests/example_test.robot
```

### 태그를 사용한 선택적 실행

```bash
# smoke 태그만 실행
robot --include smoke tests/

# critical 태그만 실행
robot --include critical tests/

# 특정 태그 제외
robot --exclude gesture tests/
```

### 상세 로그와 함께 실행

```bash
robot --loglevel DEBUG tests/
```

## 📁 프로젝트 구조

```
ios_automation_script/
├── tests/                    # 테스트 파일
│   ├── example_test.robot   # 예제 테스트
│   └── test_suite.robot     # 테스트 스위트
├── resources/                # 리소스 파일
│   ├── variables.py         # 변수 설정
│   ├── appium_config.py     # Appium 설정
│   └── keywords.robot       # 공통 키워드
├── requirements.txt          # Python 의존성
└── README.md                # 프로젝트 문서
```

## 🔧 주요 기능

### 공통 키워드 (`resources/keywords.robot`)

- `Open iOS App`: iOS 앱 시작
- `Close iOS App`: iOS 앱 종료
- `Wait For Element And Click`: 요소 대기 후 클릭
- `Wait For Element And Input Text`: 요소 대기 후 텍스트 입력
- `Scroll To Element`: 요소까지 스크롤
- `Swipe Down` / `Swipe Up`: 스와이프 제스처
- `Take Screenshot On Failure`: 실패 시 스크린샷 저장

## 📱 iOS 요소 로케이터

Robot Framework에서 iOS 요소를 찾는 주요 방법:

### Accessibility ID (권장)

```robot
Click Element    accessibility_id=loginButton
```

### XPath

```robot
Click Element    xpath=//XCUIElementTypeButton[@name="Login"]
```

### Class Name

```robot
Click Element    class=XCUIElementTypeButton
```

### Name

```robot
Click Element    name=Login Button
```

### ID

```robot
Click Element    id=loginButton
```

## 🐛 문제 해결

### Appium 서버 연결 오류

- Appium 서버가 실행 중인지 확인: `appium`
- 포트가 올바른지 확인: `http://localhost:4723`
- iOS 시뮬레이터가 실행 중인지 확인

### iOS 시뮬레이터 연결 문제

```bash
# 시뮬레이터 목록 확인
xcrun simctl list devices

# 특정 시뮬레이터 부팅
xcrun simctl boot "iPhone 15"
```

### 권한 문제

Xcode에서 WebDriverAgent가 신뢰되도록 설정해야 할 수 있습니다:
1. Xcode에서 WebDriverAgent 프로젝트 열기
2. 디바이스에서 신뢰 설정

## 📚 추가 리소스

- [Robot Framework 공식 문서](https://robotframework.org/)
- [Appium 공식 문서](http://appium.io/)
- [AppiumLibrary 문서](https://serhatbolsu.github.io/robotframework-appiumlibrary/)

## 📄 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다.


