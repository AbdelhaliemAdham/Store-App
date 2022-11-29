import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:store_app/services/products.dart';

import '../Widgets/feeds_widget.dart';
import '../services/api_handler.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductsModel> productsList = [];
  int limit = 10;
  bool _isLoading = false;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // getProducts();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        print("_isLoading $_isLoading");
        limit += 10;
        await getProducts();
        _isLoading = false;
        print("limit $limit");
      }
    });
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(
      limit: limit.toString(),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Latest Version',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
        ),
        body: productsList.isNotEmpty
            ? GridView.builder(
                itemCount: productsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0),
                itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                      value: productsList[index],
                      child: const FeedsWidget(),
                    )),
              )
            : Center(
                child: CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: 0.7,
                  center: const Text(
                    "70%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: const Text(
                    "Loaing Data ...",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.blue,
                ),
              ));
  }
}
