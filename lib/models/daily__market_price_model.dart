class DailyMarketPrice {
  int? status;
  String? date;
  List<Prices>? prices;

  DailyMarketPrice({this.status, this.date, this.prices});

  DailyMarketPrice.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    date = json['date'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(new Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['date'] = this.date;
    if (this.prices != null) {
      data['prices'] = this.prices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {
  String? commodityname;
  String? commodityunit;
  String? minprice;
  String? maxprice;
  String? avgprice;

  Prices(
      {this.commodityname,
      this.commodityunit,
      this.minprice,
      this.maxprice,
      this.avgprice});

  Prices.fromJson(Map<String, dynamic> json) {
    commodityname = json['commodityname'];
    commodityunit = json['commodityunit'];
    minprice = json['minprice'];
    maxprice = json['maxprice'];
    avgprice = json['avgprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commodityname'] = this.commodityname;
    data['commodityunit'] = this.commodityunit;
    data['minprice'] = this.minprice;
    data['maxprice'] = this.maxprice;
    data['avgprice'] = this.avgprice;
    return data;
  }
}
