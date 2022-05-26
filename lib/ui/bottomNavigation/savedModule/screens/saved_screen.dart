import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keda_flutter/providers/saved_screen_provider.dart';
import 'package:keda_flutter/service/response/products_response.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/widget/grid_product_widget.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';


class SavedScreen extends StatelessWidget {
  SavedScreen({Key? key}) : super(key: key);
  List<Product> _items = [];

  Future<void> callSavedProductsAPI(BuildContext context) async {
    final response = await Provider.of<SavedProvider>(context, listen: false)
        .fetchSavedProductsAPI();
    Logger().v("Response Code : === ${response?.status} ");
    if (response?.status == 200) {
      _items = response?.items ?? [];
      Logger().v("Items size ${_items.length}");

    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(
                  "Saved",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColor.heading_text,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                thickness: 1,
                color: AppColor.light_sky_blue,
              ),
              FutureBuilder(
                future: callSavedProductsAPI(context),
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.colorPrimary,
                          ),
                        ),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => callSavedProductsAPI(context),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                              child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                children: _items.map((e) => GridProductWidget(product: e, isRecent: false,)).toList(),),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
