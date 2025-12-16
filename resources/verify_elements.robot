*** Settings ***
Documentation    요소 ID 검증을 위한 키워드
Library    AppiumLibrary

*** Keywords ***
Verify Element ID Exists
    [Documentation]    요소 ID가 존재하는지 확인하고 상세 정보를 출력합니다
    [Arguments]    ${element_id}    ${timeout}=10
    Log    ========================================
    Log    요소 ID 검증 시작: ${element_id}
    Log    ========================================
    
    # 현재 화면 소스 가져오기
    Log    현재 화면 소스 확인 중...
    ${source}=    Get Page Source
    Log    화면 소스 길이: ${source.__len__()} 문자
    
    # 요소 ID가 소스에 포함되어 있는지 확인
    ${id_in_source}=    Evaluate    '${element_id}' in '''${source}'''
    Run Keyword If    ${id_in_source}    Log    ✅ 요소 ID가 화면 소스에 존재합니다
    Run Keyword If    not ${id_in_source}    Log    ❌ 요소 ID가 화면 소스에 없습니다!
    
    # 요소가 보이는지 확인
    Log    요소가 화면에 보이는지 확인 중...
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    id=${element_id}    timeout=${timeout}
    Run Keyword If    ${visible}    Log    ✅ 요소가 화면에 보입니다
    Run Keyword If    not ${visible}    Log    ❌ 요소가 화면에 보이지 않습니다 (타임아웃: ${timeout}초)
    
    # 요소 정보 가져오기
    Run Keyword If    ${visible}    Get Element Details    id=${element_id}
    
    # 스크린샷 저장
    Capture Page Screenshot    element_verification_${element_id}.png
    
    Log    ========================================
    Log    요소 ID 검증 완료
    Log    ========================================
    
    [Return]    ${visible}

Get Element Details
    [Documentation]    요소의 상세 정보를 가져와서 출력합니다
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

Find Element ID In Source
    [Documentation]    화면 소스에서 특정 요소 ID를 찾아서 출력합니다
    [Arguments]    ${element_id}
    Log    화면 소스에서 요소 ID 검색 중: ${element_id}
    
    ${source}=    Get Page Source
    ${id_in_source}=    Evaluate    '${element_id}' in '''${source}'''
    
    Run Keyword If    ${id_in_source}
    ...    Extract Element Info From Source    ${source}    ${element_id}
    ...    ELSE
    ...    Log    ❌ 요소 ID를 찾을 수 없습니다
    
    [Return]    ${id_in_source}

Extract Element Info From Source
    [Documentation]    소스에서 요소 정보를 추출합니다
    [Arguments]    ${source}    ${element_id}
    Log    요소 ID가 소스에 존재합니다. 주변 컨텍스트 확인 중...
    
    # 요소 ID 주변 텍스트 추출 (간단한 방법)
    ${index}=    Evaluate    '''${source}'''.find('${element_id}')
    Run Keyword If    ${index} >= 0
    ...    Log    요소 ID 위치: 인덱스 ${index}
    
    # 주변 컨텍스트 출력 (앞뒤 200자)
    ${start}=    Evaluate    max(0, ${index} - 200)
    ${end}=    Evaluate    min(len('''${source}'''), ${index} + len('${element_id}') + 200)
    ${context}=    Evaluate    '''${source}'''[${start}:${end}]
    Log    주변 컨텍스트:
    Log    ${context}

List All Element IDs
    [Documentation]    현재 화면의 모든 요소 ID를 찾아서 출력합니다 (디버깅용)
    Log    ========================================
    Log    현재 화면의 모든 요소 ID 검색 중...
    Log    ========================================
    
    ${source}=    Get Page Source
    Log    화면 소스 길이: ${source.__len__()} 문자
    
    # UUID 패턴 찾기 (예: 22000000-0000-0000-F505-000000000000)
    # 간단한 방법으로 id 속성이 있는 요소 찾기
    Log    요소 ID 패턴 검색 중...
    
    # 스크린샷 저장
    Capture Page Screenshot    all_elements_screen.png
    
    Log    ========================================
    Log    화면 소스를 log.html에서 확인하거나 Get Page Source로 확인하세요
    Log    ========================================

Verify Marketing Popup Element
    [Documentation]    마케팅 팝업 요소 ID를 검증합니다
    [Arguments]    ${popup_close_id}
    Log    ========================================
    Log    마케팅 팝업 요소 ID 검증
    Log    ========================================
    
    # 앱이 로드될 때까지 대기
    Sleep    3s
    
    # 요소 ID 검증
    ${exists}=    Verify Element ID Exists    ${popup_close_id}    timeout=10
    
    # 추가 확인: 팝업이 실제로 보이는지
    Run Keyword If    ${exists}
    ...    Log    ✅ 마케팅 팝업 닫기 버튼이 화면에 보입니다
    ...    ELSE
    ...    Log    ⚠️ 마케팅 팝업 닫기 버튼이 화면에 보이지 않습니다 (팝업이 나타나지 않았을 수 있음)
    
    # 화면 소스에서 확인
    ${in_source}=    Find Element ID In Source    ${popup_close_id}
    
    Log    ========================================
    Log    검증 결과:
    Log    - 화면에 보임: ${exists}
    Log    - 소스에 존재: ${in_source}
    Log    ========================================
    
    [Return]    ${exists}


