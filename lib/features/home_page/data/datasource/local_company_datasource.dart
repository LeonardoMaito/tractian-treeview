import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:treeview/features/home_page/data/datasource/company_datasource.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';

class LocalCompanyDatasource implements CompanyDatasource {
  final String path;

  LocalCompanyDatasource(this.path);

  @override
  Future<List<CompanyModel>> getCompanies() async {
    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => CompanyModel.fromJson(item)).toList();
  }
}