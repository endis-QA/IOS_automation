# 다음 단계 가이드

## ✅ 테스트 실행 성공!

디바이스에서 앱이 실행되었다는 것은 설정이 올바르게 되었다는 의미입니다!

## 📊 테스트 결과 확인

생성된 결과 파일을 확인하세요:

1. **report.html** - 브라우저에서 열어 테스트 결과 확인
   ```bash
   open report.html
   ```

2. **log.html** - 상세한 테스트 로그 확인
   ```bash
   open log.html
   ```

## 🎯 실제 앱 테스트 작성하기

이제 실제 앱의 요소를 테스트하는 케이스를 작성할 수 있습니다.

### 1. 앱 요소 찾기 (Inspector 도구 사용)

앱 요소를 찾는 방법:

#### 방법 A: Appium Inspector 사용 (권장)

1. Appium Desktop 다운로드 및 설치
   - https://github.com/appium/appium-inspector/releases

2. Appium Inspector 실행
   - Remote Host: `localhost`
   - Remote Port: `4723`
   - Remote Path: `/wd/hub` (Appium 2.x) 또는 `/` (Appium 1.x)

3. Desired Capabilities 설정:
   ```json
   {
     "platformName": "iOS",
     "platformVersion": "17.4.1",
     "deviceName": "iPhone 14 pro",
     "udid": "00008120-001119160168C01E",
     "automationName": "XCUITest",
     "bundleId": "kr.co.musicmates.radio"
   }
   ```

4. Start Session 클릭
5. 앱 화면에서 요소 선택하여 속성 확인

#### 방법 B: 코드로 요소 찾기

테스트에서 다음 키워드 사용:
- `Get Page Source` - 현재 화면의 XML 소스 가져오기
- `Log` - 요소 정보 출력

### 2. 테스트 케이스 작성 예제

`tests/test_suite.robot` 또는 새 파일에 추가:

```robot
*** Settings ***
Documentation    실제 앱 기능 테스트
Library    AppiumLibrary
Resource    ../resources/keywords.robot

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure

*** Test Cases ***
앱 시작 화면 확인
    [Documentation]    앱 시작 후 메인 화면 요소 확인
    Sleep    3s
    # 화면 소스 확인 (디버깅용)
    ${source}=    Get Page Source
    Log    ${source}
    
    # 실제 요소 확인 예제 (앱에 맞게 수정 필요)
    # Wait Until Page Contains Element    accessibility_id=mainButton
    # 또는
    # Wait Until Element Is Visible    xpath=//XCUIElementTypeButton[@name="시작하기"]

로그인 테스트
    [Documentation]    로그인 기능 테스트
    # 예제 코드 (앱에 맞게 수정 필요)
    # Wait For Element And Click    accessibility_id=loginButton
    # Wait For Element And Input Text    accessibility_id=emailField    test@example.com
    # Wait For Element And Input Text    accessibility_id=passwordField    password123
    # Wait For Element And Click    accessibility_id=submitButton
    # Sleep    3s
    # Wait Until Page Contains Element    accessibility_id=welcomeMessage
```

### 3. 요소 로케이터 사용법

#### Accessibility ID (권장)
```robot
Click Element    accessibility_id=buttonId
```

#### XPath
```robot
Click Element    xpath=//XCUIElementTypeButton[@name="버튼이름"]
```

#### Name
```robot
Click Element    name=버튼이름
```

#### Class Name
```robot
Click Element    class=XCUIElementTypeButton
```

### 4. 유용한 키워드

이미 `resources/keywords.robot`에 정의된 키워드:

- `Wait For Element And Click` - 요소 대기 후 클릭
- `Wait For Element And Input Text` - 요소 대기 후 텍스트 입력
- `Swipe Down` / `Swipe Up` - 스와이프 제스처
- `Take Screenshot On Failure` - 실패 시 스크린샷

## 🔍 디버깅 팁

### 화면 소스 확인
```robot
${source}=    Get Page Source
Log    ${source}
```

### 스크린샷 찍기
```robot
Capture Page Screenshot    screenshot.png
```

### 요소가 있는지 확인
```robot
${exists}=    Run Keyword And Return Status    Element Should Be Visible    accessibility_id=elementId
Run Keyword If    ${exists}    Log    요소가 존재합니다
```

## 📚 추가 리소스

- [Robot Framework 문서](https://robotframework.org/)
- [AppiumLibrary 문서](https://github.com/serhatbolsu/robotframework-appiumlibrary)
- [Appium XCUITest 드라이버](http://appium.io/docs/en/drivers/ios-xcuitest/)

## 💡 다음 할 일

1. [ ] Appium Inspector로 앱 요소 확인
2. [ ] 실제 앱의 주요 기능 테스트 케이스 작성
3. [ ] 테스트 데이터 관리 (변수 파일)
4. [ ] CI/CD 통합 고려

행운을 빕니다! 🚀


