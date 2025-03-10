# Forex & Ticker App

## Overview

The Forex & Ticker App is a Flutter application demonstrating a real-world implementation of Clean Architecture, WebSocket communication, REST API integration, and state management using Bloc. The app retrieves forex pairs data from a REST API and processes ticker data via WebSocket, leveraging dependency injection for clean and testable code.

## Table of Contents

- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Testing](#testing)
- [Modules Overview](#modules-overview)
  - [Forex Pairs Module](#forex-pairs-module)
  - [Ticker Module](#ticker-module)
- [Dependency Injection](#dependency-injection)
- [Error Handling](#error-handling)
- [Code Generation](#code-generation)
- [Conclusion](#conclusion)

## Architecture

This project follows Clean Architecture principles with a clear separation of concerns:

- **Data Layer:**  
  Implements data sources (REST API, WebSocket), response models, mappers, and repository implementations.
- **Domain Layer:**  
  Contains business logic, entities, repository interfaces, and use cases.
- **Presentation Layer:**  
  Consists of UI components and state management using Bloc.

State management is implemented with `flutter_bloc`, while network operations are performed using `dio` and `web_socket_channel`.

## Project Structure

## Installation

1. **Clone the repository:**

   ```bash
   git clone <repository_url>
   cd <repository_folder>

   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Generate Code (Dependency Injection & Mocks):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## Testing

The app includes comprehensive unit and widget tests. To run all tests:
```flutter pub run build_runner build --delete-conflicting-outputs

## Modules Overview

### Forex Pairs Module

- **Data Source:**  
  Uses `dio` to fetch forex pairs from a REST API.

- **Mapper:**  
  Converts JSON responses into `ForexPairResponse` objects.

- **Repository:**  
  Implements `ForexPairsRepository` (e.g., `ForexPairsRepositoryIMPL`) that manages data retrieval and mapping.

- **Use Case:**  
  `GetForexPairsUseCase` calls the repository and returns a list of forex pairs.

- **Tests:**  
  Unit tests verify the correct mapping of API responses, error handling, and use case functionality.

---

### Ticker Module

- **WebSocket Communication:**  
  `WebSocketDataSource` uses `web_socket_channel` to connect to a WebSocket endpoint.

- **Data Mapping:**  
  `TickerMapper` and `TickerListMapper` convert WebSocket JSON responses into domain entities (`TickerEntity`).

- **Repository:**  
  `WebSocketRepoImpl` implements `WebSocketRepository` to handle subscription, unsubscription, and stream processing.

- **Use Cases:**

  - `SubscribeUseCase` / `UnSubscribeUseCase` for managing subscriptions.
  - `GetStreamUseCase` to obtain the WebSocket stream.
  - `DisconnectUseCase` to close the connection.
  - `GetLatestTickerDataUseCase` to compute the latest ticker data.

- **Bloc:**  
  `TickerBloc` manages UI state transitions in response to WebSocket events, subscription initialization, errors, and ticker updates.

- **Tests:**  
  Bloc and use case tests ensure proper event handling and state emission.

  ## Dependency Injection

The app uses the `injectable` package for dependency injection. Classes are annotated with `@injectable` or `@singleton`, and the generated configuration files wire dependencies together automatically.

**Example usage:**

    ```dart
    @injectable
    class SubscribeUseCase {
    final WebSocketRepository _webSocketRepository;
    SubscribeUseCase(this._webSocketRepository);
    // ...
    }

## Error Handling

The application implements robust error handling to manage exceptions gracefully. Custom exceptions (e.g., `ForexException`, `UnKnownException`) are used throughout the codebase to capture and handle errors in network operations, data mapping, and subscription management. These exceptions are caught at appropriate layers (e.g., repositories, use cases, and Blocs) to ensure that the app remains stable and that errors are logged or rethrown as needed.

## Code Generation

Code generation is used for:

### Dependency Injection

Generated files (e.g., `*.config.dart`) from `injectable` are created automatically.

### Mocking

Mocks for unit tests are generated using `Mockito`. To generate mocks, run:

    ```flutter pub run build_runner build --delete-conflicting-outputs

## Conclusion

This project demonstrates a complete Flutter application using modern architecture patterns and best practices. The app covers network communication with REST APIs and WebSockets, state management with Bloc, dependency injection with Injectable, and comprehensive testing with bloc_test and Mockito.

For further details, please refer to inline documentation in the source code.
