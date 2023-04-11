class MyGalleryResponse {
  MyGalleryResponse({
    required this.status,
    required this.images,
    required this.message,
  });

  late final String status;
  late final Images images;
  late final String message;

  MyGalleryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    images = Images.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = images.toJson();
    data['message'] = message;
    return data;
  }
}

class Images {
  Images({
    required this.imagesUrls,
  });

  late final List<String> imagesUrls;

  Images.fromJson(Map<String, dynamic> json) {
    imagesUrls = List.castFrom<dynamic, String>(json['images']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['images'] = imagesUrls;
    return data;
  }
}
