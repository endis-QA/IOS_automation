# 실패 처리 가이드

## 🔴 실패 시 중단 설정

테스트가 실패하면 이후 동작을 자동으로 중단하도록 설정되어 있습니다.

## 📋 적용된 기능

### 1. 테스트 케이스 레벨 중단

각 테스트 케이스 내에서 중요한 단계가 실패하면 즉시 테스트를 중단합니다.

#### 사용된 키워드

- `Wait For Element And Click Or Fail` - 요소 클릭 실패 시 테스트 중단
- `Check Step And Fail If Error` - 일반 키워드 실행 실패 시 중단

#### 예제

```robot
# 실패 시 중단되는 클릭
Wait For Element And Click Or Fail    id=${BROWSE_BUTTON}    timeout=10    error_message=둘러보기 버튼 클릭 실패

# 일반 키워드 실패 시 중단
Check Step And Fail If Error    Wait For Element And Click    id=${BROWSE_BUTTON}
```

### 2. 테스트 스위트 레벨 중단

하나의 테스트 케이스가 실패하면 다음 테스트 케이스를 실행하지 않습니다.

#### 실행 옵션

```bash
# 실패 시 즉시 중단
python3 -m robot --exitonfailure tests/

# 또는 스크립트 사용
./run_tests.sh
```

## 🎯 실패 처리 방식

### 방법 1: Wait For Element And Click Or Fail (권장)

```robot
# 요소를 찾을 수 없거나 클릭할 수 없으면 즉시 실패
Wait For Element And Click Or Fail    id=${BROWSE_BUTTON}    timeout=10    error_message=버튼 클릭 실패
```

**특징:**
- 요소가 보이지 않으면 즉시 실패
- 클릭이 실패하면 즉시 실패
- 명확한 에러 메시지 제공

### 방법 2: Check Step And Fail If Error

```robot
# 키워드 실행 결과를 확인하고 실패 시 중단
Check Step And Fail If Error    Wait For Element And Click    id=${BROWSE_BUTTON}
```

### 방법 3: 조건부 실행 후 실패 처리

```robot
${success}=    Run Keyword And Return Status    Wait For Element And Click    id=${BROWSE_BUTTON}
Run Keyword If    not ${success}    Fail    버튼 클릭 실패 - 테스트 중단
```

## 📝 테스트 파일에서 사용 예제

### 기본 사용

```robot
*** Test Cases ***
중요한 단계 테스트
    [Documentation]    실패 시 중단되는 테스트
    Log    테스트 시작
    
    # 실패 시 중단되는 클릭
    Wait For Element And Click Or Fail    id=${BUTTON_ID}    timeout=10    error_message=버튼 클릭 실패
    
    # 다음 단계는 위 단계가 성공해야만 실행됨
    Sleep    2s
    Log    테스트 완료
```

### 조건부 처리와 함께 사용

```robot
*** Test Cases ***
조건부 실패 처리
    [Documentation]    팝업이 있으면 닫고, 실패 시 중단
    Log    테스트 시작
    
    # 팝업이 있으면 닫기 (실패 시 중단)
    ${popup_exists}=    Run Keyword And Return Status    Element Should Be Visible    id=${POPUP_CLOSE}    timeout=5
    Run Keyword If    ${popup_exists}
    ...    Wait For Element And Click Or Fail    id=${POPUP_CLOSE}    timeout=5    error_message=팝업 닫기 실패
    
    # 다음 단계 진행
    Wait For Element And Click Or Fail    id=${NEXT_BUTTON}    timeout=10    error_message=다음 버튼 클릭 실패
```

## ⚙️ 실행 옵션

### 실패 시 즉시 중단

```bash
python3 -m robot --exitonfailure tests/
```

### 특정 테스트만 실행 (실패 시 중단)

```bash
python3 -m robot --exitonfailure tests/test_suite.robot
```

### 태그로 선택 실행 (실패 시 중단)

```bash
python3 -m robot --exitonfailure --include smoke tests/
```

## 🔍 실패 원인 확인

### 1. 로그 확인

테스트 실패 시 `log.html` 파일에서 상세한 오류 정보 확인:

```bash
open log.html
```

### 2. 스크린샷 확인

테스트 실패 시 자동으로 스크린샷이 저장됩니다:
- 파일명: `{테스트이름}_failure.png`

### 3. 디버그 모드 실행

더 상세한 로그를 보려면:

```bash
python3 -m robot --loglevel DEBUG --exitonfailure tests/
```

## 💡 팁

### 선택적 실패 처리

모든 단계를 실패 시 중단하지 않고, 중요한 단계만 중단하려면:

```robot
# 중요하지 않은 단계 (실패해도 계속 진행)
${success}=    Run Keyword And Return Status    Wait For Element And Click    id=${OPTIONAL_BUTTON}
Run Keyword If    not ${success}    Log    선택적 버튼 클릭 실패 (계속 진행)

# 중요한 단계 (실패 시 중단)
Wait For Element And Click Or Fail    id=${CRITICAL_BUTTON}    timeout=10    error_message=중요한 버튼 클릭 실패
```

### 에러 메시지 커스터마이징

명확한 에러 메시지를 제공하여 디버깅을 쉽게:

```robot
Wait For Element And Click Or Fail
    ...    id=${BROWSE_BUTTON}
    ...    timeout=10
    ...    error_message=❌ 둘러보기 버튼(id: ${BROWSE_BUTTON})을 10초 내에 찾을 수 없거나 클릭할 수 없습니다. 화면이 로드되지 않았을 수 있습니다.
```

## 📚 관련 파일

- `resources/keywords.robot` - 실패 시 중단 키워드 정의
- `tests/test_suite.robot` - 실패 시 중단 적용 예제
- `run_tests.sh` - `--exitonfailure` 옵션 포함


