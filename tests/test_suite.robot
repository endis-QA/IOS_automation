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
# 오직 accessibility_id만 사용합니다 (Inspector에서 확인한 accessibility-id 값)

# 마케팅 팝업 닫기 버튼 (accessibility-id)
${MARKETING_POPUP_CLOSE}    닫기


# 미니 플레이어 재생 버튼 (accessibility_id)
${MINI_PLAYER_PLAY_BUTTON}    MiniMusicPanel_playButton
${MINI_PLAYER_SONG_TITLE}    MarqueeLabelView_label
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

*** Test Cases ***
# 테스트 케이스를 여기에 작성하세요

테스트 1 - 마케팅 팝업 닫기 및 미니플레이어 곡명 선택
    [Documentation]    앱 실행 → 마케팅 팝업 닫기 → 미니플레이어 song title 선택
    [Tags]    smoke    popup    mini_player
    
    Sleep    5s

    Log    1단계: 마케팅 팝업 닫기 시도
    Wait For Element And Click With Retry    accessibility_id=${MARKETING_POPUP_CLOSE}    timeout=10    max_retries=2

    Log    팝업 닫기 후 화면 업데이트 대기 중...
    Sleep    5s

    Log    2단계: 미니플레이어 곡명(song title) 선택
    Log    미니플레이어 곡명 요소 찾기 시도 (accessibility_id=${MINI_PLAYER_SONG_TITLE})
    Wait For Element And Click With Retry    accessibility_id=${MINI_PLAYER_SONG_TITLE}    timeout=20    max_retries=3
    Log    ✅ 미니플레이어 곡명 클릭 성공

    Log    ✅ 테스트 1 완료: 마케팅 팝업 닫기 → 미니플레이어 곡명 선택
