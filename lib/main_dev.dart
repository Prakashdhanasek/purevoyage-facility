import 'package:facility_management/main.dart';
import 'package:facility_management/services/env.dart';

void main() {
  BuildEnvironment.init(
    marinerUrl: 'https://facilitymanagementapi.prod-app.in',
    apiPath: '/api',
    baseUrl: 'https://facilitymanagementbaseapi.prod-app.in',
    environment: 'dev',
  );
  assert(env != null);
  mainInit();
}
