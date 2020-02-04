# Flutter ATM

Test task ATM on the Flutter.

## Getting Started
### Step 1
Go to project root and execute the following command in console to get the required dependencies:
```dart
flutter pub get packages
```
### Step 2
This project uses inject library that works with code generation, execute the following command to generate files:
```dart
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

## Languages, libraries and tools used
### Libraries
* [Flutter BLoC](https://pub.dev/packages/flutter_bloc)
* [Super Enum](https://pub.dev/packages/super_enum)
* Dependency Injection with [Get It](https://pub.dev/packages/get_it)
* Animations with [Simple Animations](https://pub.dev/packages/simple_animations)

### Generators
* [Super Enum Generator](https://pub.dev/packages/super_enum_generator)

## Architecture
This project follows Google architecture guidelines that are based on BLoC.

## Project structure

- core
- features
    - atm
      - data
        - models
        - providers
        - repositories
      - domain
        - providers
        - repositories
      - presentation
        - bloc
        - pages
        - widgets

## References
* [Flutter](https://flutter.dev/)
* [Effective Dart](https://dart.dev/guides/language/effective-dart)

## License

This source is released under the [MIT License](https://github.com/Holofox/flutter-atm/blob/master/LICENSE).