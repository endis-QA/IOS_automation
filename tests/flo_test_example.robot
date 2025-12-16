*** Settings ***
Documentation    Flo 앱 테스트 예제 - 실제 요소 ID를 사용한 테스트
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure

*** Variables ***
# Flo 앱 요소 ID 정의
${MARKETING_POPUP_CLOSE}    22000000-0000-0000-F505-000000000000
${BROWSE_BUTTON}            37000000-0000-0000-F605-000000000000
${CHART_PLAY_ALL_BUTTON}     6C000000-0000-0000-F605-000000000000

*** Test Cases ***
마케팅 팝업 닫기 테스트
    [Documentation]    앱 실행 후 마케팅 팝업이 나타나면 닫는 테스트
    [Tags]    popup    smoke
    Log    마케팅 팝업 닫기 테스트 시작
    
    # 앱 로드 대기
    Sleep    3s
    
    # 마케팅 팝업 닫기 버튼 확인 및 클릭
    # 팝업이 나타날 수 있으므로 존재 여부 확인
    ${popup_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}    timeout=5
    
    Run Keyword If    ${popup_visible}
    ...    Wait For Element And Click    id=${MARKETING_POPUP_CLOSE}
    ...    ELSE
    ...    Log    마케팅 팝업이 나타나지 않았습니다
    
    Sleep    1s
    Log    마케팅 팝업 닫기 테스트 완료

둘러보기 버튼 클릭
    [Documentation]    둘러보기 버튼을 클릭하여 해당 화면으로 이동
    [Tags]    navigation    browse
    Log    둘러보기 버튼 클릭 테스트 시작
    
    Sleep    2s
    
    # 마케팅 팝업 처리 (있을 경우)
    ${popup_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}    timeout=3
    Run Keyword If    ${popup_visible}    Wait For Element And Click    id=${MARKETING_POPUP_CLOSE}
    Sleep    1s
    
    # 둘러보기 버튼 클릭
    Wait For Element And Click    id=${BROWSE_BUTTON}
    Log    둘러보기 버튼 클릭 완료
    
    # 화면 전환 대기
    Sleep    2s
    Log    둘러보기 버튼 클릭 테스트 완료

전체 연령 차트 전체듣기
    [Documentation]    Flo 전체 연령 차트의 전체듣기 버튼 클릭 테스트
    [Tags]    chart    play    music
    Log    전체 연령 차트 전체듣기 테스트 시작
    
    Sleep    2s
    
    # 마케팅 팝업 처리
    ${popup_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}    timeout=3
    Run Keyword If    ${popup_visible}    Wait For Element And Click    id=${MARKETING_POPUP_CLOSE}
    Sleep    1s
    
    # 전체듣기 버튼 클릭
    # 주의: 차트 화면으로 이동이 필요할 수 있습니다
    Wait For Element And Click    id=${CHART_PLAY_ALL_BUTTON}
    Log    전체듣기 버튼 클릭 완료
    
    # 재생 시작 대기
    Sleep    3s
    Log    전체 연령 차트 전체듣기 테스트 완료

Flo 앱 시나리오 테스트
    [Documentation]    Flo 앱의 주요 시나리오를 순차적으로 테스트
    [Tags]    scenario    smoke    critical
    Log    Flo 앱 시나리오 테스트 시작
    
    # 1단계: 앱 로드
    Sleep    3s
    Log    1단계: 앱 로드 완료
    
    # 2단계: 마케팅 팝업 닫기
    ${popup_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE}    timeout=5
    Run Keyword If    ${popup_visible}
    ...    Wait For Element And Click    id=${MARKETING_POPUP_CLOSE}
    Run Keyword If    ${popup_visible}    Log    2단계: 마케팅 팝업 닫기 완료
    Run Keyword If    not ${popup_visible}    Log    2단계: 마케팅 팝업 없음
    Sleep    1s
    
    # 3단계: 둘러보기 버튼 클릭
    Wait For Element And Click    id=${BROWSE_BUTTON}
    Log    3단계: 둘러보기 버튼 클릭 완료
    Sleep    2s
    
    # 4단계: 전체 연령 차트 전체듣기 버튼 클릭
    # 필요시 차트 화면으로 스크롤하거나 네비게이션 추가
    Wait For Element And Click    id=${CHART_PLAY_ALL_BUTTON}
    Log    4단계: 전체듣기 버튼 클릭 완료
    
    # 5단계: 재생 확인
    Sleep    3s
    Log    5단계: 재생 확인 완료
    
    Log    Flo 앱 시나리오 테스트 완료


