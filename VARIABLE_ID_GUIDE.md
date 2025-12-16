# 가변 ID 처리 가이드

## ⚠️ 문제 상황

마케팅 팝업의 엘리먼트 ID가 **가변적**입니다. 인스펙터에서 조회할 때마다 ID 값이 계속 바뀌기 때문에 ID 기반 locator를 사용할 수 없습니다.

## ✅ 해결 방법

ID 대신 **안정적인 locator 전략**을 사용합니다:

1. **버튼 name 사용** (가장 권장)
2. **XPath 패턴 사용** (대체 방법)

## 📝 사용 방법

### 기본 사용법

```robot
*** Test Cases ***
마케팅 팝업 닫기 테스트
    # 버튼 name만 사용 (가장 안정적)
    ${popup_closed}=    Wait For Popup And Close
    ...    button_name=${MARKETING_POPUP_CLOSE_BUTTON}
    ...    wait_time=3
    ...    timeout=10
    ...    force_close=True
    ...    skip_on_failure=True
```

### XPath 패턴 지정 (선택사항)

```robot
마케팅 팝업 닫기 테스트 (XPath 포함)
    # 버튼 name과 XPath 패턴 모두 지정
    ${popup_closed}=    Wait For Popup And Close
    ...    button_name=${MARKETING_POPUP_CLOSE_BUTTON}
    ...    xpath_pattern=${MARKETING_POPUP_XPATH}
    ...    wait_time=3
    ...    timeout=10
    ...    force_close=True
    ...    skip_on_failure=True
```

## 🔍 동작 방식

`Wait For Popup And Close` 키워드는 다음 순서로 시도합니다:

1. **방법 1: 버튼 name으로 찾기** (우선 시도)
   - `name=${MARKETING_POPUP_CLOSE_BUTTON}` 사용
   - 가장 안정적이고 권장되는 방법

2. **방법 2: XPath로 부모 버튼 찾기** (name 실패 시)
   - 기본: `//XCUIElementTypeButton[.//XCUIElementTypeStaticText[@name="닫기"]]`
   - 또는 `xpath_pattern` 파라미터로 지정한 패턴 사용

## 📋 변수 설정

```robot
*** Variables ***
# 실제 버튼 name (가장 안정적)
${MARKETING_POPUP_CLOSE_BUTTON}    NoticeInnerView_clos 기 버튼, 이중 탭 하면 팝업이 닫힙니다

# XPath 패턴 (선택사항)
${MARKETING_POPUP_XPATH}    //XCUIElementTypeButton[.//XCUIElementTypeStaticText[@name="닫기"]]
```

## ⚠️ 주의사항

1. **ID는 사용하지 않음**: ID가 가변적이므로 `id=` locator는 사용하지 않습니다.

2. **버튼 name 확인**: Inspector에서 실제 버튼의 `name` 속성을 확인하세요.
   - StaticText가 아닌 **Button 요소**의 name을 사용해야 합니다.

3. **XPath 패턴**: 앱 구조가 변경되면 XPath 패턴도 업데이트가 필요할 수 있습니다.

## 🔧 Inspector에서 버튼 name 확인 방법

1. Appium Inspector에서 팝업 닫기 버튼 선택
2. **Button 요소**를 선택 (StaticText가 아님)
3. `name` 속성 확인
4. 해당 값을 `MARKETING_POPUP_CLOSE_BUTTON` 변수에 설정

## 💡 팁

- 버튼 name이 변경되지 않는다면 가장 안정적입니다.
- name으로 찾지 못하는 경우에만 XPath를 사용합니다.
- 여러 방법을 시도하므로 대부분의 경우 자동으로 처리됩니다.


