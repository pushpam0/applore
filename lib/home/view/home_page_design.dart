import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/home/services/get_products_firebase_services.dart';
import 'add_item.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageDesign extends StatefulWidget {
  const HomePageDesign({Key? key}) : super(key: key);

  @override
  _HomePageDesignState createState() => _HomePageDesignState();
}

class _HomePageDesignState extends State<HomePageDesign> {
  List<DocumentSnapshot> product = [];
  DocumentSnapshot? lastObject;
  ScrollController scrollController = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProductsData();
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getMoreProduct();
      }
    });
  }

  void getProductsData() async {
    getProducts().then((value) {
      setState(() {
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        product = value;
        lastObject = value[value.length - 1];
        print("product: ${product[1].data()}");
      });
    });
  }

  void getMoreProduct() {
    print("getmoreproduct");
    getMProducts(lastObject).then((value) {
      setState(() {
        product.addAll(value);
        lastObject = value[value.length - 1];
        print("product: ${product[1].data()}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddItem()),
              );
            },
            child: Icon(Icons.add)),
        body: product.isEmpty == true
            ? Center(child: CircularProgressIndicator())
            : SmartRefresher(
                controller: _refreshController,
                onLoading: getProductsData,
                onRefresh: getProductsData,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Text(product[index].get('product_name')),
                        subtitle: Text(product[index].get('discription')),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(product[index].get('url')),
                        ),
                        trailing: Text(product[0].get('price')),
                      ));
                    }),
              ),
      ),
    );
  }
}
