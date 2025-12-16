*** Settings ***
Documentation    마케팅 팝업 요소 ID 검증 테스트
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py
Resource    ../resources/verify_elements.robot

Suite Setup    Open iOS App
Suite Teardown    Close iOS App

*** Variables ***
# Flo 앱 요소 ID
${MARKETING_POPUP_CLOSE}    22000000-0000-0000-0806-000000000000

*** Test Cases ***
마케팅 팝업 요소 ID 검증
    [Documentation]    마케팅 팝업 닫기 버튼의 요소 ID가 올바른지 검증합니다
    [Tags]    verification    debug
    Log    ========================================
    Log    마케팅 팝업 요소 ID 검증 테스트
    Log    ========================================
    
    # 앱 로드 대기
    Log    앱 로드 대기 중... (3초)
    Sleep    3s
    
    # 마케팅 팝업 요소 ID 검증
    ${popup_exists}=    Verify Marketing Popup Element    ${MARKETING_POPUP_CLOSE}
    
    # 결과 출력
    Run Keyword If    ${popup_exists}
    ...    Log    ✅ 검증 성공: 마케팅 팝업 닫기 버튼이 화면에 보입니다
    ...    ELSE
    ...    Log    ⚠️ 검증 실패: 마케팅 팝업 닫기 버튼이 화면에 보이지 않습니다
    
    # 화면 소스 전체 확인 (선택사항)
    Log    화면 소스 확인 중...
    ${source}=    Get Page Source
    Log    화면 소스 길이: ${source.__len__()} 문자
    Log    (상세 내용은 log.html에서 확인하세요)
    
    # 스크린샷 저장
    Capture Page Screenshot    popup_verification_result.png
    
    Log    ========================================
    Log    검증 완료
    Log    ========================================

현재 화면의 모든 요소 확인
    [Documentation]    현재 화면의 모든 요소를 확인합니다 (디버깅용)
    [Tags]    debug    verification
    Log    ========================================
    Log    현재 화면의 모든 요소 확인
    Log    ========================================
    
    Sleep    3s
    
    # 모든 요소 ID 목록 확인
    List All Element IDs
    
    # 화면 소스 저장
    ${source}=    Get Page Source
    Log    화면 소스 확인 완료 (log.html에서 상세 내용 확인)
    
    # 스크린샷 저장
    Capture Page Screenshot    all_elements_screen.png
    
    Log    ========================================
    Log    요소 확인 완료
    Log    ========================================


