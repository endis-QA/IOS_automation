*** Settings ***
Documentation    마케팅 팝업 닫기 버튼 찾기 테스트
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App

*** Variables ***
${MARKETING_POPUP_CLOSE_TEXT}    22000000-0000-0000-0806-000000000000

*** Test Cases ***
팝업 닫기 버튼 찾기
    [Documentation]    마케팅 팝업의 실제 닫기 버튼을 찾습니다
    [Tags]    debug    find_element
    Log    ========================================
    Log    팝업 닫기 버튼 찾기
    Log    ========================================
    
    Sleep    3s
    
    # 방법 1: 현재 요소 ID 확인
    Log    방법 1: 현재 요소 ID 확인
    ${text_visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${MARKETING_POPUP_CLOSE_TEXT}    timeout=5
    Run Keyword If    ${text_visible}    Log    ✅ 텍스트 요소가 보입니다: ${MARKETING_POPUP_CLOSE_TEXT}
    Run Keyword If    not ${text_visible}    Log    ❌ 텍스트 요소가 보이지 않습니다
    
    # 방법 2: 버튼 name으로 찾기
    Log    방법 2: 버튼 name으로 찾기
    ${button_by_name}=    Run Keyword And Return Status    Element Should Be Visible    name=NoticeInnerView_clos 기 버튼, 이중 탭 하면 팝업이 닫힙니다    timeout=5
    Run Keyword If    ${button_by_name}    Log    ✅ 버튼을 name으로 찾았습니다
    Run Keyword If    not ${button_by_name}    Log    ❌ 버튼을 name으로 찾을 수 없습니다
    
    # 방법 3: XPath로 부모 버튼 찾기
    Log    방법 3: XPath로 부모 버튼 찾기
    ${button_by_xpath}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//XCUIElementTypeButton[.//XCUIElementTypeStaticText[@name="닫기"]]    timeout=5
    Run Keyword If    ${button_by_xpath}    Log    ✅ 버튼을 XPath로 찾았습니다
    Run Keyword If    not ${button_by_xpath}    Log    ❌ 버튼을 XPath로 찾을 수 없습니다
    
    # 방법 4: 화면 소스에서 모든 버튼 찾기
    Log    방법 4: 화면 소스 확인
    ${source}=    Get Page Source
    ${has_close_button}=    Evaluate    'NoticeInnerView_clos' in '''${source}'''
    Run Keyword If    ${has_close_button}    Log    ✅ 화면 소스에 닫기 버튼이 있습니다
    Run Keyword If    not ${has_close_button}    Log    ❌ 화면 소스에 닫기 버튼이 없습니다
    
    # 스크린샷 저장
    Capture Page Screenshot    find_popup_button.png
    
    Log    ========================================
    Log    검색 완료
    Log    ========================================


