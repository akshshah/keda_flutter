import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keda_flutter/providers/explore_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/channel/platform_channel.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';
import '../widget/grid_product_widget.dart';

class AreaDealsTab extends StatefulWidget {
  AreaDealsTab({Key? key}) : super(key: key);

  @override
  State<AreaDealsTab> createState() => _AreaDealsTabState();
}

class _AreaDealsTabState extends State<AreaDealsTab> with AutomaticKeepAliveClientMixin{
  final _scrollController = ScrollController();
  int totalProducts = 0;
  final Permission _permission = Permission.location;


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

  Future<void> callRecommendedProductsAPI({required BuildContext context, bool? isPagination = false, bool? refresh = false}) async {

    var ans = await PlatformChannel().checkForPermission(_permission);
    if(ans == false) {
      Utils.showSnackBarWithContext(context, "Location permission denied");
      return;
    }

    final response = await Provider.of<ExploreProvider>(context, listen: false).fetchRecommendedProductsAPI(isPagination: isPagination, refresh: refresh);
    Logger().v("Response Code : === ${response?.status} ");
    if (response?.status == 200) {
      totalProducts = response?.totalRecords ?? 0;
    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }

  }

  void pagination() {
    if ((_scrollController.position.pixels == _scrollController.position.maxScrollExtent) && (Provider.of<ExploreProvider>(context, listen: false).recommendedProducts.length < totalProducts)) {
      callRecommendedProductsAPI(context: context, isPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: callRecommendedProductsAPI(context: context, refresh: true),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
            child: CircularProgressIndicator(
              color: AppColor.colorPrimary,
            ),
          )
          : RefreshIndicator(
            onRefresh: () => callRecommendedProductsAPI(context: context, refresh: true),
            child: SingleChildScrollView(
              controller: _scrollController,
              child:  Consumer<ExploreProvider> (
                builder: (ctx, exploreData, child) {
                  return StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    children: exploreData.recommendedProducts.map((e) => GridProductWidget(product: e, isRecent: false,)).toList(),
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
