enum BuildFlavor { production, development, testing }

BuildEnvironment? get env => _env;
BuildEnvironment? _env;

class BuildEnvironment {
  final String marinerUrl;
  final String apiPath;
  final String baseUrl;
  final String environment;

  bool debuggable = true;
  bool loggable = true;

  BuildEnvironment._init({
    required this.marinerUrl,
    required this.baseUrl,
    required this.apiPath,
    required this.environment,
  }) {
    switch (environment) {
      case 'dev':
      case 'uat':
      case 'beta':
      case 'qa':
        debuggable = true;
        loggable = true;
        break;
      case 'prod':
      default:
        debuggable = false;
        loggable = false;
        break;
    }
  }

  static void init({
    required String marinerUrl,
    required String apiPath,
    required String baseUrl,
    required String environment,
  }) =>
      _env ??= BuildEnvironment._init(
        marinerUrl: marinerUrl,
        apiPath: apiPath,
        baseUrl: baseUrl,
        environment: environment,
      );
}
