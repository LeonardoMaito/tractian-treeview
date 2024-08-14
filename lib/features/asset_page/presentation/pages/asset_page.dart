import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:treeview/features/asset_page/presentation/bindings/asset_page_bindings.dart';
import 'package:treeview/features/asset_page/presentation/states/asset_location_store.dart';
import 'package:treeview/features/asset_page/presentation/widgets/filter_button.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';
import '../../domain/entities/base_entity.dart';
import '../../domain/models/assets/asset_model.dart';
import '../../domain/models/assets/component_model.dart';
import '../../domain/models/location/location_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_tile.dart';
import '../widgets/search_field.dart';

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
    loadAssetsAndLocations();
    super.initState();
  }

  Future<void> loadAssetsAndLocations() async{
    await assetLocationStore.loadAssetsAndLocations();
  }

  @override
  void dispose() {
    AssetPageBindings().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchField(
              onChanged: (text) {
                assetLocationStore.setSearchTerm(text);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 0,
                      child: FilterButton(
                          onPressed: () {
                            assetLocationStore.toggleEnergySensorsFilter();
                          },
                          icon: Icons.bolt,
                          text: 'Sensor de Energia')),
                  const SizedBox(width: 15),
                  Flexible(
                      flex: 0,
                      child: FilterButton(
                          onPressed: () {
                            assetLocationStore.toggleCriticalStatusFilter();
                          },
                          icon: Icons.error_outline,
                          text: 'Crítico')),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            SizedBox(
              height: 600,
              child: Observer(
                builder: (_) {

                  if (assetLocationStore.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      itemCount: assetLocationStore.filteredEntities.length,
                      itemBuilder: (context, index) {
                        final entity = assetLocationStore.filteredEntities[index];
                        return _buildEntityItem(entity);
                      },
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntityItem(BaseEntity entity) {
    if (entity is ComponentModel) {
      return CustomExpansionTile(
        leading: Image.asset('assets/icons/component.png'),
        title: entity.name,
        expandable: false,
        additionalIcons: [
          if (entity.sensorType == ComponentType.energy)
            const Icon(Icons.bolt, color: Colors.green, size: 24),
          if (entity.status == ComponentStatus.alert)
            const Icon(Icons.circle, color: Colors.red, size: 18),
        ],
      );
    } else if (entity is AssetModel) {
      return CustomExpansionTile(
        leading: Image.asset('assets/icons/asset.png'),
        title: entity.name,
        children: [
          ...entity.subAssets.map((subAsset) => _buildEntityItem(subAsset)),
          ...entity.components.map((component) => _buildEntityItem(component)),
        ],
      );
    } else if (entity is LocationModel) {
      return CustomExpansionTile(
        leading: Image.asset('assets/icons/location.png'),
        title: entity.name,
        children: [
          ...entity.subLocations
              .map((subLocation) => _buildEntityItem(subLocation)),
          ...entity.assets.map((asset) => _buildEntityItem(asset)),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
