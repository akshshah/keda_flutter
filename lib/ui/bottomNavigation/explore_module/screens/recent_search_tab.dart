import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/explore_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../service/response/products_response.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';
import '../widget/grid_product_widget.dart';

class RecentSearchTab extends StatefulWidget {
  RecentSearchTab({Key? key}) : super(key: key);

  @override
  State<RecentSearchTab> createState() => _RecentSearchTabState();
}

class _RecentSearchTabState extends State<RecentSearchTab> with AutomaticKeepAliveClientMixin{
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

  Future<void> callRecentProductsAPI({required BuildContext context, bool? isPagination = false, bool? refresh = false}) async {
    final response = await Provider.of<ExploreProvider>(context, listen: false).fetchRecentProductsAPI(isPagination: isPagination, refresh: refresh);
    Logger().v("Response Code : === ${response?.status} ");
    if (response?.status == 200) {
      totalProducts = response?.totalRecords ?? 0;
    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }
  }

  void pagination() {
    if ((_scrollController.position.pixels == _scrollController.position.maxScrollExtent) && (Provider.of<ExploreProvider>(context, listen: false).recentProducts.length < totalProducts)) {
      callRecentProductsAPI(context: context, isPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: callRecentProductsAPI(context: context, refresh: true),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.colorPrimary,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => callRecentProductsAPI(context: context, refresh: true),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Consumer<ExploreProvider> (
                      builder: (ctx, exploreData, child) {
                        return StaggeredGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          children: exploreData.recentProducts.map((e) => GridProductWidget(product: e, isRecent: true,)).toList(),
                        );
                      },
                    ),
                  ),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
