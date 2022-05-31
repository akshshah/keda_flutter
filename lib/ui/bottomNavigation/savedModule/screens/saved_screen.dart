import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keda_flutter/providers/saved_screen_provider.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/widget/grid_product_widget.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';


class SavedScreen extends StatefulWidget {
  SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
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

  Future<void> callSavedProductsAPI({required BuildContext context, bool? isPagination = false, bool? refresh = false}) async {
    final response = await Provider.of<SavedProvider>(context, listen: false)
        .fetchSavedProductsAPI(isPagination: isPagination, refresh: refresh);
    Logger().v("Response Code : === ${response?.status} ");
    if (response?.status == 200) {
      _totalProducts = response?.totalRecords ?? 0;
    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }
  }

  void pagination() {
    if ((_scrollController.position.pixels == _scrollController.position.maxScrollExtent) && (Provider.of<SavedProvider>(context, listen: false).savedProducts.length < _totalProducts)) {
      callSavedProductsAPI(context: context, isPagination: true);
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(
                  "Saved",
                  style: UITextStyle.semiBoldTextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                thickness: 1,
                color: AppColor.light_sky_blue,
              ),
              FutureBuilder(
                future: callSavedProductsAPI(context: context, refresh: true),
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
                          onRefresh: () => callSavedProductsAPI(context: context, refresh: true),
                          child: Consumer<SavedProvider>(
                            builder: (ctx, savedData, child){
                              return Stack(
                                children: [
                                  SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                      child: StaggeredGrid.count(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        children: savedData.savedProducts.map((e) => GridProductWidget(product: e, isRecent: false,)).toList(),),
                                    ),
                                  ),
                                  if (savedData.isLoading)
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
        ),
      ),
    );
  }
}
