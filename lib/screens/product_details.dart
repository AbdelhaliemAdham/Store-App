import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:store_app/Widgets/descriptionWidget.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/services/products.dart';

import '../consts/global_colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  ProductsModel? productsModel;
  bool isError = false;
  String errorStr = "";
  Future<void> getProductInfo() async {
    try {
      productsModel = await APIHandler.getProductById(id: widget.id);
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      log("error $error");
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: productsModel == null
          ? Center(
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.7,
                center: const Text(
                  "70.0%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: const Text(
                  "Loaing Data",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    const BackButton(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsModel!.category.toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text(
                                  productsModel!.title.toString(),
                                  textAlign: TextAlign.start,
                                  style: titleStyle,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: RichText(
                                  text: TextSpan(
                                      text: '\$',
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color:
                                              Color.fromRGBO(33, 150, 243, 1)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                productsModel!.price.toString(),
                                            style: TextStyle(
                                                color: lightTextColor,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.4,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            productsModel!.images![index].toString(),
                            width: double.infinity,
                            fit: BoxFit.fill,
                          );
                        },

                        autoplay: true,
                        itemCount: 3,
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Colors.red,
                          ),
                        ),
                        // control: const SwiperControl(),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description', style: titleStyle),
                          const SizedBox(
                            height: 18,
                          ),
                          DescriptionWidget(
                            text: productsModel!.description.toString(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
