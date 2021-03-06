
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_called_card.dart';
import 'package:share_it/components/custom_category_card_btn.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_named_icon.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/helpers/strings.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/category_model.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/called_by_category/called_details_info_module.dart';
import 'package:share_it/screens/called_details/called_details_module.dart';
import 'package:share_it/screens/home/bloc/home_bloc.dart';
import 'package:share_it/screens/home/home_module.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();
  var homeBloc = AppModule.to.getBloc<HomeBloc>();
  var categoryBloc = HomeModule.to.getBloc<CategoryBloc>();

  List<CalledModel> todayListNumber = [];
  List<CalledModel> yesterdayListNumber = [];
  List<CalledModel> monthList = [];
  String image;

  @override
  void initState() {
    super.initState();
    todayListNumber = homeBloc.getListTodayCalledNumber(employeeBloc);
    yesterdayListNumber = homeBloc.getListYesterdayCalledNumber(employeeBloc);
    monthList = homeBloc.getListMonthCalledNumber(employeeBloc);
    homeBloc.getCalledItems(employeeBloc);
    homeBloc.getYesterdayCalledItems(employeeBloc);
    homeBloc.getMonthCalledList(employeeBloc);
    getImage();
  }

  Future getImage() async {
    image = await homeBloc.getImage();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
                initialData: [],
                stream: employeeBloc.userModel,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return CustomColorCircularProgressIndicator();
                    default:
                      if (!snapshot.hasData || snapshot.hasError) {
                        return Text(
                          'error',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                  }
                  EmployeeModel employee = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      children: [
                        Text('Ol??,', style: homeMessage,),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${employee.name}.', style: homeMessage,),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                // color: Colors.deepPurple,
                height: 90,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      StreamBuilder(
                        initialData: todayListNumber,
                          stream: homeBloc.todayCalledStreamList,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: CustomCircularProgressIndicator(),
                                );
                              default:
                            }
                            return NamedIcon(
                              text: Strings.NAMED_TODAY_ICON,
                              icon: FaIcon(
                                FontAwesomeIcons.calendarTimes,
                                size: 30,
                              ),
                              notificationCount: todayListNumber.length,
                              onTap: () {},
                            );
                          }
                      ),
                      Spacer(),
                      StreamBuilder(
                          initialData: yesterdayListNumber,
                          stream: homeBloc.yesterdayCalledStreamList,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: CustomCircularProgressIndicator(),
                                );
                              default:
                            }
                            return NamedIcon(
                              text: Strings.NAMED_YESTERDAY_ICON,
                              icon: FaIcon(
                                FontAwesomeIcons.calendarWeek,
                                size: 30,
                              ),
                              notificationCount: yesterdayListNumber.length,
                              onTap: () {},
                            );
                          }
                      ),
                      Spacer(),
                      StreamBuilder(
                          initialData: monthList,
                          stream: homeBloc.monthCalledStreamList,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: CustomCircularProgressIndicator(),
                                );
                              default:
                            }
                            return NamedIcon(
                              text: Strings.NAMED_MONTH,
                              icon: FaIcon(
                                FontAwesomeIcons.calendarAlt,
                                size: 30,
                              ),
                              notificationCount: monthList.length,
                              onTap: () {},
                            );
                          }
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text('Categorias',style: dayTitle,),
            ),
            Container(
              height: 110,
              child: FutureBuilder(
                future: categoryBloc.getCategories(),
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    default:
                  }
                  return ListView.builder(
                    itemCount: categoryBloc.categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      CategoryModel model = snapshot.data[index];
                      return Center(
                        child: CustomCategoryCardBtn(
                          icon: FaIcon(
                            FontAwesomeIcons.memory,
                            size: 12,
                          ),
                          text: model.name,
                          onPressed: () async{
                            await Get.to(() => CalledByCategoryModule(categoryId: model.id,category: model.name,));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: homeBloc.todayDateTime$,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    default:
                  }
                  var dateString = DateFormat('dd/MM/yyyy').format(snapshot.data);
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                        '${Strings.CALLED_OPEN_MESSAGE} $dateString',
                      style: dayTitle,
                    ),
                  );
                }
            ),
            StreamBuilder(
                initialData: todayListNumber,
                stream: homeBloc.todayCalledStreamList,
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
                      itemCount: snapshot.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        CalledModel item = snapshot.data[index];
                        var dateCreatedString = DateFormat('dd/MM hh:mm').format(item.calledCreatedTime);
                        var dateFinishedString =  item.calledFinishedTime != null ? DateFormat('dd/MM hh:mm').format(item.calledFinishedTime) : '';
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            onTap: employeeBloc.user.status.index != 1 ? () async {
                              await Get.to(() => CalledDetailsModule(calledModel: item,));
                            } : (){

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
    );
  }
}