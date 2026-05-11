import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String cityName;
  final double latitude;
  final double longitude;

  const LocationEntity({
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [cityName, latitude, longitude];
}
