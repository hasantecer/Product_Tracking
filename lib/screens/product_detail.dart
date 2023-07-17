import 'package:flutter/material.dart';
import 'package:sqlflite_demo/data/dbhelper.dart';
import '../models/product.dart';

enum Options{delete,update}

class ProductDetail extends StatefulWidget{
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductDetailState(product);
  }

}

class _ProductDetailState extends State{
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPrice = TextEditingController();

  @override
  void initState() {
    txtName.text = product.name!;
    txtDescription.text = product.description!;
    txtPrice.text = product.unitPrice.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı :${product.name}"),
        actions:[
          PopupMenuButton<Options>(
            onSelected: SelectProcess,
            itemBuilder: (BuildContext context)=> <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("güncelle"),
              ),
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("sil"),
              ),

            ],
          )
        ],
      ),
      body: buildProductDetail(),
      

    );
  }

  buildProductDetail() {

    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          buildNameField(), buildDescriptionField(), buildPriceField()
        ],
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
  

  void SelectProcess(Options options) async {
    switch(options){
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context,true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(product.id, txtName.text, txtDescription.text, double.tryParse(txtPrice.text)));
        Navigator.pop(context,true);
        break;
      default:  
    }
  }
}