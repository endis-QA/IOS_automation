# 테스트 실행 전 체크리스트

## ✅ 설정 완료 확인

- [x] Bundle ID 설정: `kr.co.musicmates.radio`
- [x] 디바이스 UDID 설정: `00008120-001119160168C01E`
- [x] iOS 버전 설정: `17.4.1`
- [x] 디바이스 이름 설정: `iPhone 14 pro`

## 📋 테스트 실행 전 필수 준비사항

### 1. Python 의존성 설치 확인
```bash
pip install -r requirements.txt
```

### 2. Appium 서버 설치 확인
```bash
appium --version
```

설치되어 있지 않다면:
```bash
npm install -g appium
npm install -g @appium/ios-driver
```

### 3. 디바이스 연결 확인
- iPhone 14 pro 디바이스가 USB로 연결되어 있는지 확인
- 디바이스가 잠금 해제되어 있는지 확인
- "이 컴퓨터를 신뢰하시겠습니까?" 메시지에 "신뢰" 선택

### 4. 앱 설치 확인
- `kr.co.musicmates.radio` 앱이 디바이스에 설치되어 있는지 확인

### 5. Appium 서버 실행
**새 터미널 창에서 실행**:
```bash
appium
```

서버가 `http://localhost:4723`에서 실행되는지 확인

## 🚀 테스트 실행

### 간단한 테스트 실행
```bash
robot tests/test_suite.robot
```

### 전체 테스트 실행
```bash
robot tests/
```

### 스크립트로 실행
```bash
./run_tests.sh
```

## 🐛 문제 해결

### Appium 서버 연결 오류
- Appium 서버가 실행 중인지 확인
- 포트 4723이 사용 가능한지 확인

### 디바이스 연결 오류
- 디바이스가 연결되어 있고 잠금 해제되었는지 확인
- Xcode에서 디바이스가 인식되는지 확인 (Window → Devices and Simulators)

### Bundle ID 오류
- Bundle ID가 정확한지 확인
- 앱이 디바이스에 설치되어 있는지 확인


