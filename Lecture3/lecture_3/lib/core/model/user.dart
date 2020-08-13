class User {
  String useremail;
  String name;
  List<String> reservations;
  List<String> bookingsImages;

  User(String useremail, String name, List<String> reservations,
      List<String> bookingsImages) {
    this.useremail = useremail;
    this.name = name;
    this.reservations = reservations;
    this.bookingsImages = bookingsImages;
  }
}
