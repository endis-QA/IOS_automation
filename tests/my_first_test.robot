*** Settings ***
Documentation    첫 번째 테스트 예제 - 이 파일을 참고하여 여러분의 테스트를 작성하세요
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure

*** Variables ***

*** Test Cases ***
앱 화면 구조 확인
    [Documentation]    앱의 현재 화면 구조를 확인하는 테스트
    [Tags]    debug    smoke
    Log    화면 구조 확인 시작
    
    # 앱이 완전히 로드될 때까지 대기
    Sleep    3s
    
    # 현재 화면의 소스 코드 가져오기 (디버깅용)
    ${source}=    Get Page Source
    Log    ${source}
    
    # 스크린샷 저장
    Capture Page Screenshot    app_screen.png
    
    Log    화면 구조 확인 완료 - log.html에서 상세 정보 확인 가능

메인 화면 요소 확인
    [Documentation]    메인 화면의 주요 요소가 존재하는지 확인
    [Tags]    smoke
    Log    메인 화면 요소 확인 시작
    
    Sleep    2s
    
    # 여기에 실제 앱의 요소를 확인하는 코드를 추가하세요
    # 예시 (앱에 맞게 수정 필요):
    # 
    # Wait Until Element Is Visible    accessibility_id=mainButton    timeout=10
    # 또는
    # Wait Until Page Contains Element    xpath=//XCUIElementTypeButton[@name="시작하기"]
    # 또는
    # Page Should Contain Element    name=홈 화면
    
    Log    메인 화면 요소 확인 완료

버튼 클릭 테스트
    [Documentation]    버튼 클릭 동작 테스트
    [Tags]    interaction
    Log    버튼 클릭 테스트 시작
    
    Sleep    2s
    
    # 여기에 실제 버튼 클릭 코드를 추가하세요
    # 예시:
    # 
    # Wait For Element And Click    accessibility_id=startButton
    # 또는
    # Wait For Element And Click    xpath=//XCUIElementTypeButton[@name="시작하기"]
    # 
    # 클릭 후 결과 확인
    # Sleep    1s
    # Wait Until Element Is Visible    accessibility_id=nextScreen
    
    Log    버튼 클릭 테스트 완료

텍스트 입력 테스트
    [Documentation]    텍스트 입력 필드 테스트
    [Tags]    input
    Log    텍스트 입력 테스트 시작
    
    Sleep    2s
    
    # 여기에 텍스트 입력 코드를 추가하세요
    # 예시:
    # 
    # Wait For Element And Input Text    accessibility_id=searchField    검색어
    # 또는
    # Wait For Element And Input Text    xpath=//XCUIElementTypeTextField[@name="검색"]    검색어
    # 
    # 입력 후 확인
    # Sleep    1s
    # ${text}=    Get Text    accessibility_id=searchField
    # Should Be Equal    ${text}    검색어
    
    Log    텍스트 입력 테스트 완료


