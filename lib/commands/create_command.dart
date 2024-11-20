import 'package:args/args.dart';
import 'dart:io';
import 'package:logger/logger.dart';
import '../utils/string_extensions.dart';

final Logger logger = Logger();

abstract class Command {
  void run(ArgResults results);
}

class CreateCommand extends Command {
  @override
  void run(ArgResults results) {
    if (results.rest.isEmpty) {
      logger.w('Please provide a valid command in the format: type=name');
      return;
    }

    final command = results.rest[0];

    // Split the input into type:name
    final parts = command.split('=');
    if (parts.length != 2) {
      logger.w('Invalid command format. Use type=name');
      return;
    }

    final type = parts[0]; // model, view, controller, etc.
    final name = parts[1]; // e.g., download, home, etc.

    if (type == 'all') {
      _createAllFiles(type, name);
      return;
    } else if (type == 'model' ||
        type == 'view' ||
        type == 'controller' ||
        type == 'binding' ||
        type == 'service') {
      _createFile(type, name,
          generateDummyModel: type == 'model',
          generateDummyView: type == 'view',
          generateDummyController: type == 'controller',
          generateDummyBinding: type == 'binding');
      return;
    } else {
      logger.e('Unknown file type: $type');
      return;
    }
  }

  void _createAllFiles(String type, String name) {
    _createFile('model', name, generateDummyModel: true);
    _createFile('view', name, generateDummyView: true);
    _createFile('controller', name, generateDummyController: true);
    _createFile('binding', name, generateDummyBinding: true);
    _createFile('service', name);
    logger.i('All files for $name created successfully.');
  }

  void _createFile(String type, String name,
      {bool generateDummyModel = false,
      bool generateDummyView = false,
      bool generateDummyController = false,
      bool generateDummyBinding = false}) {
    final appDirectory = Directory('lib/app');
    final fileName = '${name.toLowercaseWithUnderscores()}_$type.dart';
    final directory = Directory('${type}s');

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final file = File('${appDirectory.path}/${directory.path}/$fileName');
    file.createSync();

    file.writeAsStringSync(
      generateDummyModel
          ? _generateDummyModel(name)
          : generateDummyView
              ? _generateDummyView(name)
              : generateDummyController
                  ? _generateDummyController(name)
                  : generateDummyBinding
                      ? _generateDummyBinding(name)
                      : '',
    );

    logger.i('File created: ${file.path}');
  }

  String _generateDummyModel(String name) {
    return '''
class ${name.toUpperCamelCase()}Model {
  final int id;
  final String title;

  ${name.toUpperCamelCase()}Model({
    required this.id,
    required this.title,
  });

  factory ${name.toUpperCamelCase()}Model.fromJson(Map<String, dynamic> json) {
    return ${name.toUpperCamelCase()}Model(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
    ''';
  }

  String _generateDummyView(String name) {
    return '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ${name.toUpperCamelCase()}View extends GetView<${name.toUpperCamelCase()}Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${name.toUpperCamelCase()}')),
      body: Center(
        child: Text('This is the ${name.toUpperCamelCase()} view'),
      ),
    );
  }
}
    ''';
  }

  String _generateDummyController(String name) {
    return '''
import 'package:get/get.dart';

class ${name.toUpperCamelCase()}Controller extends GetxController {
  // Add your controller logic here
}
    ''';
  }

  String _generateDummyBinding(String name) {
    return '''
import 'package:get/get.dart';
import '../controllers/${name}_controller.dart';

class ${name.toUpperCamelCase()}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${name.toUpperCamelCase()}Controller>(
      () => ${name.toUpperCamelCase()}Controller(),
    );
  }
}
    ''';
  }
}
