*** Settings ***
Documentation    iOS 앱 기본 테스트 예제
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure

*** Variables ***

*** Test Cases ***
앱 실행 확인
    [Documentation]    앱이 정상적으로 실행되는지 확인합니다
    [Tags]    smoke
    Log    앱이 성공적으로 실행되었습니다
    # 앱의 메인 화면이 로드될 때까지 대기
    Sleep    3s
    # 여기에 실제 앱의 메인 화면 요소를 확인하는 로직 추가
    # 예: Page Should Contain Element    id=mainScreen

앱 네비게이션 테스트
    [Documentation]    앱 내 네비게이션 동작을 테스트합니다
    [Tags]    navigation
    Log    네비게이션 테스트 시작
    # 예제: 특정 버튼 클릭
    # Wait For Element And Click    accessibility_id=menuButton
    # Sleep    2s
    # Wait For Element And Click    accessibility_id=backButton
    Log    네비게이션 테스트 완료

텍스트 입력 테스트
    [Documentation]    텍스트 입력 필드에 대한 테스트를 수행합니다
    [Tags]    input
    Log    텍스트 입력 테스트 시작
    # 예제: 텍스트 필드에 입력
    # Wait For Element And Input Text    accessibility_id=searchField    테스트 텍스트
    # Sleep    2s
    Log    텍스트 입력 테스트 완료

스와이프 제스처 테스트
    [Documentation]    스와이프 제스처 동작을 테스트합니다
    [Tags]    gesture
    Log    스와이프 테스트 시작
    Swipe Down
    Sleep    1s
    Swipe Up
    Sleep    1s
    Log    스와이프 테스트 완료

앱 상태 확인
    [Documentation]    앱의 현재 상태를 확인합니다
    [Tags]    status
    Log    앱 상태 확인 시작
    # 앱이 포그라운드에 있는지 확인
    ${current_activity}=    Get Current Package
    Log    현재 패키지: ${current_activity}
    Log    앱 상태 확인 완료


