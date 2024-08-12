import 'package:get_it/get_it.dart';
import 'package:treeview/features/home_page/data/datasource/company_datasource.dart';
import 'package:treeview/features/home_page/data/repository/company_repository_impl.dart';
import 'package:treeview/features/home_page/domain/repository/company_repository.dart';
import 'package:treeview/features/home_page/presentation/state/company_store.dart';
import '../../data/datasource/local_company_datasource.dart';

class HomePageBindings {
  final i = GetIt.instance;

  void init() {
    i.registerLazySingleton<CompanyDatasource>(() => LocalCompanyDatasource('assets/companies/companies.json'));

    i.registerLazySingleton<CompanyRepository>(() => CompanyRepositoryImpl(i<CompanyDatasource>()));

    i.registerLazySingleton<CompanyStore>(() => CompanyStore(i<CompanyRepository>()));

  }
}