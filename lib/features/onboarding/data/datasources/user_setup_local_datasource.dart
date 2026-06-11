import 'package:image_picker/image_picker.dart';
import 'package:snapmap/core/error/exception.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

abstract class UserSetupLocalDatasource {
  Future<String?> pickFromGallery();
  Future<String?> pickFromCamera();
  Future<LocationEntity> getCurrentLocation();
}

class UserSetupLocalDatasourcesImpl implements UserSetupLocalDatasource {
  final ImagePicker imagePicker;

  UserSetupLocalDatasourcesImpl({required this.imagePicker});
  @override
  Future<String?> pickFromGallery() async {
    try {
      final XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxHeight: 512,
        maxWidth: 512,
      );
      return file?.path;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> pickFromCamera() async {
    try {
      final XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 512,
        maxHeight: 512,
        preferredCameraDevice: CameraDevice.front,
      );
      return file?.path;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LocationEntity> getCurrentLocation() async {
    try {
      // check service
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw ServerException('Location services disabled');

      // check / request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        throw ServerException('Location services disabled');
      }

      // get coordinates
      final position = await Geolocator.getCurrentPosition();

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final place = placemarks.first;

      return LocationEntity(
        cityName: '${place.locality}, ${place.administrativeArea}',

        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
