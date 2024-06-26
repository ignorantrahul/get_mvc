### GET_mvc

A Larvel artisan command-line interface (CLI) tool for generating Model-View-Controller (MVC) files in Flutter projects using GetX.

## Installation

To use `get_mvc`, you need to have Dart installed.
You can install it via [Flutter](https://flutter.dev/docs/get-started/install)
or [Dart SDK](https://dart.dev/get-dart).

Once Dart is installed, you can install `get_mvc` globally using the following command:

```bash
flutter pub global activate get_mvc
```

Make sure to add the Dart SDK's bin directory to your system's PATH to access the installed binaries.

### Project Structure

```
project/
├── lib/app/
    │   ├── controllers/
    │   │   ├── auth.dart
    │   │   └── example.dart
    │   ├── models/
    │   │   └── example.dart
    │   ├── services/
    │   │   └── example.dart
    │   └── views/
    │       ├── example.dart
    │       ├── login.dart
    │       └── signup.dart
├── pubspec.yaml
└── README.md
```

## Usage

`get_mvc` provides commands to generate various MVC files in your Flutter project:

## Create a New Project

```bash
get_mvc new --n <project_name> --org <organisation_name>
```

### Create a New File

```bash
get_mvc create -t <type> -n <name>
```

Replace `<type>` with the file type (model, view, controller, service) and `<name>` with the file name (without extension).

### Generate Authentication Files

```bash
get_mvc create --auth
```

This command generates authentication-related files including an authentication controller, login view, and signup view.

### Help

```bash
get_mvc help
```

Displays usage information and lists all available commands.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
