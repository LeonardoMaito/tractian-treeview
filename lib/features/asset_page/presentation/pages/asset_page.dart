import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treeview/features/asset_page/presentation/bindings/asset_page_bindings.dart';
import 'package:treeview/features/asset_page/presentation/states/asset_location_store.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key, required this.company});
  final CompanyModel company;

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  late AssetLocationStore assetLocationStore;

  @override
  void initState() {
    AssetPageBindings().init(widget.company);
    assetLocationStore = GetIt.I.get<AssetLocationStore>();
    assetLocationStore.loadAssetsAndLocations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
