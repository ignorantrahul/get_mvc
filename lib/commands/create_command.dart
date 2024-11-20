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
    final type = results['type'] as String?;
    final name = results['name'] as String?;

    if (type == null || name == null) {
      logger.w('Please provide file type and name.');
      return;
    }

    if (type == 'all') {
      _createAllFiles(name);
      return;
    }

    switch (type) {
      case 'model':
        _createFile('models', '${name}_model', generateDummyModel: true);
        break;
      case 'view':
        _createFile('views', '${name}_view', generateDummyView: true);
        break;
      case 'controller':
        _createFile('controllers', '${name}_controller',
            generateDummyController: true);
        break;
      case 'binding':
        _createFile('bindings', '${name}_binding', generateDummyBinding: true);
        break;
      case 'service':
        _createFile('services', '${name}_service');
        break;
      default:
        logger.e('Unknown file type: $type');
    }
  }

  void _createAllFiles(String name) {
    _createFile('models', '${name}_model', generateDummyModel: true);
    _createFile('views', '${name}_view', generateDummyView: true);
    _createFile('controllers', '${name}_controller',
        generateDummyController: true);
    _createFile('bindings', '${name}_binding', generateDummyBinding: true);
    _createFile('services', '${name}_service');
    logger.i('All files for $name created successfully.');
  }

  void _createFile(String directoryPath, String name,
      {bool generateDummyModel = false,
      bool generateDummyView = false,
      bool generateDummyController = false,
      bool generateDummyBinding = false}) {
    final fileName = '${name.toLowercaseWithUnderscores()}.dart';
    final directory = Directory(directoryPath);

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final file = File('${directory.path}/$fileName');
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
