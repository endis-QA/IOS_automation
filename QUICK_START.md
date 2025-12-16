# 빠른 시작 가이드

## ✅ 설치 완료 확인

- [x] Robot Framework 설치됨
- [x] robotframework-appiumlibrary 설치됨
- [x] Appium 서버 설치 확인됨
- [x] Bundle ID 설정: `kr.co.musicmates.radio`

## 🚀 테스트 실행 단계

### 1단계: Appium 서버 실행

**새 터미널 창을 열고** 다음 명령어 실행:

```bash
appium
```

서버가 `http://localhost:4723`에서 실행되는지 확인하세요.
콘솔에 "Appium REST http interface listener started on 0.0.0.0:4723" 메시지가 보이면 준비 완료입니다.

### 2단계: 디바이스 확인

- iPhone 14 pro가 USB로 연결되어 있는지 확인
- 디바이스가 잠금 해제되어 있는지 확인
- Xcode에서 디바이스 인식 확인 (Window → Devices and Simulators)

### 3단계: 테스트 실행

**이 터미널에서** (Appium 서버가 실행 중인 다른 터미널과는 별도):

```bash
# Python 모듈로 실행 (PATH 문제 해결)
python3 -m robot tests/test_suite.robot
```

또는

```bash
# robot 명령어 직접 실행 (PATH 설정된 경우)
robot tests/test_suite.robot
```

### 4단계: 결과 확인

테스트 실행 후:
- `report.html` - 테스트 결과 리포트
- `log.html` - 상세 로그
- `output.xml` - XML 형식 결과

브라우저에서 `report.html` 파일을 열어 결과를 확인하세요.

## 🐛 문제 해결

### Robot 명령어를 찾을 수 없는 경우

```bash
# Python 모듈로 실행 (권장)
python3 -m robot tests/test_suite.robot
```

### Appium 서버 연결 오류

1. Appium 서버가 실행 중인지 확인
2. 포트 4723이 사용 가능한지 확인: `lsof -i :4723`
3. 디바이스가 연결되어 있는지 확인

### Bundle ID 오류

- Bundle ID `kr.co.musicmates.radio`가 정확한지 확인
- 앱이 디바이스에 설치되어 있는지 확인
- Xcode Organizer에서 확인 (Cmd+Shift+2)

## 📝 다음 단계

테스트가 성공적으로 실행되면:

1. `tests/example_test.robot` 파일을 열어 더 많은 예제 확인
2. 실제 앱 요소에 맞게 테스트 케이스 작성
3. `resources/keywords.robot`에 커스텀 키워드 추가


