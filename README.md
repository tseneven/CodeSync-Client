# Основная информация
CodeSync Client - CRM-система для программистов с большим функционалом с формате мобильного приложения. 
Данный репозиторий содержит клиентскую часть приложения.
[Серверная часть](https://github.com/tseneven/CodeSync-Server)

# Стек технологий
Клиент написанный на Flutter/Dart с использованием Shared Preferences, RestAPI, WebSockets

# Архитектура

```
lib/
│
├── core/                   # Общие абстракции, интерфейсы, утилиты
│   ├── services/           # Абстракции (AuthService, ChatService)
│   ├── usecases/           # Логика приложения (чистая бизнес-логика)
│   └── utils/              # Хелперы, расширения
│
├── data/                   # Реализации абстракций (инфраструктура)
│   ├── datasources/        # Источники данных (SQLite, Web, IndexedDB и т.п.)
│   ├── repositories/       # Реализации интерфейсов, работающие с источниками
│   └── adapters/           # Платформенные адаптеры (веб, мобилки)
│
├── di/                     # Dependency Injection (локаторы, фабрики)
│   └── locator.dart        # Настройка get_it или другого DI
│
├── features/               # Фичи — изолированные модули (по функциональности)
│   ├── auth/
│   │   ├── presentation/   # UI и стейт
│   │   ├── domain/         # Интерфейсы и usecase
│   │   └── data/           # Реализации
│   ├── chat/
│   └── profile/
│
├── l10n/                   # Локализация
├── main.dart               # Точка входа
└── app.dart                # Обёртка MaterialApp, маршруты
```

# Документация
[Тык](https://drive.google.com/drive/folders/1XD7Qr-lko32kdyc2H8am07eKxcx4DfWZ?usp=sharing)
# Запуск 
Через точку входа main или 
```Dart
flutter run apk
```

