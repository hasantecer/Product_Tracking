import 'package:flutter/material.dart';
import 'package:sqlflite_demo/models/product.dart';

import '../data/dbhelper.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }

}

class ProductAddState extends State{
  var dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ürün Ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameField(), buildDescriptionField(), buildPriceField(),buildSaveButton()
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün açıklaması"),
      controller: txtDescription,
    );
  }

  buildPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Fiyatı"),
      controller: txtPrice,
    );
  }

  buildSaveButton() {
    return ElevatedButton(onPressed: (){
      addProduct();
    }, child: Text("Ekle"));
  }

  void addProduct() async {
   var result = await dbHelper.insert(Product(txtName.text, txtDescription.text, double.tryParse(txtPrice.text)));
   Navigator.pop(context,true);
  }
}