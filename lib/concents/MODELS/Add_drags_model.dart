class Drags_Model{
  String ?name;
  String ?price;
  String ?code;
  String ?count;
  String ?E_date;
  String ?M_date;
  String ?place;


  Drags_Model(this.name, this.price, this.code, this.count, this.E_date,
      this.M_date, this.place);


  Drags_Model.fromJson(json) {

    name= json?["name"];
    price= json?["price"];
    code=json?["code"];
    count= json?["count"];
    E_date= json?["E_date"];
    M_date= json?["M_date"];
    place= json?["place"];

  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "price": this.price,
      "code": this.code,
      "count": this.count,
      "E_date": this.E_date,
      "M_date": this.M_date,
      "place": this.place,
    };
  }

//

}