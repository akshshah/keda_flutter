import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/profile_screen_provider.dart';
import 'package:keda_flutter/utils/app_color.dart';
import 'package:provider/provider.dart';

import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';
import '../widget/my_product_widget.dart';

class MyProductsTab extends StatefulWidget {
  MyProductsTab({Key? key}) : super(key: key);

  @override
  State<MyProductsTab> createState() => _MyProductsTabState();
}

class _MyProductsTabState extends State<MyProductsTab> {
  final _scrollController = ScrollController();
  int totalProducts = 0;

  @override
  void initState() {
    _scrollController.addListener(pagination);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> callUserProductsAPI(
      {required BuildContext context,
      bool? isPagination = false,
      bool? refresh = false}) async {
    final response = await Provider.of<ProfileProvider>(context, listen: false)
        .getUserProducts(isPagination: isPagination, refresh: refresh);
    Logger().v("Response Code : === ${response?.status} ");
    if (response?.status == 200) {
      totalProducts = response?.totalRecords ?? 0;
    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }
  }

  void pagination() {
    if ((_scrollController.position.pixels == _scrollController.position.maxScrollExtent) && (Provider.of<ProfileProvider>(context, listen: false).userProducts.length < totalProducts)) {
      callUserProductsAPI(context: context, isPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        children: [
          Row(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.heading_text,
                  ),
                  label: const Text(
                    "All Products",
                    style: TextStyle(
                        color: AppColor.heading_text,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: AppColor.heading_text,
                    size: 15,
                  ),
                  label: const Text(
                    "Add Item",
                    style: TextStyle(
                        color: AppColor.heading_text,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder(
            future: callUserProductsAPI(context: context, refresh: true),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.colorPrimary,
                          ),
                        ),
                    )
                    : Expanded(
                        child: RefreshIndicator(
                            onRefresh: () => callUserProductsAPI(context: context, refresh: true),
                            child: Consumer<ProfileProvider>(
                              builder: (ctx, profileData, child){
                                return Stack(
                                  children: [
                                    ListView.builder(
                                      cacheExtent: 9999,
                                      controller: _scrollController,
                                      itemBuilder: (ctx, index) {
                                        return MyProductWidget(product: profileData.userProducts[index],);
                                      },
                                      itemCount: profileData.userProducts.length,
                                    ),
                                    if(profileData.isLoading)
                                      const Align(
                                        child: SizedBox(
                                          child: CircularProgressIndicator(
                                            color: AppColor.colorPrimary,
                                          ),
                                          height: 30,
                                          width: 30,
                                        ),
                                        alignment: Alignment.bottomCenter,
                                      ),
                                  ],
                                );
                              },
                            ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
