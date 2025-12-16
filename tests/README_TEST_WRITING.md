# 테스트 스크립트 작성 가이드

## 📁 테스트 파일 위치

모든 테스트 스크립트는 **`tests/` 디렉토리**에 `.robot` 확장자로 작성하세요.

```
ios_automation_script/
└── tests/
    ├── test_suite.robot          # 기본 테스트 스위트
    ├── example_test.robot        # 예제 테스트
    ├── login_test.robot          # 예: 로그인 테스트 (새로 작성)
    ├── navigation_test.robot     # 예: 네비게이션 테스트 (새로 작성)
    └── your_test.robot           # 여러분의 테스트 파일
```

## ✏️ 테스트 파일 작성 방법

### 방법 1: 기존 파일 수정

**`tests/test_suite.robot`** 또는 **`tests/example_test.robot`** 파일을 열어 수정:

```robot
*** Settings ***
Documentation    iOS 테스트 스위트
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure

*** Variables ***

*** Test Cases ***
# 여기에 테스트 케이스 추가
앱 실행 및 기본 기능 확인
    [Documentation]    앱 실행 후 기본 기능이 정상 동작하는지 확인
    [Tags]    smoke    critical
    Log    테스트 시작: 앱 실행 및 기본 기능 확인
    Sleep    2s
    
    # 실제 테스트 코드 작성
    # Wait For Element And Click    accessibility_id=startButton
    # Wait Until Element Is Visible    accessibility_id=mainScreen
    
    Log    앱이 정상적으로 실행되었습니다
```

### 방법 2: 새 테스트 파일 생성

`tests/` 디렉토리에 새 `.robot` 파일을 생성하세요.

**예: `tests/login_test.robot`**

```robot
*** Settings ***
Documentation    로그인 기능 테스트
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure

*** Variables ***

*** Test Cases ***
로그인 테스트
    [Documentation]    사용자 로그인 기능을 테스트합니다
    [Tags]    login    smoke
    Log    로그인 테스트 시작
    
    Sleep    2s
    
    # 실제 앱 요소에 맞게 수정하세요
    # Wait For Element And Click    accessibility_id=loginButton
    # Wait For Element And Input Text    accessibility_id=emailField    test@example.com
    # Wait For Element And Input Text    accessibility_id=passwordField    password123
    # Wait For Element And Click    accessibility_id=submitButton
    
    # 로그인 성공 확인
    # Wait Until Element Is Visible    accessibility_id=welcomeMessage
    # Page Should Contain Element    accessibility_id=userProfile
    
    Log    로그인 테스트 완료
```

## 🎯 테스트 실행 방법

### 특정 파일 실행
```bash
python3 -m robot tests/test_suite.robot
python3 -m robot tests/login_test.robot
```

### 전체 테스트 실행
```bash
python3 -m robot tests/
```

### 태그로 선택 실행
```bash
# smoke 태그만 실행
python3 -m robot --include smoke tests/

# login 태그만 실행
python3 -m robot --include login tests/
```

## 📝 필수 설정 섹션

모든 테스트 파일에 포함해야 하는 기본 설정:

```robot
*** Settings ***
Documentation    테스트 설명
Library    AppiumLibrary                          # Appium 라이브러리
Resource    ../resources/keywords.robot          # 공통 키워드
Resource    ../resources/variables.py            # 설정 변수

Suite Setup    Open iOS App                      # 테스트 시작 전 앱 실행
Suite Teardown    Close iOS App                 # 테스트 종료 후 앱 종료
Test Teardown    Take Screenshot On Failure     # 테스트 실패 시 스크린샷
```

## 💡 테스트 작성 팁

### 1. 테스트 케이스 구조

```robot
테스트 케이스 이름
    [Documentation]    테스트 설명
    [Tags]    tag1    tag2                        # 테스트 태그
    Log    테스트 시작
    
    # 준비 (Arrange)
    Sleep    2s
    
    # 실행 (Act)
    Wait For Element And Click    accessibility_id=button
    
    # 확인 (Assert)
    Wait Until Element Is Visible    accessibility_id=result
    
    Log    테스트 완료
```

### 2. 공통 키워드 사용

`resources/keywords.robot`에 정의된 키워드를 활용하세요:

- `Wait For Element And Click` - 요소 대기 후 클릭
- `Wait For Element And Input Text` - 텍스트 입력
- `Swipe Down` / `Swipe Up` - 스와이프
- `Take Screenshot On Failure` - 실패 시 스크린샷

### 3. 디버깅

```robot
# 화면 소스 확인
${source}=    Get Page Source
Log    ${source}

# 스크린샷 찍기
Capture Page Screenshot    debug.png

# 요소 존재 확인
${exists}=    Run Keyword And Return Status    Element Should Be Visible    accessibility_id=element
Log    요소 존재: ${exists}
```

## 📂 파일 구조 예시

```
tests/
├── test_suite.robot           # 기본 테스트
├── login_test.robot           # 로그인 관련
├── navigation_test.robot      # 네비게이션 관련
├── search_test.robot          # 검색 기능
└── settings_test.robot        # 설정 기능
```

## 🚀 빠른 시작 템플릿

새 테스트 파일을 만들 때 이 템플릿을 복사하여 사용하세요:

```robot
*** Settings ***
Documentation    테스트 설명
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure

*** Variables ***

*** Test Cases ***
새 테스트 케이스
    [Documentation]    테스트 설명
    [Tags]    smoke
    Log    테스트 시작
    Sleep    2s
    
    # 여기에 테스트 코드 작성
    
    Log    테스트 완료
```

## ❓ 자주 묻는 질문

**Q: 여러 테스트 파일을 한 번에 실행할 수 있나요?**
A: 네, `python3 -m robot tests/` 명령으로 모든 테스트를 실행할 수 있습니다.

**Q: 테스트 파일 이름 규칙이 있나요?**
A: `.robot` 확장자를 사용하고, 의미 있는 이름을 사용하세요. 예: `login_test.robot`, `navigation_test.robot`

**Q: 공통 변수나 키워드를 추가하려면?**
A: `resources/keywords.robot` 파일에 키워드를 추가하거나, `resources/variables.py`에 변수를 추가하세요.

**Q: 테스트 데이터는 어디에 저장하나요?**
A: `resources/` 디렉토리에 별도 파일로 만들거나, 테스트 파일 내 `*** Variables ***` 섹션에 정의할 수 있습니다.


