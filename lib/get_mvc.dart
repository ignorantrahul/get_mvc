import 'package:args/args.dart';
import 'dart:io';

void main(List<String> arguments) {
  final parser = ArgParser();

  parser.addFlag('help',
      abbr: 'h', negatable: false, help: 'Display usage information');

  parser.addCommand('create')
    ..addOption('type',
        abbr: 't', help: 'File type (model, view, controller, service)')
    ..addOption('name', abbr: 'n', help: 'File name (without extension)')
    ..addFlag('auth', abbr: 'a', help: 'Generate authentication files');

  parser.addCommand('new')
    ..addOption('name', abbr: 'n', help: 'Project name')
    ..addOption('org', abbr: 'o', help: 'Organisation name');

  final results = parser.parse(arguments);

  if (results['help']) {
    _showHelp(parser);
    return;
  }

  final command = results.command;
  if (command != null) {
    switch (command.name) {
      case 'create':
        _handleCreateCommand(command);
        break;
      case 'new':
        _handleNewProjectCommand(command);
        break;
      default:
        print('Unknown command: ${command.name}');
        _showHelp(parser);
    }
  } else {
    print('Please provide a command. Use --help for usage information.');
  }
}

void _handleCreateCommand(ArgResults command) {
  final type = command['type'];
  final name = command['name'];

  if (type == null || name == null) {
    print('Please provide file type and name.');
    return;
  }

  switch (type) {
    case 'model':
      _createFile('models', name);
      break;
    case 'view':
      _createFile('views', name);
      break;
    case 'controller':
      _createFile('controllers', name);
      break;
    case 'service':
      _createFile('services', name);
      break;
    default:
      print('Unknown file type: $type');
  }
}

void _createFile(String category, String name) {
  final fileName = '$name.dart';
  final directory = Directory('lib/app/$category/$name');

  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  final file = File('${directory.path}/$fileName');
  file.createSync();

  print('File created: ${file.path}');
}

void _handleNewProjectCommand(ArgResults command) {
  final projectName = command['name'];
  final orgName = command['org'];

  if (projectName == null) {
    print('Please provide a project name.');
    return;
  }

  _createFlutterProject(projectName, orgName);
}

void _createFlutterProject(String projectName, String orgName) {
  final projectDirectory = Directory(projectName);

  if (!projectDirectory.existsSync()) {
    projectDirectory.createSync();
  }

  Directory.current = projectDirectory;

  List<String> flutterArgs = ['create'];
  flutterArgs.add('--org');
  flutterArgs.add(orgName);
  flutterArgs.add(projectName);

  final process = Process.runSync('flutter', flutterArgs);
  if (process.exitCode == 0) {
    _restructureProject();
    print('Flutter project created successfully.');
  } else {
    print('Error creating Flutter project.');
  }
}

void _restructureProject() {
  final appDirectory = Directory('lib/app');

  // Create necessary directories
  final directories = ['api', 'database', 'themes'];
  for (var dir in directories) {
    final directory = Directory('${appDirectory.path}/$dir');
    if (!directory.existsSync()) {
      directory.createSync();
    }
  }

  // Create sample files
  _createFile('api', 'api_service');
  _createFile('database', 'database_helper');
  _createFile('themes', 'app_theme');
}

void _showHelp(ArgParser parser) {
  print('Usage: get_mcv <command>');
  print('Available commands:');
  print('  create - Create files for different components');
  print('  new project - Initialize a new Flutter project');
  print(
      'Use "get_mcv <command> --help" for more information about a specific command.');
}
