import 'package:args/args.dart';
import 'package:logger/logger.dart';
import 'commands/create_command.dart';
import 'commands/new_project_command.dart';
import 'commands/help_command.dart';

// Initialize the logger
final Logger logger = Logger();

void main(List<String> args) {
  final parser = ArgParser();

  parser.addCommand('create', ArgParser());

  parser.addCommand(
    'new',
    ArgParser()
      ..addOption('project', help: 'Project name')
      ..addOption('org', abbr: 'o', help: 'Organization name'),
  );

  parser.addCommand('help', ArgParser());

  final results = parser.parse(args);

  if (results.command == null) {
    logger.w('Please provide a command. Use --help for usage information.');
  } else {
    switch (results.command!.name) {
      case 'create':
        CreateCommand().run(results.command!);
        break;
      case 'new':
        NewProjectCommand().run(results.command!);
        break;
      case 'help':
        HelpCommand().run(results.command!);
        break;
    }
  }
}
