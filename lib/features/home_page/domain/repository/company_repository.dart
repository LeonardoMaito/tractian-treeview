import 'package:treeview/features/home_page/domain/models/company_model.dart';

abstract class CompanyRepository{
  Future<List<CompanyModel>> getCompanies();

}