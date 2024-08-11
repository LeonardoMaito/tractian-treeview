import 'package:treeview/features/home_page/data/datasource/company_datasource.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';
import 'package:treeview/features/home_page/domain/repository/company_repository.dart';

class CompanyRepositoryImpl extends CompanyRepository{
  final CompanyDatasource dataSource;

  CompanyRepositoryImpl(this.dataSource);

  @override
  Future<List<CompanyModel>> getCompanies() async {
    return dataSource.getCompanies();
  }
}