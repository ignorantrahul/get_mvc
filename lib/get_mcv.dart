#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser();

  parser.addCommand(
      'create',
      (commandParser) {
        commandParser.addOption('type',
            abbr: 't', help: 'File type (model, view, controller, service)');
        commandParser.addOption('name',
            abbr: 'n', help: 'File name (without extension)');
        commandParser.addFlag('auth',
            abbr: 'a', help: 'Generate authentication files');
      } as ArgParser?);

  parser.addCommand('help');

  final results = parser.parse(arguments);
  final command = results.command;

  if (command != null) {
    switch (command.name) {
      case 'create':
        _handleCreateCommand(command);
        break;
      case 'help':
        _showHelp(parser);
        break;
      default:
        print('Unknown command: ${command.name}');
    }
  } else {
    print('Usage: get_mcv <command>');
    print(parser.usage);
  }
}

void _handleCreateCommand(ArgResults command) {
  final fileType = command['type'];
  final fileName = command['name'];
  final generateAuth = command['auth'];

  if (generateAuth != null && generateAuth) {
    _generateAuth();
    return;
  }

  if (fileType == null || fileName == null) {
    print('Missing required arguments: -t <type> -n <name>');
    return;
  }

  switch (fileType) {
    case 'model':
      _generateModel(fileName);
      break;
    case 'view':
      _generateView(fileName);
      break;
    case 'controller':
      _generateController(fileName);
      break;
    case 'service':
      _generateService(fileName);
      break;
    case 'all':
      _generateAll(fileName);
      break;
    default:
      print('Unknown file type: $fileType');
  }
}

void _showHelp(ArgParser parser) {
  print('Usage: get_mcv <command>');
  print('Available commands:');
  print(parser.usage);
}

void _generateModel(String fileName) {
  final content = '''
class ${_toTitleCase(fileName)} {
  // Add your properties and methods here
}
''';

  _createFile('models', '$fileName.dart', content);
}

void _generateView(String fileName) {
  final content = '''
import 'package:flutter/material.dart';

class ${_toTitleCase(fileName)} extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_toTitleCase(fileName)}'),
      ),
      body: Center(
        child: Text('${_toTitleCase(fileName)}'),
      ),
    );
  }
}
''';

  _createFile('views', '$fileName.dart', content);
}

void _generateController(String fileName) {
  final content = '''
import 'package:get/get.dart';

class ${_toTitleCase(fileName)} extends GetxController {
  // Add your logic here
}
''';

  _createFile('controllers', '$fileName.dart', content);
}

void _generateService(String fileName) {
  final content = '''
import 'package:get/get.dart';

class ${_toTitleCase(fileName)} extends GetxService {
  // Add your logic here
}
''';

  _createFile('services', '$fileName.dart', content);
}

void _generateAll(String fileName) {
  _generateModel(fileName);
  _generateView(fileName);
  _generateController(fileName);
  _generateService(fileName);
}

void _generateAuth() {
  _generateController('auth');
  _generateView('login');
  _generateView('signup');
}

void _createFile(String folder, String fileName, String content) {
  final file = File('lib/$folder/$fileName');
  file.createSync(recursive: true);
  file.writeAsStringSync(content);
  print('File generated: $fileName');
}

String _toTitleCase(String str) {
  return str.substring(0, 1).toUpperCase() + str.substring(1);
}
