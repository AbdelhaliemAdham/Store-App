import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:search_page/search_page.dart';
import 'package:store_app/screens/Category_Screan.dart';
import 'package:store_app/screens/product_details.dart';
import 'package:store_app/screens/user_screan.dart';

import '../Widgets/feeds_gridview.dart';
import '../Widgets/sale_widgets.dart';
import '../consts/global_colors.dart';
import '../services/api_handler.dart';
import '../services/products.dart';
import '../widgets/appbar_icons.dart';

import 'feeds_screns.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;
  List<ProductsModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(limit: '20');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            leading: AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ),
                );
              },
              icon: IconlyBold.category,
            ),
            actions: [
              AppBarIcons(
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UsersScreen(),
                    ),
                  );
                },
                icon: IconlyBold.user_3,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  onTap: () => showSearch(
                      context: context,
                      delegate: SearchPage<ProductsModel>(
                        items: productsList,
                        itemStartsWith: true,
                        searchLabel: 'Search products',
                        suggestion: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('No products'),
                              Icon(IconlyBold.buy)
                            ],
                          ),
                        ),
                        failure: const Center(
                          child: Text('No product found :('),
                        ),
                        filter: (ProductsModel) => [
                          ProductsModel.title,
                          ProductsModel.id.toString(),
                          ProductsModel.price.toString(),
                        ],
                        builder: (product) => InkWell(
                          onTap: (() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                      id: product.id.toString())))),
                          child: ListTile(
                            title: Text(
                              product.title.toString(),
                              // style: TextStyle(fontSize: 18,color: ),
                            ),
                            subtitle: Text('US ${product.price.toString()}'),
                            trailing: Text('${product.id}'),
                          ),
                        ),
                      )),
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      suffixIcon: Icon(
                        IconlyLight.search,
                        color: lightIconsColor,
                      )),
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (ctx, index) {
                            return const SaleWidget();
                          },
                          autoplay: true,
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.red)),
                          control: const SwiperControl(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Latest Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FeedsScreen(),
                                    ),
                                  );
                                },
                                icon: IconlyBold.arrow_right_3),
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductsModel>>(
                          future: APIHandler.getAllProducts(limit: "4"),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              Center(
                                child:
                                    Text("An error occured ${snapshot.error}"),
                              );
                            } else if (snapshot.data == null) {
                              const Center(
                                child: Text("No products has been added yet"),
                              );
                            }
                            return FeedsGridWidget(
                                productsList: snapshot.data!);
                          }))
                    ]),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
