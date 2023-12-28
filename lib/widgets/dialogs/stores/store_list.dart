import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
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
    final appProvider = Provider.of<AppProvider>(context);
    return Consumer<StoreProvider>(builder: (context, data, child) {
      return data.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: QuickyColors.primaryColor,
              ),
            )
          : data.stores.isEmpty
              ? Center(
                  child: GestureDetector(
                    onTap: () {
                      appProvider.setWantToAddNewStore(true);
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: QuickyColors.primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        'Agregar subtienda',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                  itemCount: data.stores.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: StoreMiniCard(
                          isSelected: storeProvider.selectedStores
                              .map((e) => e)
                              .contains(data.stores[index].id),
                          showImage: true,
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
