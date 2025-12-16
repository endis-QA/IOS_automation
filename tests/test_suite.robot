*** Settings ***
Documentation    iOS 테스트 스위트
Library    AppiumLibrary
Resource    ../resources/keywords.robot
Variables    ../resources/variables.py

Suite Setup    Open iOS App
Suite Teardown    Close iOS App
Test Teardown    Take Screenshot On Failure
Test Timeout    5 minutes

*** Variables ***
# Flo 앱 요소
# ⚠️ 중요: Element ID는 앱 재시작 시마다 변경될 수 있습니다!
# 기본적으로 accessibility_id를 사용하고, 필요한 경우에만 XPath를 사용합니다.

# 마케팅 팝업 닫기 버튼 (accessibility-id)
${MARKETING_POPUP_CLOSE}    닫기


# 미니 플레이어 재생 버튼 (accessibility_id)
${MINI_PLAYER_PLAY_BUTTON}    MiniMusicPanel_playButton
${MINI_PLAYER_SONG_TITLE}    MarqueeLabelView_label
${MINI_PLAYER_SONG_TITLE_XPATH}    //XCUIElementTypeStaticText[@name="MarqueeLabelView_label"]
${MINI_PLAYER_PLAYLIST_BUTTON}    MiniMusicPanel_listButton


# 빠른 재생 메인 플레이어 요소 (accessibility_id)
${QUICK_MAIN_PLAYER_PLAY_BUTTON}    MainMusicControlBoard_playButton
${QUICK_MAIN_PLAYER_NEXT_BUTTON}    MainMusicControlBoard_forwardButton
${QUICK_MAIN_PLAYER_PREV_BUTTON}    MainMusicControlBoard_backwardButton
${QUICK_MAIN_PLAYER_SHUFFLE_BUTTON}    MainMusicControlBoard_shuffleButton
${QUICK_MAIN_PLAYER_MENU_BUTTON}    재생환경 설정 버튼
${QUICK_MAIN_PLAYER_CLOSE_BUTTON}    닫기 버튼
${QUICK_MAIN_PLAYER_SONG_INFO_LABEL}    MarqueeLabelView_label
${QUICK_MAIN_PLAYER_LYRICS_BUTTON}    두줄 가사 보기
${QUICK_MAIN_PLAYER_LIKE_BUTTON}    좋아요 버튼
${QUICK_MAIN_PLAYER_MORE_BUTTON}    더보기 버튼
${QUICK_MAIN_PLAYER_REPEAT_BUTTON}    MainMusicControlBoard_repeatButton

# 일반 재생 메인 플레이어 요소 (accessibility_id) - 일반 값
${MAIN_PLAYER_PLAY_BUTTON}    MainMusicControlBoard_playButton
${MAIN_PLAYER_NEXT_BUTTON}    MainMusicControlBoard_forwardButton
${MAIN_PLAYER_PREV_BUTTON}    MainMusicControlBoard_backwardButton
${MAIN_PLAYER_SHUFFLE_BUTTON}    MainMusicControlBoard_shuffleButton
${MAIN_PLAYER_MENU_BUTTON}    재생환경 설정 버튼
${MAIN_PLAYER_CLOSE_BUTTON}    닫기 버튼
${MAIN_PLAYER_SONG_INFO_LABEL}    MarqueeLabelView_label
${MAIN_PLAYER_LYRICS_BUTTON}    두줄 가사 보기
${MAIN_PLAYER_LIKE_BUTTON}    좋아요 버튼
${MAIN_PLAYER_MORE_BUTTON}    더보기 버튼
${MAIN_PLAYER_REPEAT_BUTTON}    MainMusicControlBoard_repeatButton

# 홈 화면 오늘 발매 음악 영역
${HOME_TODAY_RELEASE_MORE_XPATH}     //XCUIElementTypeButton[@name="오늘 발매 음악"]
${TODAY_RELEASE_PLAY_ALL_BUTTON}     전체듣기

# 재생목록(플레이리스트) 화면 요소
# - 가능한 경우 accessibility_id 사용
# - 리스트 항목 등은 XPath 사용
${PLAYLIST_SETTINGS_BUTTON}            재생목록 설정화면으로 이동합니다.
${PLAYLIST_CLOSE_BUTTON}               PlaylistContainerView_closeButton
${PLAYLIST_QUICK_TAB}                  빠른선곡
${PLAYLIST_SERVER_SAVE_BUTTON}         재생목록을 서버에 저장합니다.
${PLAYLIST_EDIT_BUTTON}                편집
${PLAYLIST_SEARCH_BUTTON}              재생목록에서 검색합니다.
${PLAYLIST_LOAD_LIBRARY_BUTTON}        보관함 내리스트를 재생목록으로 불러옵니다.
${PLAYLIST_SELECT_TRACK_BUTTON}        원하는 곡을 선택해서 들을 수 있습니다.
${PLAYLIST_FIRST_TRACK_XPATH}          (//XCUIElementTypeButton[@name="앨범"])[1]
${PLAYLIST_FIRST_TRACK_MORE_XPATH}     (//XCUIElementTypeButton[@name="더보기"])[1]
${PLAYLIST_CLEANUP_BUTTON}             btn clean up
${PLAYLIST_NOW_PLAYING_IMAGE_XPATH}    //XCUIElementTypeOther[@name="TabBarItemView_my"]/XCUIElementTypeOther

*** Test Cases ***
# 테스트 케이스를 여기에 작성하세요

# 테스트 1 - 마케팅 팝업 닫기 및 미니플레이어 곡명 선택 (임시 비활성화)
#    [Documentation]    앱 실행 → 마케팅 팝업 닫기 → 미니플레이어 song title 선택
#    [Tags]    smoke    popup    mini_player
#    
#    Sleep    5s
#
#    Log    1단계: 마케팅 팝업 닫기 시도
#    Wait For Element And Click With Retry    accessibility_id=${MARKETING_POPUP_CLOSE}    timeout=10    max_retries=2
#
#    Log    팝업 닫기 후 화면 업데이트 대기 중...
#    Sleep    5s
#
#    Log    2단계: 미니플레이어 곡명(song title) 선택
#    Log    미니플레이어 곡명 요소 찾기 시도 (xpath=${MINI_PLAYER_SONG_TITLE_XPATH})
#    Wait For Element And Click With Retry    xpath=${MINI_PLAYER_SONG_TITLE_XPATH}    timeout=20    max_retries=3
#    Log    ✅ 미니플레이어 곡명 클릭 성공
#
#    Log    ✅ 테스트 1 완료: 마케팅 팝업 닫기 → 미니플레이어 곡명 선택

테스트 2 - 오늘 발매 음악 전체듣기 및 메인 플레이어 제어
    [Documentation]    앱 실행 → 오늘 발매 음악 상세 진입 → 전체 듣기 → 미니 플레이어 리스트 버튼 → 재생중인 곡 이미지 선택 → 일반 재생 메인 플레이어 다음곡/이전곡/셔플 제어
    [Tags]    smoke    today_release    main_player

    Sleep    5s

    Log    1단계: 홈 화면 오늘 발매 음악 상세 진입
    Log    오늘 발매 음악 더보기 요소 찾기 시도 (xpath=${HOME_TODAY_RELEASE_MORE_XPATH})
    Wait For Element And Click With Retry    xpath=${HOME_TODAY_RELEASE_MORE_XPATH}    timeout=20    max_retries=3
    Log    ✅ 오늘 발매 음악 상세 화면 진입 성공

    Log    2단계: 오늘 발매한 음악 전체듣기 버튼 선택
    Log    전체듣기 버튼 요소 찾기 시도 (accessibility_id=${TODAY_RELEASE_PLAY_ALL_BUTTON})
    Wait For Element And Click With Retry    accessibility_id=${TODAY_RELEASE_PLAY_ALL_BUTTON}    timeout=20    max_retries=3
    Log    ✅ 오늘 발매한 음악 전체듣기 버튼 클릭 성공

    Log    재생 시작 후 화면/플레이어 상태 안정화 대기...
    Sleep    5s

    Log    3단계: 미니 플레이어 리스트 버튼 선택
    Log    미니 플레이어 리스트 버튼 요소 찾기 시도 (accessibility_id=${MINI_PLAYER_PLAYLIST_BUTTON})
    Wait For Element And Click With Retry    accessibility_id=${MINI_PLAYER_PLAYLIST_BUTTON}    timeout=20    max_retries=3
    Log    ✅ 미니 플레이어 리스트 버튼 클릭 성공

    Log    4단계: 재생중인 곡 이미지 선택
    Log    재생중인 곡 이미지 요소 찾기 시도 (xpath=${PLAYLIST_NOW_PLAYING_IMAGE_XPATH})
    Wait For Element And Click With Retry    xpath=${PLAYLIST_NOW_PLAYING_IMAGE_XPATH}    timeout=20    max_retries=3
    Log    ✅ 재생중인 곡 이미지 클릭 성공

    Log    메인 플레이어 화면 전환 대기...
    Sleep    5s

    Log    5단계: 일반 재생 메인 플레이어 다음곡 재생
    Log    메인 플레이어 다음곡 버튼 찾기 시도 (accessibility_id=${MAIN_PLAYER_NEXT_BUTTON})
    Wait For Element And Click With Retry    accessibility_id=${MAIN_PLAYER_NEXT_BUTTON}    timeout=20    max_retries=3
    Log    ✅ 메인 플레이어 다음곡 재생 버튼 클릭 성공

    Sleep    3s

    Log    6단계: 일반 재생 메인 플레이어 이전 곡 재생
    Log    메인 플레이어 이전곡 버튼 찾기 시도 (accessibility_id=${MAIN_PLAYER_PREV_BUTTON})
    Wait For Element And Click With Retry    accessibility_id=${MAIN_PLAYER_PREV_BUTTON}    timeout=20    max_retries=3
    Log    ✅ 메인 플레이어 이전곡 재생 버튼 클릭 성공

    Sleep    3s

    Log    7단계: 일반 재생 메인 플레이어 셔플 버튼 선택
    Log    메인 플레이어 셔플 버튼 찾기 시도 (accessibility_id=${MAIN_PLAYER_SHUFFLE_BUTTON})
    Wait For Element And Click With Retry    accessibility_id=${MAIN_PLAYER_SHUFFLE_BUTTON}    timeout=20    max_retries=3
    Log    ✅ 메인 플레이어 셔플 버튼 클릭 성공

    Log    ✅ 테스트 2 완료: 오늘 발매 음악 상세 진입 → 전체듣기 → 리스트 버튼 → 재생중인 곡 이미지 → 다음곡/이전곡/셔플 제어
