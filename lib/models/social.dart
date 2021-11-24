class Social {
  String website;
  String twitter;
  String instagram;
  String facebook;
  String telegram;

  Social(
      {this.website,
      this.twitter,
      this.instagram,
      this.facebook,
      this.telegram});

  Social.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    telegram = json['telegram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['website'] = this.website;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['telegram'] = this.telegram;
    return data;
  }
}
