// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:share_it/models/called_model.dart';
// import 'package:share_it/models/category_model.dart';
// import 'package:share_it/models/employee_model.dart';
//
// class InfoBloc extends BlocBase {
//
//   InfoBloc() {
//     getCategories();
//   }
//
//   List<CalledModel> internetProblems = [];
//   List<CalledModel> reports = [];
//   List<CalledModel> others = [];
//   List<CalledModel> phoneProblems = [];
//   List<CalledModel> softwareIssues = [];
//   List<CalledModel> equipmentsIssues = [];
//   List<CalledModel> login = [];
//   List<CalledModel> installEquipment = [];
//   List<CalledModel> softwareInstall = [];
//
//   CategoryModel internetProblemsCat;
//   CategoryModel reportsCat;
//   CategoryModel othersCat;
//   CategoryModel phoneProblemsCat;
//   CategoryModel softwareIssuesCat;
//   CategoryModel equipmentsIssuesCat;
//   CategoryModel loginCat;
//   CategoryModel installEquipmentCat;
//   CategoryModel softwareInstallCat;
//
//   List<CategoryModel> categories = [];
//
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//
//   Future<void> syncCategories() async {
//     internetProblemsCat = categories[0];
//     reportsCat = categories[1];
//     othersCat = categories[2];
//     phoneProblemsCat = categories[3];
//     softwareIssuesCat = categories[4];
//     equipmentsIssuesCat = categories[5];
//     loginCat = categories[6];
//     installEquipmentCat = categories[7];
//     softwareInstallCat = categories[8];
//   }
//
//   Future<List<CategoryModel>> getCategories() async {
//     final QuerySnapshot snapshot = await _fireStore.collection('categories').get();
//     categories = snapshot.docs.map((e) => CategoryModel.fromDocument(e)).toList();
//     print(categories.toString());
//     return categories;
//   }
//
//   Future<List<CalledModel>> getInternetProblems(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//         await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: internetProblemsCat.id).get();
//     internetProblems =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return internetProblems;
//   }
//
//   Future<List<CalledModel>> getReports(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: reportsCat.id).get();
//     reports =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return reports;
//   }
//
//   Future<List<CalledModel>> getOthers(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: othersCat.id).get();
//     others =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return others;
//   }
//
//   Future<List<CalledModel>> getPhoneProblems(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: phoneProblemsCat.id).get();
//     phoneProblems =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return phoneProblems;
//   }
//
//   Future<List<CalledModel>> getSoftwareIssues(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: softwareIssuesCat.id).get();
//     softwareIssues =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return softwareIssues;
//   }
//
//   Future<List<CalledModel>> getEquipmentsIssues(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: equipmentsIssuesCat.id).get();
//     equipmentsIssues =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return equipmentsIssues;
//   }
//
//   Future<List<CalledModel>> getLogin(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: loginCat.id).get();
//     login =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return login;
//   }
//
//   Future<List<CalledModel>> getInstallEquipment(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: installEquipmentCat.id).get();
//     installEquipment =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return installEquipment;
//   }
//
//   Future<List<CalledModel>> getSoftwareInstall(
//       {EmployeeModel employeeModel}) async {
//     final QuerySnapshot snapshot =
//     await _fireStore.collection('called_requests').where('company_id', isEqualTo: employeeModel.companyId).where('category_id', isEqualTo: softwareInstallCat.id).get();
//     softwareInstall =
//         snapshot.docs.map((e) => CalledModel.fromDocument(e)).toList();
//     return softwareInstall;
//   }
//
//   Future<void> getAllList(EmployeeModel employeeModel) async {
//     getInternetProblems(employeeModel: employeeModel);
//     getReports(employeeModel: employeeModel);
//     getOthers(employeeModel: employeeModel);
//     getPhoneProblems(employeeModel: employeeModel);
//     getSoftwareIssues(employeeModel: employeeModel);
//     getEquipmentsIssues(employeeModel: employeeModel);
//     getLogin(employeeModel: employeeModel);
//     getInstallEquipment(employeeModel: employeeModel);
//     getSoftwareInstall(employeeModel: employeeModel);
//   }
//
// }