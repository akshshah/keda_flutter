import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keda_flutter/providers/explore_screen_provider.dart';
import 'package:provider/provider.dart';

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
  int _totalProducts = 0;

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
      _totalProducts = response?.totalRecords ?? 0;
    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }
  }

  void pagination() {
    if ((_scrollController.position.pixels == _scrollController.position.maxScrollExtent) && (Provider.of<ExploreProvider>(context, listen: false).recentProducts.length < _totalProducts)) {
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
                  onRefresh: () =>
                      callRecentProductsAPI(context: context, refresh: true),
                  child: Consumer<ExploreProvider>(
                    builder: (ctx, exploreData, child) {
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            controller: _scrollController,
                            child: StaggeredGrid.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              children: exploreData.recentProducts
                                  .map((e) => GridProductWidget(
                                        product: e,
                                        isRecent: true,
                                      ))
                                  .toList(),
                            ),
                          ),
                          if (exploreData.isRecentLoading)
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
