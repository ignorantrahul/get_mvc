import 'package:args/args.dart';
import 'package:get_mvc/commands/create_command.dart';
import 'dart:io';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class NewProjectCommand extends Command {
  @override
  void run(ArgResults results) {
    final projectName = results['project'] as String?;
    final orgName = results['org'] as String?;

    if (projectName == null) {
      logger.w('Please provide a project name.');
      return;
    }

    _createFlutterProject(projectName, orgName);
  }

  void _createFlutterProject(String projectName, String? orgName) {
    List<String> flutterArgs = ['create', projectName];

    if (orgName != null) {
      flutterArgs.add('--org');
      flutterArgs.add(orgName);
    }

    final process = Process.runSync('flutter', flutterArgs, runInShell: true);
    if (process.exitCode == 0) {
      _restructureProject(projectName);
      logger.i('Flutter project created successfully.');
    } else {
      logger.e('Error creating Flutter project.');
    }
  }

  void _restructureProject(String projectName) {
    final appDirectory = Directory('$projectName/lib/app');

    if (!appDirectory.existsSync()) {
      appDirectory.createSync(recursive: true);
    }

    final directories = ['api', 'database', 'themes'];
    for (var dir in directories) {
      final directoryPath = '${appDirectory.path}/$dir';
      final directory = Directory(directoryPath);
      if (!directory.existsSync()) {
        directory.createSync();
      }
      _createFile(directoryPath, '${dir}_service');
    }

    logger.i('Flutter project restructured successfully.');
  }

  void _createFile(String directoryPath, String name) {
    final fileName = '$name.dart';
    final file = File('$directoryPath/$fileName');
    file.createSync();
  }
}
