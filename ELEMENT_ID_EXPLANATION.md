# Element ID 가변성 설명

## ⚠️ iOS Element ID의 특성

### Element ID는 "고유"하지만 "영구적"이지 않습니다!

iOS (XCUITest)에서 **element ID는 다음과 같은 특성을 가집니다**:

#### ✅ 세션 내에서는 고유합니다
- 같은 앱 실행 세션 내에서는 각 요소마다 **고유한 ID**를 가집니다
- 세션 내에서는 동일한 요소는 동일한 ID를 유지합니다

#### ❌ 하지만 앱 재시작 시 변경됩니다
- **앱이 재시작되거나 새로운 세션이 시작되면 ID가 변경**됩니다
- 같은 요소라도 앱 재시작 후에는 다른 ID를 받을 수 있습니다
- 예: `37000000-0000-0000-F605-000000000000` → 재시작 후 → `A1000000-0000-0000-F605-000000000001`

#### ⚠️ 테스트에 하드코딩하면 안 됩니다
- ID는 런타임에 동적으로 생성되는 UUID 형태의 값입니다
- 테스트 코드에 하드코딩된 ID는 다음 실행 시 작동하지 않을 수 있습니다
- 따라서 **ID는 테스트 locator로 사용하면 안 됩니다**

## 🔍 안정적인 Locator 전략

ID 대신 다음 방법을 사용하세요 (안정성 순서):

### 1. Accessibility ID (가장 권장) ⭐
```robot
Click Element    accessibility_id=myButton
```
- 개발자가 명시적으로 설정한 고유 ID
- 가장 안정적이고 권장되는 방법

### 2. Name 속성
```robot
Click Element    name=둘러보기
```
- UI 요소의 표시 이름
- 일반적으로 안정적

### 3. XPath 패턴
```robot
Click Element    xpath=//XCUIElementTypeButton[@name="둘러보기"]
```
- 요소 구조 기반
- name이 변경되면 업데이트 필요

### 4. Class Name + Index (비권장)
```robot
Click Element    class=XCUIElementTypeButton    index=0
```
- 구조가 변경되면 깨질 수 있음

## 📋 Inspector에서 안정적인 속성 확인 방법

### 1. Accessibility ID 확인
1. Appium Inspector에서 요소 선택
2. **`accessibility id`** 또는 **`accessibilityIdentifier`** 속성 확인
3. 값이 있으면 이것을 사용 (가장 안정적)

### 2. Name 속성 확인
1. 요소 선택
2. **`name`** 속성 확인
3. 값이 있으면 이것을 사용

### 3. XPath 패턴 확인
1. 요소 선택
2. 부모-자식 구조 확인
3. 고유한 패턴으로 XPath 작성

## 🔧 현재 코드 수정 방법

### 현재 (ID 사용 - 가변적)
```robot
${BROWSE_BUTTON}    37000000-0000-0000-F605-000000000000
Wait For Element And Click    id=${BROWSE_BUTTON}
```

### 수정안 1: Accessibility ID 사용 (권장)
```robot
${BROWSE_BUTTON}    둘러보기버튼  # Inspector에서 확인한 accessibility id
Wait For Element And Click    accessibility_id=${BROWSE_BUTTON}
```

### 수정안 2: Name 사용
```robot
${BROWSE_BUTTON}    둘러보기  # Inspector에서 확인한 name
Wait For Element And Click    name=${BROWSE_BUTTON}
```

### 수정안 3: XPath 사용
```robot
${BROWSE_BUTTON}    //XCUIElementTypeButton[@name="둘러보기"]
Wait For Element And Click    ${BROWSE_BUTTON}  # xpath= 접두사 불필요
```

## 💡 Inspector에서 확인할 속성 우선순위

1. **accessibility id** (있으면 이것 사용)
2. **name** (accessibility id가 없으면)
3. **XPath 패턴** (위 둘 다 없거나 불안정하면)

## ⚠️ 주의사항

- **ID는 절대 사용하지 마세요** - 가변적입니다
- **accessibility id가 가장 안정적**입니다
- **name도 일반적으로 안정적**이지만 앱 업데이트 시 변경될 수 있습니다
- **XPath는 구조 기반**이므로 UI 변경 시 업데이트가 필요할 수 있습니다

