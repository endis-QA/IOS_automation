# 마케팅 팝업 처리 가이드

## 🔧 개선된 팝업 처리 방법

마케팅 팝업 닫기 버튼이 실행되지 않는 문제를 해결하기 위해 다음과 같이 개선되었습니다:

### 주요 개선사항

1. **5초 대기 시간**: 앱 실행 후 팝업이 나타날 때까지 충분한 시간 대기
2. **여러 클릭 방법 시도**: 일반 클릭이 실패하면 탭 제스처로 재시도
3. **상세한 로깅**: 각 단계의 진행 상황을 명확히 기록
4. **안전한 실패 처리**: 팝업이 없어도 테스트 계속 진행

## 📋 사용된 키워드

### Wait For Popup And Close

팝업이 나타날 때까지 대기한 후 닫기 버튼을 클릭합니다.

**사용법:**
```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10
```

**파라미터:**
- `close_button_id`: 팝업 닫기 버튼의 ID
- `wait_time`: 팝업이 나타날 때까지 대기할 시간 (초, 기본값: 5)
- `timeout`: 버튼을 찾을 때까지의 타임아웃 (초, 기본값: 10)

**반환값:**
- `True`: 팝업이 나타나서 닫았을 때
- `False`: 팝업이 나타나지 않았을 때

### Close Popup Button

팝업 닫기 버튼을 여러 방법으로 클릭 시도합니다.

**클릭 방법:**
1. 일반 클릭 (`Click Element`)
2. 탭 제스처 (`Tap`) - 일반 클릭 실패 시
3. 결과 확인 - 팝업이 사라졌는지 확인

## 💻 사용 예제

### 기본 사용

```robot
*** Test Cases ***
팝업 처리 테스트
    Log    앱 시작
    
    # 앱 로드 대기
    Sleep    3s
    
    # 팝업 처리 (5초 대기)
    ${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10
    
    Run Keyword If    ${popup_closed}    Log    팝업 닫기 완료
    Run Keyword If    not ${popup_closed}    Log    팝업 없음
```

### 커스텀 대기 시간

```robot
# 10초 대기 후 팝업 확인
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=10    timeout=15
```

## 🔍 디버깅

### 로그 확인

팝업 처리 과정에서 다음과 같은 로그가 출력됩니다:

```
팝업이 나타날 때까지 5초 대기 중...
팝업 닫기 버튼(id: 22000000-0000-0000-F505-000000000000) 확인 중...
팝업 닫기 버튼 클릭 시도 중...
✅ 방법 1 성공: 일반 클릭으로 팝업 닫기 완료
✅ 팝업이 닫혔습니다
```

### 실패 시 확인 사항

1. **요소 ID 확인**
   ```robot
   ${source}=    Get Page Source
   Log    ${source}
   ```

2. **스크린샷 확인**
   ```robot
   Capture Page Screenshot    popup_debug.png
   ```

3. **요소 상태 확인**
   ```robot
   ${visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}
   ${enabled}=    Run Keyword And Return Status    Element Should Be Enabled    id=${MARKETING_POPUP_CLOSE}
   Log    요소 보임: ${visible}, 활성화: ${enabled}
   ```

## ⚙️ 동작 흐름

1. **앱 실행 후 초기 대기** (3초)
   - 앱이 완전히 로드될 때까지 대기

2. **팝업 대기** (5초)
   - 마케팅 팝업이 나타날 때까지 대기
   - 사용자가 요청한 대로 5초 대기

3. **팝업 확인**
   - 팝업 닫기 버튼이 보이는지 확인
   - 타임아웃: 10초

4. **클릭 시도**
   - 방법 1: 일반 클릭
   - 방법 2: 탭 제스처 (방법 1 실패 시)

5. **결과 확인**
   - 팝업이 사라졌는지 확인
   - 실패 시 에러 메시지 출력

## 🎯 적용된 테스트

다음 테스트 파일에 적용되었습니다:

- `tests/test_suite.robot`
  - Flo 앱 시작 및 마케팅 팝업 닫기
  - 둘러보기 버튼 클릭 테스트
  - Flo 전체 연령 차트 전체듣기 테스트
  - Flo 앱 전체 플로우 테스트

## 💡 추가 팁

### 팝업이 느리게 나타나는 경우

대기 시간을 늘릴 수 있습니다:

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=10    timeout=15
```

### 팝업이 항상 나타나는 경우

조건부 처리를 제거하고 항상 닫기:

```robot
Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10
```

### 팝업이 나타나지 않는 경우

팝업이 없어도 테스트가 계속 진행되므로 문제없습니다.


