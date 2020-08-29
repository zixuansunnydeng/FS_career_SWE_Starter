class Restaurant {
  String resName;
  String priceRange;
  String cuisineType1;
  String cuisineType2;
  double rating;
  String resImage;
  String address;
  double lat;
  double lng;

  Restaurant(
      String resName,
      String priceRange,
      String cuisineType1,
      String cuisineType2,
      double rating,
      String resImage,
      String address,
      double lat,
      double lng) {
    this.resName = resName;
    this.priceRange = priceRange;
    this.cuisineType1 = cuisineType1;
    this.cuisineType2 = cuisineType2;
    this.rating = rating;
    this.resImage = resImage;
    this.address = address;
    this.lat = lat;
    this.lng = lng;
  }
}
