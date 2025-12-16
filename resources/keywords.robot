*** Settings ***
Documentation    iOS 테스트를 위한 공통 키워드 정의
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Open iOS App
    [Documentation]    iOS 앱을 시작합니다 (연결 안정성을 위해 재시도 로직 포함)
    [Arguments]    ${server_url}=http://localhost:4723    ${max_retries}=3
    ${caps}=    Evaluate    __import__('resources.appium_config').appium_config.get_ios_capabilities()
    
    FOR    ${i}    IN RANGE    ${max_retries}
        Log    Appium 세션 생성 시도 중... (${i + 1}/${max_retries})
        ${success}=    Run Keyword And Return Status    Open Application    ${server_url}    &{caps}
        Return From Keyword If    ${success}
        
        Run Keyword If    ${i} < ${max_retries - 1}
        ...    Log    ⚠️ 연결 실패, 3초 후 재시도...
        Run Keyword If    ${i} < ${max_retries - 1}
        ...    Sleep    3s
    END
    
    Fail    Appium 세션 생성 실패 (최대 재시도 횟수 초과). WDA가 실행 중인지 확인하세요.

Close iOS App
    [Documentation]    현재 실행 중인 iOS 앱을 종료합니다 (연결 오류 시에도 안전하게 처리)
    Log    Appium 세션 종료 시도 중...
    ${close_success}=    Run Keyword And Return Status    Close Application
    Run Keyword If    not ${close_success}
    ...    Log    ⚠️ 세션 종료 중 오류 발생 (연결이 끊어진 것으로 보입니다. 무시하고 계속 진행)
    ...    ELSE
    ...    Log    ✅ Appium 세션 정리 완료

Take Screenshot On Failure
    [Documentation]    테스트 실패 시 스크린샷을 저장합니다 (연결이 끊어진 경우 실패해도 계속 진행)
    ${screenshot_success}=    Run Keyword And Return Status    Run Keyword If Test Failed    Capture Page Screenshot    ${TEST_NAME}_failure.png
    Run Keyword If    not ${screenshot_success}    Log    ⚠️ 스크린샷 저장 실패 (연결이 끊어진 것으로 보입니다)

Wait For Element And Click Or Fail
    [Documentation]    요소가 나타날 때까지 대기한 후 클릭합니다. 실패 시 테스트를 중단합니다.
    [Arguments]    ${locator}    ${timeout}=30    ${error_message}=요소를 클릭하지 못했습니다: ${locator}
    ${success}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Run Keyword If    not ${success}    Fail    ${error_message}
    ${click_success}=    Run Keyword And Return Status    Click Element    ${locator}
    Run Keyword If    not ${click_success}    Fail    클릭 실패: ${locator}

Wait For Element With Retry
    [Documentation]    요소가 나타날 때까지 대기합니다. 연결 오류 시 재시도합니다.
    [Arguments]    ${locator}    ${timeout}=20    ${max_retries}=2
    FOR    ${i}    IN RANGE    ${max_retries}
        ${success}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
        Return From Keyword If    ${success}    True
        Run Keyword If    ${i} < ${max_retries - 1}    Log    ⚠️ 연결 오류로 인한 실패, 재시도 중... (${i + 1}/${max_retries})
        Run Keyword If    ${i} < ${max_retries - 1}    Sleep    2s
    END
    Fail    요소를 찾을 수 없습니다 (연결 오류 가능성): ${locator}

Wait For Element And Input Text
    [Documentation]    요소가 나타날 때까지 대기한 후 텍스트를 입력합니다
    [Arguments]    ${locator}    ${text}    ${timeout}=30
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Input Text    ${locator}    ${text}

Scroll To Element
    [Documentation]    지정된 요소까지 스크롤합니다
    [Arguments]    ${locator}
    ${element}=    Get Webelement    ${locator}
    Execute Script    mobile: scroll    {"direction": "down", "element": "${element}"}

Swipe Down
    [Documentation]    화면을 아래로 스와이프합니다
    Swipe    500    1000    500    500

Swipe Up
    [Documentation]    화면을 위로 스와이프합니다
    Swipe    500    500    500    1000

Check Step And Fail If Error
    [Documentation]    키워드 실행 결과를 확인하고 실패 시 테스트를 중단합니다
    [Arguments]    ${keyword}    @{args}    &{kwargs}
    ${status}=    Run Keyword And Return Status    ${keyword}    @{args}    &{kwargs}
    Run Keyword If    not ${status}    Fail    실패: ${keyword}

Wait For Popup And Close
    [Documentation]    팝업이 나타날 때까지 대기한 후 닫기 버튼을 클릭합니다. ID가 가변적이므로 name/XPath 기반으로만 동작합니다.
    [Arguments]    ${button_name}=${EMPTY}    ${wait_time}=0    ${timeout}=10    ${force_close}=False    ${skip_on_failure}=True    ${xpath_pattern}=${EMPTY}
    Run Keyword If    ${wait_time} > 0    Log    팝업이 나타날 때까지 ${wait_time}초 대기 중...
    Run Keyword If    ${wait_time} > 0    Sleep    ${wait_time}s
    
    Log    팝업 닫기 버튼 확인 중... (ID는 가변적이므로 name/XPath만 사용)
    
    # 방법 1: 버튼 name으로 찾기 (가장 안정적) - 우선 시도
    ${popup_closed_by_name}=    Set Variable    False
    Run Keyword If    '${button_name}' != '${EMPTY}'
    ...    ${popup_closed_by_name}=    Try Close Popup By Name    ${button_name}    ${timeout}    ${force_close}    ${skip_on_failure}
    
    # 방법 2: XPath로 부모 버튼 찾기 - name 실패 시 시도
    ${popup_closed_by_xpath}=    Set Variable    False
    Run Keyword If    not ${popup_closed_by_name}
    ...    ${popup_closed_by_xpath}=    Try Close Popup By XPath    ${timeout}    ${force_close}    ${skip_on_failure}    ${xpath_pattern}
    
    ${popup_closed}=    Evaluate    ${popup_closed_by_name} or ${popup_closed_by_xpath}
    
    # 팝업이 실제로 닫혔는지 최종 확인 (name/XPath만 사용, ID는 사용하지 않음)
    Sleep    1s
    ${still_visible_by_name}=    Set Variable    False
    Run Keyword If    '${button_name}' != '${EMPTY}'
    ...    ${still_visible_by_name}=    Run Keyword And Return Status    Element Should Be Visible    name=${button_name}    timeout=2
    
    ${still_visible_by_xpath}=    Set Variable    False
    ${xpath_to_check}=    Set Variable    ${EMPTY}
    Run Keyword If    '${xpath_pattern}' != '${EMPTY}'
    ...    ${xpath_to_check}=    Set Variable    ${xpath_pattern}
    ...    ELSE
    ...    ${xpath_to_check}=    Set Variable    //XCUIElementTypeButton[.//XCUIElementTypeStaticText[@name="닫기"]]
    Run Keyword If    not ${still_visible_by_name}
    ...    ${still_visible_by_xpath}=    Run Keyword And Return Status    Element Should Be Visible    ${xpath_to_check}    timeout=2
    
    ${still_visible}=    Evaluate    ${still_visible_by_name} or ${still_visible_by_xpath}
    ${actually_closed}=    Evaluate    not ${still_visible}
    
    # 결과 로깅 (간단한 메시지)
    Run Keyword If    ${actually_closed}    Log    팝업 닫기 성공
    Run Keyword If    not ${actually_closed}    Log    팝업 닫기 실패 (여전히 보입니다)
    
    Return From Keyword    ${actually_closed}

Try Close Popup By Name
    [Documentation]    버튼 name으로 팝업 닫기 시도
    [Arguments]    ${button_name}    ${timeout}    ${force_close}    ${skip_on_failure}
    Log    방법 1: 버튼 name으로 찾기: ${button_name}
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    name=${button_name}    timeout=${timeout}
    ${closed}=    Set Variable    False
    Run Keyword If    ${visible}
    ...    ${closed}=    Close Popup Button With Retry    name=${button_name}    ${timeout}    ${force_close}    ${skip_on_failure}
    Run Keyword If    ${closed}    Log    버튼 닫기 성공
    Run Keyword If    ${visible} and not ${closed}    Log    버튼 닫기 실패
    Return From Keyword    ${closed}

# Try Close Popup By ID 키워드는 제거됨 (ID가 가변적이므로 사용하지 않음)

Try Close Popup By XPath
    [Documentation]    XPath로 부모 버튼 찾아서 팝업 닫기 시도
    [Arguments]    ${timeout}    ${force_close}    ${skip_on_failure}    ${xpath_pattern}=${EMPTY}
    Log    방법 2: XPath로 부모 버튼 찾기
    ${xpath}=    Set Variable    ${EMPTY}
    Run Keyword If    '${xpath_pattern}' != '${EMPTY}'
    ...    ${xpath}=    Set Variable    ${xpath_pattern}
    ...    ELSE
    ...    ${xpath}=    Set Variable    //XCUIElementTypeButton[.//XCUIElementTypeStaticText[@name="닫기"]]
    Log    사용할 XPath: ${xpath}
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${xpath}    timeout=${timeout}
    ${closed}=    Set Variable    False
    Run Keyword If    ${visible}
    ...    ${closed}=    Close Popup Button With Retry    ${xpath}    ${timeout}    ${force_close}    ${skip_on_failure}
    Run Keyword If    ${closed}    Log    XPath 닫기 성공
    Run Keyword If    ${visible} and not ${closed}    Log    XPath 닫기 실패
    Return From Keyword    ${closed}

Close Popup Button With Retry
    [Documentation]    팝업 닫기를 여러 번 시도합니다. 실제로 닫혔는지 확인합니다. (locator는 id, name, xpath 등 가능)
    [Arguments]    ${locator}    ${timeout}=10    ${force_close}=False    ${skip_on_failure}=True
    Log    ========================================
    Log    팝업 닫기 시도 시작 (locator: ${locator})
    Log    ========================================
    
    # 스크린샷 저장 (디버깅용)
    Capture Page Screenshot    popup_before_close.png
    
    # 팝업 닫기 시도
    ${closed}=    Close Popup Button    ${locator}    ${timeout}    ${force_close}
    
    # 추가 확인: 팝업이 실제로 사라졌는지 확인
    Sleep    1s
    ${still_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}    timeout=2
    ${actually_closed}=    Evaluate    not ${still_visible}
    
    # 실패 시 처리 (간단한 메시지)
    Run Keyword If    not ${actually_closed} and ${skip_on_failure}
    ...    Log    팝업을 닫지 못했습니다. 테스트를 계속 진행합니다.
    Run Keyword If    not ${actually_closed} and not ${skip_on_failure}
    ...    Fail    팝업을 닫지 못했습니다.
    
    # 최종 스크린샷
    Capture Page Screenshot    popup_after_close.png
    
    Log    ========================================
    Log    팝업 닫기 시도 완료 (결과: ${actually_closed})
    Run Keyword If    not ${actually_closed}    Log    ⚠️ 주의: 팝업이 여전히 화면에 보일 수 있습니다!
    Log    ========================================
    
    Return From Keyword    ${actually_closed}

Close Popup Button
    [Documentation]    팝업 닫기 버튼을 여러 방법으로 클릭 시도합니다. 실패 시 대체 방법도 시도합니다. (locator는 name, xpath 등 사용, ID는 가변적이므로 사용하지 않음)
    [Arguments]    ${locator}    ${timeout}=10    ${force_close}=False
    Log    팝업 닫기 버튼 클릭 시도 중... (locator: ${locator})
    
    # 방법 1: 일반 클릭 시도
    Log    방법 1: 일반 클릭 시도...
    ${click_success}=    Run Keyword And Return Status    Click Element    ${locator}
    Run Keyword If    ${click_success}    Log    ✅ 방법 1 성공: 일반 클릭
    Sleep    0.5s
    ${popup_closed}=    Check If Popup Closed    ${locator}
    Return From Keyword If    ${popup_closed}    True
    
    # 방법 2: 탭 제스처로 클릭 시도
    Log    방법 2: 탭 제스처로 클릭 시도...
    Try Tap Element    ${locator}
    Sleep    0.5s
    ${popup_closed}=    Check If Popup Closed    ${locator}
    Return From Keyword If    ${popup_closed}    True
    
    # 방법 3: JavaScript로 클릭 시도
    Log    방법 3: JavaScript로 클릭 시도...
    ${js_success}=    Run Keyword And Return Status    Execute Script    arguments[0].click();    ARGUMENTS    ${locator}
    Run Keyword If    ${js_success}    Log    ✅ JavaScript 클릭 실행
    Sleep    0.5s
    ${popup_closed}=    Check If Popup Closed    ${locator}
    Return From Keyword If    ${popup_closed}    True
    
    # 방법 4: 여러 번 클릭 시도 (최대 3회)
    Log    방법 4: 여러 번 클릭 시도...
    FOR    ${i}    IN RANGE    3
        Log    ${i+1}번째 클릭 시도...
        ${click_attempt}=    Run Keyword And Return Status    Click Element    ${locator}
        Sleep    0.5s
        ${popup_closed}=    Check If Popup Closed    ${locator}
        Return From Keyword If    ${popup_closed}    True
    END
    
    # 방법 5: 강제 닫기 (force_close=True인 경우)
    Run Keyword If    ${force_close}
    ...    Force Close Popup    ${locator}
    
    # 최종 확인
    ${still_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}    timeout=2
    Run Keyword If    ${still_visible}
    ...    Log    ❌ 팝업이 여전히 보입니다. 모든 방법을 시도했지만 닫을 수 없습니다.
    ...    ELSE
    ...    Log    ✅ 팝업이 닫혔습니다
    
    Return From Keyword    not ${still_visible}

Check If Popup Closed
    [Documentation]    팝업이 닫혔는지 확인합니다 (locator는 id, name, xpath 등 가능)
    [Arguments]    ${locator}
    ${still_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}    timeout=1
    ${closed}=    Evaluate    not ${still_visible}
    Run Keyword If    ${closed}    Log    ✅ 팝업 닫기 버튼이 사라졌습니다 (팝업이 닫힌 것으로 보입니다)
    Run Keyword If    not ${closed}    Log    ⚠️ 팝업 닫기 버튼이 여전히 보입니다 (팝업이 닫히지 않았습니다)
    Return From Keyword    ${closed}

Force Close Popup
    [Documentation]    팝업을 강제로 닫기 시도합니다 (뒤로가기, 스와이프 등)
    [Arguments]    ${close_button_id}
    Log    강제 닫기 시도 중...
    
    # 방법 1: 뒤로가기 버튼 (iOS에서는 사용 불가, Android용)
    # Press Keycode    4    # Android BACK key
    
    # 방법 2: 화면 밖 클릭 (팝업 외부 영역)
    Log    화면 외부 영역 탭 시도...
    Tap    50    50
    Sleep    0.5s
    
    # 방법 3: 스와이프 다운으로 팝업 닫기
    Log    스와이프 다운으로 팝업 닫기 시도...
    Swipe    500    300    500    800
    Sleep    0.5s
    
    # 방법 4: ESC 키 (시뮬레이터에서만 작동할 수 있음)
    # Press Keycode    111    # ESC key
    
    Log    강제 닫기 시도 완료

Try Tap Element
    [Documentation]    탭 제스처로 요소를 클릭 시도합니다 (locator는 id, name, xpath 등 가능)
    [Arguments]    ${locator}
    Log    탭 제스처로 클릭 시도 중...
    ${element}=    Get Webelement    ${locator}
    ${location}=    Get Location    ${element}
    ${size}=    Get Size    ${element}
    
    # 요소의 중앙 좌표 계산
    ${x}=    Evaluate    ${location['x']} + ${size['width']} / 2
    ${y}=    Evaluate    ${location['y']} + ${size['height']} / 2
    
    Log    요소 위치: x=${x}, y=${y}
    Tap    ${x}    ${y}
    Sleep    0.5s
    Log    ✅ 탭 제스처 실행 완료

Get Element Information
    [Documentation]    요소의 상세 정보를 가져옵니다 (디버깅용, locator는 id, name, xpath 등 가능)
    [Arguments]    ${locator}
    ${element}=    Get Webelement    ${locator}
    ${location}=    Get Location    ${element}
    ${size}=    Get Size    ${element}
    ${enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${locator}
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}
    
    ${info}=    Catenate    SEPARATOR=\n
    ...    위치: x=${location['x']}, y=${location['y']}
    ...    크기: width=${size['width']}, height=${size['height']}
    ...    활성화: ${enabled}
    ...    보임: ${visible}
    
    Return From Keyword    ${info}

Get Element Details
    [Documentation]    요소의 상세 정보를 출력합니다 (디버깅용)
    [Arguments]    ${locator}
    Log    요소 상세 정보 확인 중...
    
    ${element}=    Get Webelement    ${locator}
    ${location}=    Get Location    ${element}
    ${size}=    Get Size    ${element}
    ${enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${locator}
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}
    ${text}=    Run Keyword And Return Status    Get Text    ${locator}
    
    Log    --- 요소 상세 정보 ---
    Log    위치: x=${location['x']}, y=${location['y']}
    Log    크기: width=${size['width']}, height=${size['height']}
    Log    활성화: ${enabled}
    Log    보임: ${visible}
    
    Run Keyword If    ${text}    Log    텍스트: ${text}
    Run Keyword If    not ${text}    Log    텍스트: (없음)

Wait For Element And Click With Retry
    [Documentation]    요소가 나타날 때까지 대기한 후 클릭합니다. 연결 오류 시 재시도합니다.
    [Arguments]    ${locator}    ${timeout}=20    ${max_retries}=3
    ${max_index}=    Evaluate    ${max_retries} - 1
    FOR    ${i}    IN RANGE    ${max_retries}
        ${visible_success}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
        ${is_not_last}=    Evaluate    ${i} < ${max_index}
        Run Keyword If    not ${visible_success} and ${is_not_last}
        ...    Log    ⚠️ 요소를 찾을 수 없습니다, 재시도... (${i + 1}/${max_retries})
        Continue For Loop If    not ${visible_success}
        
        ${click_success}=    Run Keyword And Return Status    Click Element    ${locator}
        Run Keyword If    ${click_success}    Return From Keyword
        Run Keyword If    ${click_success}    Log    ✅ 요소 클릭 성공
        
        Run Keyword If    ${is_not_last}
        ...    Log    ⚠️ 클릭 실패 또는 연결 오류, 2초 후 재시도... (${i + 1}/${max_retries})
        Run Keyword If    ${is_not_last}
        ...    Sleep    2s
    END
    
    # 모든 재시도 실패 시 에러
    Fail    요소를 클릭할 수 없습니다 (연결 오류 또는 요소를 찾을 수 없음): ${locator}

