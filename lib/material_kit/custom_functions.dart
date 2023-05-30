
import '../backend/backend.dart';
import 'lat_lng.dart';

LatLng locationToLatLng(dynamic location) {
  // Json location{latitude, longitude} To (lat, lng)
  return LatLng(location['latitude'], location['longitude']);
}

bool isSearchMatched(
  String searchFor,
  List<String> searchInList,
) {
  for (String searchIn in searchInList) {
    if (searchIn.toUpperCase().contains(searchFor.toUpperCase())) {
      return true;
    }
  }
  return false;
}

List<double> getLatLng(LatLng location) {
  double latitude = location.latitude;
  double longitude = location.longitude;

  return [latitude, longitude];
}

int sumList(List<int> numbers) {
  int sum = 0;
  for (int number in numbers) {
    sum += number;
  }
  return sum;
}
