
class User {
  int id;
  String username;
  String email;
  String photo;
  String coverPhoto;
  String bio;
  String website;
  String location;
  String dateOfBirth;
  List<int> following;

  User({
    this.id,
    this.username,
    this.email,
    this.photo,
    this.coverPhoto='',
    this.bio='',
    this.website='',
    this.location = '',
    this.dateOfBirth = '',
    this.following
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    photo = json['photo'];
    coverPhoto = json['cover_photo'];
    bio = json['bio'];
    website = json['website'];
    location = json['location'];
    dateOfBirth = json['date_of_birth'];
    following = json['following'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['cover_photo'] = this.coverPhoto;
    data['bio'] = this.bio;
    data['website'] = this.website;
    data['location'] = this.location;
    data['date_of_birth'] = this.dateOfBirth;
    data['following'] = this.following;
    return data;
  }
}