// ignore_for_file: avoid_print

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

  parser
      .addCommand('new')
      .addOption('org', abbr: 'o', help: 'Organization name');

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

void _createFile(String directoryPath, String name) {
  final fileName = '$name.dart';
  final directory = Directory(directoryPath);

  // Ensure that the directory exists
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  final file = File('${directory.path}/$fileName');
  file.createSync();

  print('File created: ${file.path}');
}

void _handleNewProjectCommand(ArgResults command) {
  final projectName = command.rest[0];
  final orgName = command['org'];

  if (projectName == null) {
    print('Please provide a project name.');
    return;
  }

  _createFlutterProject(projectName, orgName);
}

void _createFlutterProject(String projectName, String orgName) {
  List<String> flutterArgs = ['create', projectName];

  if (orgName != null) {
    flutterArgs.add('--org');
    flutterArgs.add(orgName);
  }

  final process = Process.runSync('flutter', flutterArgs, runInShell: true);
  if (process.exitCode == 0) {
    _restructureProject(projectName);
    print('Flutter project created successfully.');
  } else {
    print('Error creating Flutter project.');
  }
}

void _restructureProject(String projectName) {
  final appDirectory = Directory('$projectName/lib/app');

  // Ensure that the project directory exists
  if (!appDirectory.existsSync()) {
    appDirectory.createSync(recursive: true);
  }

  // Create necessary directories
  final directories = ['api', 'database', 'themes'];
  for (var dir in directories) {
    final directoryPath = '${appDirectory.path}/$dir';
    final directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync();
    }

    // Create sample files
    _createFile(directoryPath, '${dir}_service');
  }

  print('Flutter project restructured successfully.');
}

void _showHelp(ArgParser parser) {
  print('Usage: get_mvc <command>');
  print('Available commands:');
  print('  create - Create files for different components');
  print('  new project - Initialize a new Flutter project');
  print(
      'Use "get_mvc <command> --help" for more information about a specific command.');
}
