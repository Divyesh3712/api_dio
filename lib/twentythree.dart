import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class twentythree extends StatefulWidget {
  const twentythree({Key? key}) : super(key: key);

  @override
  State<twentythree> createState() => _twentythreeState();
}

class _twentythreeState extends State<twentythree> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData() async {

    try {
      var response = await Dio().get('https://dummyjson.com/products/category/smartphones');
      print(response);
      l = response.data["products"];
      setState(() {
        status = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("twentythree API"),
        centerTitle: true,
      ),
      body: status
          ? ListView.builder(
        shrinkWrap: true,
        primary: true,
        itemCount: l.length,
        itemBuilder: (context, index) {
          Acess m = Acess.fromJson(l[index]);

          return Card(
            color: Colors.purple.shade100,
            margin: EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Id : ${m.id}"),
                Text("title : ${m.title}"),
                Text("description : ${m.description}"),
                Text("price : ${m.price}"),
                Text("discountPercentage : ${m.discountPercentage}"),
                Text("rating : ${m.rating}"),
                Text("stock : ${m.stock}"),
                Text("brand : ${m.brand}"),
                Text("category : ${m.category}"),
                Text("thumbnail : ${m.thumbnail}"),
                ListView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: m.images!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Images : ${m.images![index]}"),
                    );
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Acess {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Acess(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail,
        this.images});

  Acess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    return data;
  }
}
