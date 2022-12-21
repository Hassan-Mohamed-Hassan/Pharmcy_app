class usermodel{
  String ?name;
  String ?email;
  String ?phone;
  String ?uid;

  usermodel(this.name, this.email, this.phone, this.uid);

   usermodel.fromJson(Map<String, dynamic> json) {

      name=json["name"];
      email= json["email"];
      phone= json["phone"];
      uid= json["uid"];

  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "email": this.email,
      "phone": this.phone,
      "uid": this.uid,
    };
  }

//

}