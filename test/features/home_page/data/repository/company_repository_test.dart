import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';
import 'package:treeview/features/home_page/data/datasource/local_company_datasource.dart';
import 'package:treeview/features/home_page/data/repository/company_repository_impl.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';

void main() {

  late LocalCompanyDatasource localDataSource;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    localDataSource = LocalCompanyDatasource('assets/companies/companies.json');
  });

  test('Get companies from local datasource', () async{
    final companies = await localDataSource.getCompanies();

    expect(companies.isNotEmpty, true);
    expect(companies.first.name.toLowerCase(), 'apex');
  });

  test('Parse JSON correctly into CompanyModel', () async {
    final companies = await localDataSource.getCompanies();

    expect(companies, isA<List<CompanyModel>>());
  });

}