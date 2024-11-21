### GET_MVC (GETM)

A Laravel Artisan-like command-line interface (CLI) tool for generating Model-View-Controller (MVC) files in Flutter projects using GetX. This Dart-based command-line tool helps in creating and organizing Flutter applications by generating models, views, controllers, bindings, and services. It automates the generation of boilerplate code following the MVC pattern and GetX standards.

## Features

- **Generate MVC Components:** Easily create models, views, controllers, bindings, and services with a single command.
- **Complete File Structure:** Automatically organizes your application files into directories for efficient management.
- **Dummy Data Generation:** Includes placeholder content for each file type to kickstart your development process.

---

## Installation

To use `get_mvc`, you need to have Dart installed.
You can install it via [Flutter](https://flutter.dev/docs/get-started/install)
or [Dart SDK](https://dart.dev/get-dart).

Once Dart is installed, you can install `get_mvc` globally using the following command:

```bash
flutter pub global activate get_mvc
```

or from Github clone the repository and run the following commands:

```bash
git clone <repository-url>
cd <repository-directory>
dart run
```

Make sure to add the Dart SDK's bin directory to your system's PATH to access the installed binaries.

### Project Structure

```
project/
    ├── lib/
    │   ├── app/
    │   │   ├── models/
    │   │   │   └── home/
    │   │   │   │   └── home_model.dart
    │   │   │   └──.....
    │   │   ├── views/
    │   │   │   └── home/
    │   │   │   │   └── home_view.dart
    │   │   │   └──....
    │   │   ├── controllers/
    │   │   │   └── home/
    │   │   │   │   └── home_controller.dart
    │   │   │   └──....
    │   │   ├── bindings/
    │   │   │   └── home/
    │   │   │   │   └── home_binding.dart
    │   │   │   └──....
    │   │   ├── services/
    │   │   │   └── home/
    │   │   │   │   └── home_service.dart
    │   │   │   └──....
    │   │   └── main.dart
    └── README.md
```

## Usage

### Commands Overview

#### Create a Component:

```bash
getm create type=name
```

Where:

- `type`: The type of file to create (model, view, controller, binding, service, or all)
- `name`: The base name for your component

#### Initialize a New Flutter Project:

```bash
getm new --project=my_app --org=com.example
```

This command creates a new Flutter project with the specified name and organization.

#### Display Help Information:

```bash
getm help
```

### Examples

1. Generate a Model:

```bash
getm create model=user
```

This creates `lib/app/models/user/user_model.dart` with a dummy model structure.

2. Generate All Components:

```bash
getm create all=home
```

This creates the following files in their respective directories:

- `lib/app/models/home/home_model.dart`
- `lib/app/views/home/home_view.dart`
- `lib/app/controllers/home/home_controller.dart`
- `lib/app/bindings/home/home_binding.dart`
- `lib/app/services/home/home_service.dart`

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
