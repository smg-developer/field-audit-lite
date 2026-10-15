# FieldAudit Lite

**An offline-capable field audit and inspection app built with Flutter.**

FieldAudit Lite is a portfolio project demonstrating Flutter development, Riverpod state management, Clean Architecture principles, and local data persistence. It allows users to create audits, manage inspection checklists, track completion progress, and retain changes locally across app restarts.

## Features

- **Audit Management:** Create and delete audits.
- **Interactive Checklists:** Mark individual checklist items as complete or incomplete.
- **Select All:** Complete or reset all checklist items with one action.
- **Progress Tracking:** View completed items and overall audit progress.
- **Local Persistence:** Save audit data using SharedPreferences so it remains available after restarting the app.
- **Reactive UI:** Reflect audit and checklist updates using Riverpod state management.
- **Empty State:** Display a helpful message when no audits exist.

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI development |
| Dart | Application programming language |
| Riverpod | State management and asynchronous data handling |
| SharedPreferences | Local persistence using JSON serialization |
| Material 3 | UI components and theming |

## Architecture

The project follows Clean Architecture principles to separate presentation, business models, and data access.

```text
lib/
├── core/
│   ├── constants/
│   ├── error/
│   └── utils/
├── features/
│   └── audits/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       └── presentation/
│           ├── providers/
│           ├── screens/
│           └── widgets/
└── main.dart
```

### Data Flow

```text
Presentation Layer
        ↓
Riverpod Notifier
        ↓
Repository Interface
        ↓
Repository Implementation
        ↓
Local Data Source
        ↓
SharedPreferences
```

This separation keeps UI components independent of storage implementation details and provides a foundation for introducing another data source in the future.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK compatible with your Flutter installation
- Android Studio or VS Code with Flutter support

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/smg-developer/field-audit-lite.git
   ```

2. Navigate to the project directory:

   ```bash
   cd field-audit-lite
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## Learning Objectives

This project explores practical Flutter development concepts, including:

- Structuring a feature using Clean Architecture principles.
- Separating domain entities from data models.
- Using repository abstractions for data access.
- Managing asynchronous application state with Riverpod.
- Serializing and deserializing JSON for local persistence.
- Keeping checklist data and completion counts consistent.
- Updating application state after create, update, and delete operations.
- Unit testing for business logic testing

## Current Scope

FieldAudit Lite currently uses local storage and does not require a backend or user authentication.

**Not implemented:** Firebase integration, cloud synchronization, authentication, and conflict resolution.

These are potential future enhancements rather than current capabilities.

## Future Enhancements

- Add automated widget tests.
- Improve error handling and input validation.
- Introduce a more robust local database if the data model grows.
- Explore Firebase integration and synchronization between local and remote data sources.

## Purpose

FieldAudit Lite is an independent learning and portfolio project built to demonstrate practical Flutter engineering, maintainable application structure, local persistence, and state management.

