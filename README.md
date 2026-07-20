# Project Clover MVP

건강 기록과 AI 코칭을 한곳에서 경험하는 Green Healing 콘셉트의 Flutter MVP입니다.

## 포함 화면

- 로컬 데모 로그인
- 오늘의 홈 대시보드
- 체중 기록 및 7일 변화 그래프
- 식단 기록과 영양 요약
- 운동 기록과 활동 요약
- 로컬 데이터를 조합한 AI 코치 피드백

모든 데이터는 앱 메모리에 저장되는 더미 데이터입니다. 앱을 완전히 종료하면 초기화됩니다.

## 실행

Flutter 3.22 이상을 설치한 뒤 프로젝트 루트에서 실행합니다.

```bash
flutter pub get
flutter create . --platforms=android,ios,web
flutter run
```

`flutter create`가 기존 `lib` 파일을 덮어쓰지는 않지만, 실행 전 Git 변경 내역을 확인하는 것을 권장합니다. 플랫폼 폴더가 이미 만들어진 뒤에는 다음부터 `flutter run`만 사용하면 됩니다.

## 구조

```text
lib/
  main.dart                 앱 시작점과 테마
  models/clover_models.dart 기록 데이터 모델
  data/demo_store.dart      로컬 더미 데이터 상태
  screens/                  로그인 및 MVP 화면
  widgets/clover_widgets.dart 공통 카드와 입력 UI
```

## 다음 연동 지점

- `DemoStore`를 Supabase Repository로 교체
- 로그인 화면을 Supabase Auth와 연결
- `AiCoachScreen`의 로컬 규칙을 서버의 OpenAI API 호출로 교체
- 식단 이미지 업로드를 Supabase Storage와 연결
