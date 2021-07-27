import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_called_card.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_search_bar.dart';
import 'package:share_it/components/custom_search_dialog.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/screens/called_by_category/called_details_info_module.dart';
import 'package:share_it/screens/my_called_details_only_read/my_called_details_only_read_module.dart';

class CalledByCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String category;
  const CalledByCategoryScreen({Key key, this.categoryId, this.category}) : super(key: key);

  @override
  _CalledByCategoryScreenState createState() => _CalledByCategoryScreenState();
}

class _CalledByCategoryScreenState extends State<CalledByCategoryScreen> {

  var calledBloc = CalledByCategoryModule.to.getBloc<CalledBloc>();
  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.category,
          style: textPlanCard,
        ),
        leading: IconButton(
          onPressed: () {
           Get.back();
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:
                FutureBuilder(
                  future: calledBloc.getCalledListByCategoryId(employeeModel: employeeBloc.user, id: widget.categoryId),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CustomCircularProgressIndicator(),
                        );
                      default:
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSearchBar(
                          text: calledBloc.search.isEmpty ? 'pesquisar...' : calledBloc.search,
                          onTap: () async {
                            final search = await showDialog(
                              context: context,
                              builder: (_) => SearchDialog(calledBloc.search),
                            );
                            if (search != null) {
                              setState(() {
                                calledBloc.search = search;
                              });
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${snapshot.data.length} ', style: dayTitle,),
                              Text(
                                'Chamados cadastrados.',
                                style: dayTitle,
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: calledBloc.filteredByCategory.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              CalledModel item = snapshot.data[index];
                              var dateCreatedString = DateFormat('dd/MM hh:mm').format(item.calledCreatedTime);
                              var dateFinishedString =  item.calledFinishedTime != null ? DateFormat('dd/MM hh:mm').format(item.calledFinishedTime) : '';
                              return GestureDetector(
                                onTap: () async {
                                  await Get.to(() => MyCalledDetailsOnlyReadModule(item));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only( left: 20, right: 20),
                                  child: CustomCalledCard(
                                    email: item.employeeEmail,
                                    subject: item.subject,
                                    createdDate: dateCreatedString,
                                    finishedDate: dateFinishedString,
                                  ),
                                ),
                              );
                            },
                          ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                    }
                ),
          ),
    );
  }
}
