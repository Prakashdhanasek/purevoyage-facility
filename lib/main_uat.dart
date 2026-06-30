import 'package:facility_management/main.dart';
import 'package:facility_management/services/env.dart';

void main() {
  BuildEnvironment.init(
    marinerUrl: 'https://uatfacilitymanagementapi.prod-app.in',
    apiPath: '/api',
    baseUrl: 'https://uatfacilitymanagementbaseapi.prod-app.in',
    environment: 'uat',
  );
  assert(env != null);
  mainInit();
}
