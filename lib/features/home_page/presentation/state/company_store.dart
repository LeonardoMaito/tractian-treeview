import 'package:mobx/mobx.dart';
import 'package:treeview/features/home_page/data/repository/company_repository_impl.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';
import 'package:treeview/features/home_page/domain/repository/company_repository.dart';

part 'company_store.g.dart';

class CompanyStore = _CompanyStore with _$CompanyStore;

abstract class _CompanyStore with Store {
  final CompanyRepository companyRepository;

  _CompanyStore(this.companyRepository);

  @observable
  ObservableList<CompanyModel> companies = ObservableList<CompanyModel>();

  @action
  Future<void> loadCompanies() async {
    final loadedCompanies = await companyRepository.getCompanies();
    companies.addAll(loadedCompanies);
  }
}