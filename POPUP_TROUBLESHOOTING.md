# 팝업 닫기 문제 해결 가이드

## 🔧 개선된 팝업 닫기 방법

팝업이 닫히지 않는 문제를 해결하기 위해 여러 방법을 시도하도록 개선되었습니다.

## 📋 시도하는 방법들

### 1. 일반 클릭
```robot
Click Element    id=${MARKETING_POPUP_CLOSE}
```

### 2. 탭 제스처
요소의 중앙 좌표를 계산하여 탭 제스처로 클릭

### 3. JavaScript 클릭
```robot
Execute Script    arguments[0].click();    ARGUMENTS    id=${MARKETING_POPUP_CLOSE}
```

### 4. 여러 번 클릭 시도
최대 3회까지 반복 클릭 시도

### 5. 강제 닫기 (force_close=True)
- 화면 외부 영역 탭
- 스와이프 다운으로 팝업 닫기

## 💻 사용 방법

### 기본 사용 (실패해도 계속 진행)

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10    force_close=True    skip_on_failure=True
```

**파라미터:**
- `wait_time`: 팝업이 나타날 때까지 대기 시간 (초, 기본값: 5)
- `timeout`: 버튼을 찾을 때까지의 타임아웃 (초, 기본값: 10)
- `force_close`: 강제 닫기 방법 시도 여부 (기본값: False)
- `skip_on_failure`: 팝업 닫기 실패 시 테스트 계속 진행 여부 (기본값: True)

### 팝업 닫기 실패 시 테스트 중단

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10    force_close=True    skip_on_failure=False
```

## 🔍 디버깅 방법

### 1. 스크린샷 확인

팝업 닫기 시도 전후로 자동으로 스크린샷이 저장됩니다:
- `popup_before_close.png` - 닫기 전
- `popup_after_close.png` - 닫기 후

### 2. 요소 정보 확인

테스트 실행 시 요소의 상세 정보가 로그에 출력됩니다:
- 위치 (x, y 좌표)
- 크기 (width, height)
- 활성화 상태
- 보임 여부

### 3. 로그 확인

각 시도 방법의 결과가 상세히 로그에 기록됩니다:

```
========================================
팝업 닫기 시도 시작
========================================
방법 1: 일반 클릭 시도...
✅ 방법 1 성공: 일반 클릭
✅ 팝업이 닫혔습니다
========================================
팝업 닫기 시도 완료 (결과: True)
========================================
```

## 🐛 문제 해결 단계

### 단계 1: 요소 ID 확인

```robot
# 화면 소스 확인
${source}=    Get Page Source
Log    ${source}
```

### 단계 2: 요소 상태 확인

```robot
# 요소가 보이는지 확인
${visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}
Log    요소 보임: ${visible}

# 요소가 활성화되어 있는지 확인
${enabled}=    Run Keyword And Return Status    Element Should Be Enabled    id=${MARKETING_POPUP_CLOSE}
Log    요소 활성화: ${enabled}
```

### 단계 3: 수동 클릭 테스트

```robot
# 직접 클릭 시도
Click Element    id=${MARKETING_POPUP_CLOSE}
Sleep    1s

# 팝업이 사라졌는지 확인
${still_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}    timeout=2
Log    여전히 보임: ${still_visible}
```

### 단계 4: 좌표 직접 클릭

```robot
# 요소 위치 가져오기
${element}=    Get Webelement    id=${MARKETING_POPUP_CLOSE}
${location}=    Get Location    ${element}
${size}=    Get Size    ${element}

# 중앙 좌표 계산
${x}=    Evaluate    ${location['x']} + ${size['width']} / 2
${y}=    Evaluate    ${location['y']} + ${size['height']} / 2

# 직접 탭
Tap    ${x}    ${y}
```

## ⚙️ 설정 옵션

### 팝업이 닫히지 않아도 테스트 계속 진행 (권장)

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10    force_close=True    skip_on_failure=True
```

이 설정을 사용하면:
- 팝업 닫기를 여러 방법으로 시도
- 실패해도 테스트는 계속 진행
- 로그에 경고 메시지 출력

### 팝업 닫기 실패 시 테스트 중단

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10    force_close=True    skip_on_failure=False
```

## 💡 추가 팁

### 대기 시간 조정

팝업이 느리게 나타나는 경우:

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=10    timeout=15
```

### 타임아웃 조정

요소를 찾는 데 시간이 오래 걸리는 경우:

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=20
```

### 강제 닫기 활성화

일반 클릭이 작동하지 않는 경우:

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10    force_close=True
```

## 📝 현재 적용된 설정

`tests/test_suite.robot` 파일의 모든 테스트 케이스에서:

```robot
${popup_closed}=    Wait For Popup And Close    ${MARKETING_POPUP_CLOSE}    wait_time=5    timeout=10    force_close=True    skip_on_failure=True
```

이 설정으로:
- ✅ 여러 방법으로 팝업 닫기 시도
- ✅ 실패해도 테스트 계속 진행
- ✅ 상세한 디버깅 정보 제공

## 🚨 여전히 문제가 있는 경우

1. **요소 ID 확인**: 실제 앱에서 요소 ID가 변경되었을 수 있습니다
2. **앱 버전 확인**: 앱 업데이트로 팝업 구조가 변경되었을 수 있습니다
3. **스크린샷 확인**: `popup_before_close.png` 파일로 실제 화면 확인
4. **로그 확인**: `log.html` 파일에서 상세한 오류 정보 확인


