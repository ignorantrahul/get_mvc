import 'package:args/args.dart';
import 'package:get_mvc/commands/create_command.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class HelpCommand extends Command {
  @override
  void run(ArgResults results) {
    logger.i('Usage: get_mvc <command>');
    logger.i('Available commands:');
    logger.i('  create - Create files for different components');
    logger.i('  new - Initialize a new Flutter project');
    logger.i(
        'Use "get_mvc <command> --help" for more information about a specific command.');
  }
}
