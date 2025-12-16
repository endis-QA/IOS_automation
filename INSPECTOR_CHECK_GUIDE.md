# Inspector에서 안정적인 속성 확인 가이드

## ⚠️ Element ID는 사용하지 마세요!

제공하신 값: `30000000-0000-0000-2706-000000000000`

이것은 **Element ID**입니다. Element ID는:
- ❌ 앱 재시작 시 변경됩니다
- ❌ 테스트 코드에 사용하면 안 됩니다

## ✅ Inspector에서 확인해야 할 속성

### 1. Accessibility ID 확인 (가장 권장)

Inspector에서 "둘러보기" 버튼을 선택한 후:

```
속성 패널에서 확인:
┌─────────────────────────────────┐
│ name: "둘러보기"                │
│ accessibility-id: ???           │ ← 이것을 확인!
│ element-id: 30000000-0000-...   │ ← 이것은 사용하지 않음
└─────────────────────────────────┘
```

**accessibility-id 값이 있으면:**
```robot
${BROWSE_BUTTON}    browseButton  # Inspector에서 확인한 accessibility-id 값
Click Element    accessibility_id=${BROWSE_BUTTON}
```

### 2. Name 속성 확인

**accessibility-id가 없으면 name 사용:**
```robot
${BROWSE_BUTTON}    둘러보기  # Inspector에서 확인한 name 값
Click Element    name=${BROWSE_BUTTON}
```

### 3. XPath 패턴 사용

**위 둘 다 없거나 불안정하면:**
```robot
${BROWSE_BUTTON}    //XCUIElementTypeButton[@name="둘러보기"]
Click Element    ${BROWSE_BUTTON}
```

## 📋 Inspector에서 확인하는 단계

1. **Appium Inspector 실행**
   - Appium 서버 실행
   - Inspector에서 앱 연결

2. **"둘러보기" 버튼 선택**
   - 화면에서 "둘러보기" 버튼 클릭
   - 또는 요소 트리에서 찾기

3. **속성 패널 확인**
   - 오른쪽 속성 패널에서 다음 확인:
     - `accessibility-id` 또는 `accessibilityIdentifier` ← 이것이 있으면 사용!
     - `name` ← accessibility-id가 없으면 이것 사용
     - `element-id` ← 이것은 사용하지 않음!

4. **값 복사**
   - 확인한 값을 변수에 설정

## 🔧 코드 적용 예시

### Inspector에서 확인한 정보

**시나리오 1: accessibility-id가 있는 경우**
```
요소: 둘러보기 버튼
- name: "둘러보기"
- accessibility-id: "browseButton"  ← 이것 사용!
- element-id: 30000000-0000-0000-2706-000000000000  ← 사용하지 않음
```

**코드:**
```robot
*** Variables ***
${BROWSE_BUTTON}    browseButton

*** Test Cases ***
테스트
    Click Element    accessibility_id=${BROWSE_BUTTON}
```

**시나리오 2: accessibility-id가 없는 경우**
```
요소: 둘러보기 버튼
- name: "둘러보기"  ← 이것 사용!
- accessibility-id: (없음)
- element-id: 30000000-0000-0000-2706-000000000000  ← 사용하지 않음
```

**코드:**
```robot
*** Variables ***
${BROWSE_BUTTON}    둘러보기

*** Test Cases ***
테스트
    Click Element    name=${BROWSE_BUTTON}
```

## 💡 현재 코드 상태

현재 코드는 name을 먼저 시도하고, 실패하면 accessibility_id를 시도하도록 되어 있습니다:

```robot
${browse_success}=    Run Keyword And Return Status    Wait For Element And Click    name=${BROWSE_BUTTON}    timeout=10
Run Keyword If    not ${browse_success}
...    ${browse_success}=    Run Keyword And Return Status    Wait For Element And Click    accessibility_id=${BROWSE_BUTTON}    timeout=10
```

따라서 Inspector에서 확인한 **name** 또는 **accessibility-id** 값을 변수에 넣으면 됩니다.

## ⚠️ 주의사항

- **Element ID (`30000000-0000-0000-2706-000000000000`)는 사용하지 마세요**
- **Inspector에서 `accessibility-id` 또는 `name` 속성을 확인하세요**
- **확인한 값을 `${BROWSE_BUTTON}` 변수에 설정하세요**


