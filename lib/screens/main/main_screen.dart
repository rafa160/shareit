import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_icon_button.dart';
import 'package:share_it/screens/home/home_module.dart';
import 'package:share_it/screens/profile/profile_module.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: <Widget>[
              HomeModule(),
              Container(
                color: Colors.redAccent,
              ),
              Container(
                color: Colors.white,
              ),
              ProfileModule(),
            ]),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: ScreenUtil.screenHeight * 0.07,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 0.3,),
                CustomIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.home,
                    size: 20,
                    color:
                    _page == 0 ? Theme.of(context).accentColor : Colors.black,
                  ),
                  onTap: () {
                    _pageController.jumpToPage(0);
                  },
                  text: 'home',
                  color: _page == 0 ? Theme.of(context).accentColor : Colors.black,
                ),
                CustomIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.list,
                    size: 20,
                    color:
                    _page == 1 ? Theme.of(context).accentColor : Colors.black,
                  ),
                  onTap: () {
                    _pageController.jumpToPage(1);
                  },
                  text: 'chamados',
                  color: _page == 1 ? Theme.of(context).accentColor : Colors.black,
                ),
                CustomIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.sitemap,
                    size: 20,
                    color:
                    _page == 2 ? Theme.of(context).accentColor : Colors.black,
                  ),
                  onTap: () {
                    _pageController.jumpToPage(2);
                  },
                  text: 'info',
                  color: _page == 2 ? Theme.of(context).accentColor : Colors.black,
                ),
                CustomIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.userCog,
                    size: 20,
                    color:
                    _page == 3 ? Theme.of(context).accentColor : Colors.black,
                  ),
                  onTap: () {
                    _pageController.jumpToPage(3);
                  },
                  text: 'perfil',
                  color: _page == 3 ? Theme.of(context).accentColor : Colors.black,
                ),
                SizedBox(width: 0.3),
              ],
            ),
          ),
        ),
    );
  }
}
