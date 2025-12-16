# Flo 앱 요소 ID 사용 가이드

## 📋 요소 ID 목록

현재 사용 중인 Flo 앱의 요소 ID:

| 요소 이름 | ID | 용도 |
|---------|-----|------|
| 마케팅 팝업 닫기 | `22000000-0000-0000-F505-000000000000` | 앱 시작 시 나타나는 마케팅 팝업 닫기 |
| 둘러보기 버튼 | `37000000-0000-0000-F605-000000000000` | 둘러보기 화면으로 이동 |
| 전체 연령 차트 전체듣기 | `6C000000-0000-0000-F605-000000000000` | 차트 전체듣기 재생 시작 |

## 💻 테스트 파일에서 사용 방법

### 방법 1: Variables 섹션에 정의

```robot
*** Variables ***
${MARKETING_POPUP_CLOSE}    22000000-0000-0000-F505-000000000000
${BROWSE_BUTTON}            37000000-0000-0000-F605-000000000000
${CHART_PLAY_ALL_BUTTON}     6C000000-0000-0000-F605-000000000000
```

### 방법 2: 직접 ID 사용

```robot
Wait For Element And Click    id=22000000-0000-0000-F505-000000000000
```

## 🎯 사용 예제

### 기본 클릭

```robot
# 마케팅 팝업 닫기
Wait For Element And Click    id=${MARKETING_POPUP_CLOSE}

# 둘러보기 버튼 클릭
Wait For Element And Click    id=${BROWSE_BUTTON}

# 전체듣기 버튼 클릭
Wait For Element And Click    id=${CHART_PLAY_ALL_BUTTON}
```

### 조건부 클릭 (팝업이 있을 때만)

```robot
# 마케팅 팝업이 나타날 수 있으므로 존재 여부 확인
${popup_exists}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}    timeout=5
Run Keyword If    ${popup_exists}    Wait For Element And Click    id=${MARKETING_POPUP_CLOSE}
```

### 요소 존재 확인

```robot
# 요소가 나타날 때까지 대기
Wait Until Element Is Visible    id=${BROWSE_BUTTON}    timeout=10

# 요소가 존재하는지 확인
${exists}=    Run Keyword And Return Status    Element Should Be Visible    id=${CHART_PLAY_ALL_BUTTON}
Log    요소 존재: ${exists}
```

## 📝 완성된 테스트 예제

`tests/test_suite.robot` 또는 `tests/flo_test_example.robot` 파일을 참고하세요.

## 🔍 디버깅 팁

### 요소가 찾아지지 않을 때

1. **타임아웃 증가**
   ```robot
   Wait Until Element Is Visible    id=${BROWSE_BUTTON}    timeout=30
   ```

2. **화면 소스 확인**
   ```robot
   ${source}=    Get Page Source
   Log    ${source}
   ```

3. **스크린샷 확인**
   ```robot
   Capture Page Screenshot    debug.png
   ```

4. **요소 존재 여부 확인**
   ```robot
   ${exists}=    Run Keyword And Return Status    Element Should Be Visible    id=${BROWSE_BUTTON}
   Log    버튼 존재: ${exists}
   ```

## ⚠️ 주의사항

1. **팝업 처리**: 마케팅 팝업은 항상 나타나지 않을 수 있으므로 조건부 처리 필요
2. **대기 시간**: 각 액션 후 적절한 대기 시간 설정 (`Sleep`)
3. **화면 전환**: 버튼 클릭 후 화면 전환이 완료될 때까지 대기 필요

## 🚀 테스트 실행

```bash
# 특정 테스트 실행
python3 -m robot tests/test_suite.robot

# 전체 테스트 실행
python3 -m robot tests/

# 특정 태그만 실행
python3 -m robot --include smoke tests/
```


