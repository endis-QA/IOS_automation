# Accessibility ID 찾기 및 사용 가이드

## 🔍 Accessibility ID란?

**Accessibility ID**는 개발자가 UI 요소에 명시적으로 설정한 고유 식별자입니다.

- ✅ **가장 안정적인 locator** (앱 재시작 후에도 동일)
- ✅ **개발자가 직접 설정**하므로 의도적으로 고유하게 만듦
- ✅ **테스트 자동화에 최적화**된 방법

## 📋 Appium Inspector에서 찾는 방법

### 방법 1: Inspector에서 직접 확인

1. **Appium Inspector 실행**
   ```bash
   # Appium 서버 실행 후 Inspector 열기
   # http://localhost:4723 접속
   ```

2. **요소 선택**
   - Inspector에서 찾고 싶은 버튼/요소를 클릭
   - 또는 화면에서 직접 요소를 선택

3. **속성 확인**
   - 선택한 요소의 속성 패널에서 다음을 확인:
     - **`accessibility id`** 또는
     - **`accessibilityIdentifier`** 또는
     - **`accessibility-id`**

4. **값 확인**
   - 값이 있으면 그것이 Accessibility ID입니다
   - 예: `browseButton`, `chartPlayAll`, `loginButton` 등

### 방법 2: Page Source에서 확인

1. **Page Source 가져오기**
   - Inspector에서 "Get Page Source" 클릭
   - 또는 테스트 코드에서:
   ```robot
   ${source}=    Get Page Source
   Log    ${source}
   ```

2. **XML에서 찾기**
   ```xml
   <XCUIElementTypeButton 
       name="둘러보기"
       accessibility-id="browseButton"    ← 이것이 Accessibility ID!
       enabled="true"
       visible="true">
   ```

3. **속성 확인**
   - `accessibility-id` 속성이 있으면 그것을 사용
   - 없으면 `name` 속성을 사용

## 🔧 코드에 적용하는 방법

### 1. 변수에 설정

```robot
*** Variables ***
# Accessibility ID 사용 (가장 안정적)
${BROWSE_BUTTON}    browseButton  # Inspector에서 확인한 accessibility-id 값
${CHART_PLAY_ALL_BUTTON}    chartPlayAll  # Inspector에서 확인한 accessibility-id 값
```

### 2. 테스트에서 사용

```robot
*** Test Cases ***
둘러보기 버튼 클릭 테스트
    # Accessibility ID로 요소 찾기
    Wait For Element And Click    accessibility_id=${BROWSE_BUTTON}
    
    # 또는 직접 사용
    Wait For Element And Click    accessibility_id=browseButton
```

## 📝 실제 예시

### Inspector에서 확인한 정보

```
요소: 둘러보기 버튼
- name: "둘러보기"
- accessibility-id: "browseButton"  ← 이것을 사용!
- element-id: "37000000-0000-0000-F605-000000000000"  ← 사용하지 않음
```

### 코드 적용

```robot
*** Variables ***
${BROWSE_BUTTON}    browseButton

*** Test Cases ***
테스트
    Click Element    accessibility_id=${BROWSE_BUTTON}
```

## ⚠️ Accessibility ID가 없는 경우

Accessibility ID가 없는 경우 다음 순서로 시도:

1. **Name 속성 사용**
   ```robot
   Click Element    name=둘러보기
   ```

2. **XPath 패턴 사용**
   ```robot
   Click Element    xpath=//XCUIElementTypeButton[@name="둘러보기"]
   ```

## 💡 팁

### 개발자에게 요청하기

Accessibility ID가 없는 경우, 개발팀에 요청할 수 있습니다:

```
iOS 개발자에게:
"테스트 자동화를 위해 주요 버튼들에 accessibilityIdentifier를 설정해주세요.
예: 둘러보기 버튼 → 'browseButton'"
```

### Swift/Objective-C에서 설정 방법

```swift
// Swift 예시
button.accessibilityIdentifier = "browseButton"
```

```objc
// Objective-C 예시
button.accessibilityIdentifier = @"browseButton";
```

## 🔍 확인 방법 요약

1. **Appium Inspector 실행**
2. **요소 선택**
3. **속성 패널에서 `accessibility-id` 확인**
4. **값이 있으면 그것을 사용**
5. **없으면 `name` 또는 `xpath` 사용**

## 📚 관련 문서

- `ELEMENT_ID_DETAILED.md`: Element ID vs Accessibility ID 비교
- `ELEMENT_ID_EXPLANATION.md`: Locator 전략 가이드


