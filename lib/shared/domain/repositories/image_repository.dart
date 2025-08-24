import 'dart:io';

import 'package:yegna_gebeya/shared/domain/models/image_type.dart';

abstract class ImageRepository {
  Future<String> uploadImage({
    required File image,
    required ImageType imageType,
  });
}
