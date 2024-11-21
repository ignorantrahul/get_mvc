import 'dart:io';

import 'package:args/args.dart';
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
          generateDummyBinding: type == 'binding',
          generateDummyService: type == 'service');
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
    _createFile('service', name, generateDummyService: true);
    logger.i('All files for $name created successfully.');
  }

  void _createFile(String type, String name,
      {bool generateDummyModel = false,
      bool generateDummyView = false,
      bool generateDummyController = false,
      bool generateDummyBinding = false,
      bool generateDummyService = false}) {
    final appDirectory = Directory('lib/app');
    final fileName = '${name.toLowercaseWithUnderscores()}_$type.dart';
    final directory = Directory('${type}s/$name');
    // No need to run createSync command multiple times insted using recursive: true
    final file = File('${appDirectory.path}/${directory.path}/$fileName');
    file.createSync(recursive: true);

    file.writeAsStringSync(
      generateDummyModel
          ? _generateDummyModel(name)
          : generateDummyView
              ? _generateDummyView(name)
              : generateDummyController
                  ? _generateDummyController(name)
                  : generateDummyBinding
                      ? _generateDummyBinding(name)
                      : generateDummyService
                          ? _generateDummyService(name)
                          : '',
    );

    logger.i('File created: ${file.path}');
  }

  String _generateDummyBinding(String name) {
    return '''
// [Bindings] should be extended or implemented. When using GetMaterialApp,
// all GetPages and navigation methods (like Get.to()) have a binding property
// that takes an instance of Bindings to manage the dependencies() (via Get.put()) 
//for the Route you are opening.

import 'package:get/get.dart';
import '../../controllers/$name/${name}_controller.dart';

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

  String _generateDummyController(String name) {
    return '''
// Controllers are responsible for:
// 1. Managing application's all business logic
// 2. Handling state management.
// 3. Acting as intermediaries between Models (data) and Views (UI)

import 'package:get/get.dart';

class ${name.toUpperCamelCase()}Controller extends GetxController {
  // Add your controller logic here
}
    ''';
  }

  String _generateDummyModel(String name) {
    return '''
// Models define the shape of your data using class properties
// They handle converting data to and from JSON format for storage
// They can include validation logic for the data

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
// Views are responsible for displaying the UI elements and handling user interactions.
// They work in conjunction with controllers to manage the application's state and business logic.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/$name/${name}_controller.dart';

class ${name.toUpperCamelCase()}View extends GetView<${name.toUpperCamelCase()}Controller> {
  const ${name.toUpperCamelCase()}View({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${name.toUpperCamelCase()}'),
      ),
      body: const Center(
        child: Text('This is the ${name.toUpperCamelCase()} view'),
      ),
    );
  }
}
''';
  }

  String _generateDummyService(String name) {
    return '''
// Unlike GetxController, which serves to control events on each of its pages,
// GetxService is not automatically disposed (nor can be removed with Get.delete()).
// It is ideal for situations where, once started, that service will remain in memory,
// such as Auth control for example. Only way to remove it is Get.reset().

import 'package:get/get.dart';

class ${name.toUpperCamelCase()}Service extends GetxService {
  // Add your service methods here
}
''';
  }
}
