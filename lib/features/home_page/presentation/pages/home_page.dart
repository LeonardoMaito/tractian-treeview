import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:treeview/features/asset_page/presentation/pages/asset_page.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';
import 'package:treeview/features/home_page/presentation/bindings/home_page_bindings.dart';
import 'package:treeview/features/home_page/presentation/state/company_store.dart';
import 'package:treeview/features/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CompanyStore companyStore;

  @override
  void initState() {
    HomePageBindings().init();
    companyStore = GetIt.I.get<CompanyStore>();
    companyStore.loadCompanies();
    super.initState();
  }

  void _onButtonPressed(BuildContext context, CompanyModel company) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AssetPage(company: company)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppConstants.companyLogo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Observer(
            builder: (_) {
              if (companyStore.companies.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: companyStore.companies.map((company) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    child: ElevatedButton(onPressed: () {
                      _onButtonPressed(context, company);
                    },
                        child: Row(
                          children: [
                            Image.asset(AppConstants.companyIcon),
                            const SizedBox(width: 15),
                            Text(company.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
