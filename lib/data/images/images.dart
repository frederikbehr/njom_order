import 'package:image_picker/image_picker.dart';

class Images {
  final ImagePicker _picker = ImagePicker();

  Future<String?> getImage(bool useCamera) async {
    final XFile? image = await _picker.pickImage(source: useCamera? ImageSource.camera : ImageSource.gallery);
    if (image != null) return image.path;
    return null;
  }

}