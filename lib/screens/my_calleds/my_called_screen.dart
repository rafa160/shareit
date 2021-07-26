import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';

import 'package:share_it/components/custom_called_card.dart';
import 'package:share_it/components/custom_called_card_image.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_search_bar.dart';
import 'package:share_it/components/custom_search_dialog.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/helpers/strings.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/screens/home/bloc/home_bloc.dart';
import 'package:share_it/screens/home/home_module.dart';
import 'package:share_it/screens/my_called_details_only_read/my_called_details_only_read_module.dart';
import 'package:share_it/screens/my_calleds/my_called_module.dart';

class MyCalledScreen extends StatefulWidget {
  final EmployeeBloc employeeBloc;

  const MyCalledScreen({Key key, this.employeeBloc}) : super(key: key);
  @override
  _MyCalledScreenState createState() => _MyCalledScreenState();
}

class _MyCalledScreenState extends State<MyCalledScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var calledBloc = MyCalledModule.to.getBloc<CalledBloc>();
  var homeBloc = AppModule.to.getBloc<HomeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.only(top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.employeeBloc.user.status.index != 1 ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(Strings.APPBAR_TITLE_MY_CALLED_SUPPORT, style: homeMessage,),
                ) : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(Strings.APPBAR_TITLE_MY_CALLED, style: homeMessage,),
                ),
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
                FutureBuilder(
                  future: calledBloc.getCalledModelList(employeeBloc: widget.employeeBloc),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CustomCircularProgressIndicator(),
                          );
                        default:
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: calledBloc.filteredList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            CalledModel item = snapshot.data[index];
                            var dateCreatedString = DateFormat('dd/MM hh:mm').format(item.calledCreatedTime);
                            var dateFinishedString =  item.calledFinishedTime != null ? DateFormat('dd/MM hh:mm').format(item.calledFinishedTime) : '';
                            return Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: GestureDetector(
                                onTap:  () async {
                                  Get.to(() => MyCalledDetailsOnlyReadModule(item));
                                },
                                child:
                                CustomCalledCard(
                                  email: item.employeeEmail,
                                  subject: item.subject,
                                  createdDate: dateCreatedString,
                                  finishedDate: dateFinishedString,
                                ),
                              ),
                            );
                          }
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
