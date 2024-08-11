import 'package:treeview/features/home_page/domain/models/company_model.dart';

abstract class CompanyDatasource {
  Future<List<CompanyModel>> getCompanies();
}