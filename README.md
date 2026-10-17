# 도드다 (Dodda)

STT와 TTS를 활용해 한국어 발음 연습을 돕는 Flutter 앱입니다. 이중모음 단어와 동화 문장을 읽고, 음성 인식 결과를 기준 텍스트와 비교해 발음 연습과 오답 복습을 할 수 있습니다.

## 주요 기능

- 이중모음 단어별 발음 연습
- 동화 문장 읽기와 음성 인식 결과 확인
- 기준 텍스트와 인식 결과를 어절 단위로 비교하고 다른 부분 표시
- TTS로 기준 문장 듣기
- Firestore에 학습 및 오답 기록 저장, 복습 화면 제공
- Firebase Authentication 기반 사용자 계정

## 기술 스택

- Flutter, Dart
- `speech_to_text`, Provider, `flutter_tts`
- Firebase Authentication, Cloud Firestore

## 실행

Flutter SDK를 설치한 뒤 저장소 루트에서 실행합니다.

```sh
flutter pub get
flutter run
```

Firebase 프로젝트 설정이 필요합니다. Android Firebase 설정은 `android/app/google-services.json`에 연결되어 있습니다.

## 참고

현재 발음 비교는 음성 인식 결과 텍스트를 기준 문장과 대조하는 방식입니다. 코드에는 영상 기반 입 모양 분석 기능이 포함되어 있지 않습니다.
