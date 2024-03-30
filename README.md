````markdown
# get_mcv

A command-line interface (CLI) tool for generating Model-View-Controller (MVC) files in Flutter projects.

## Installation

To use `get_mcv`, you need to have Dart installed. You can install it via [Flutter](https://flutter.dev/docs/get-started/install) or [Dart SDK](https://dart.dev/get-dart).

Once Dart is installed, you can install `get_mcv` globally using the following command:

```bash
dart pub global activate get_mcv
```
````

Make sure to add the Dart SDK's bin directory to your system's PATH to access the installed binaries.

## Usage

`get_mcv` provides commands to generate various MVC files in your Flutter project:

### Create a New File

```bash
get_mcv create -t <type> -n <name>
```

Replace `<type>` with the file type (model, view, controller, service) and `<name>` with the file name (without extension).

### Generate Authentication Files

```bash
get_mcv create --auth
```

This command generates authentication-related files including an authentication controller, login view, and signup view.

### Help

```bash
get_mcv help
```

Displays usage information and lists all available commands.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

```

```
