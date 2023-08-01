import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/store/store-mini-card.dart';

class StoreList extends StatefulWidget {
  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StoreProvider>(context, listen: false).getAll();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);
    return Consumer<StoreProvider>(builder: (context, data, child) {
      return data.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: QuickyColors.primaryColor,
              ),
            )
          : data.stores.isEmpty
              ? Center(
                  child: Text('No hay datos'),
                )
              : ListView.builder(
                  itemCount: data.stores.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: StoreMiniCard(
                          isSelected: storeProvider.selectedStores
                              .map((e) => e.id)
                              .contains(data.stores[index].id),
                          showImage: false,
                          onTap: () {
                            storeProvider.selectStore(data.stores[index]);
                          },
                          store: data.stores[index]),
                    );
                  },
                );
    });
  }
}
