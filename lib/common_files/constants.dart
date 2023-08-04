import '../models/address.dart';

final List<String> routesWorker = [
  '/jobs',
  '/myJobs',
  '/companyChat',
  '/workerProfile',
  '/login'
];
final List<String> routesCompany = [
  '/workers',
  '/myJobPosts',
  '/companyChat',
  'companyProfile',
  '/login'
];

String getAddressesInStringFormat(List<Address>? addresses) {
  if (addresses == null || addresses.isEmpty) {
    return 'No addresses available';
  }
  return addresses.map((address) => address.displayAddress()).join('\n');
}
