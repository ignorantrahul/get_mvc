### GET_mvc

A Larvel artisan command-line interface (CLI) tool for generating Model-View-Controller (MVC) files in Flutter projects using GetX.This is Dart-based command-line tool for creating and organizing Flutter plugin components such as models, views, controllers, bindings, and services. This tool automates the generation of boilerplate code following the MVC pattern and GetX standards.


## Features

- **Generate MVC Components:** Easily create models, views, controllers, bindings, and services with a single command.
- **Complete File Structure:** Automatically organizes your plugin files into directories for efficient management.
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
    ├── 📁 lib
        ├── 📁 app
        │    ├── 📁 bindings
        │    │    ├── app_binding.dart
        │    │    ├── ...
        │    ├── 📁 controllers
        │    │    ├── app_controller.dart
        │    │    ├── ...
        │    ├── 📁 models
        │    │    ├── app_model.dart
        │    │    ├── ...
        │    ├── 📁 services
        │    │    ├── app_service.dart
        │    │    ├── ...
        │    ├── 📁 views
        │    │    ├── app_view.dart
        │    │    ├── ...
        │    ├── 📁 utils
        │    │    ├── logger.dart
        │    │    ├── ...
        ├── main.dart
    ├── pubspec.yaml
    └── README.md
```

## Usage
Usage
Commands Overview
Create a Component:

```bash
get_mvc create --type=<file-type> --name=<file-name>
```
--type: The type of file to create. Options: model, view, controller, binding, service, or all.
--name: The base name for the file (without the extension).
Initialize a New Flutter Project:

```bash
get_mvc new --project=<project-name> --org=<organization-name>
```
Display Help Information:

```bash
get_mvc help
```
Examples
Generate a Model:

```bash
get_mvc create --type=model --name=user
```
This command creates a user_model.dart file with a dummy model structure.

Generate All Components for a Home Page:

```bash
get_mvc create --type=all --name=home
```
This command creates:

home_model.dart
home_view.dart
home_controller.dart
home_binding.dart
home_service.dart
Initialize a New Flutter Project:

```bash
get_mvc new --project=my_plugin --org=com.example
```
This command creates a new Flutter project with the specified name and organization.

`get_mvc` provides commands to generate various MVC files in your Flutter project:

<!-- ## Create a New Project

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
get_mvc help -->
```

Displays usage information and lists all available commands.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
