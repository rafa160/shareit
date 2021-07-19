import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/screens/tour/components/tour_container.dart';

class TourScreen extends StatefulWidget {
  @override
  _TourScreenState createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {

  var userBloc = AppModule.to.getBloc<EmployeeBloc>();

  int currentPage = 0;

  List<Map<String, String>> tourData = [
    {
      'text':
      'Bem-vindo ao Share IT App',
      'image': 'assets/images/shareit.png',
    },
    {
      'text':
      'Gerencie seus chamados na palma da mão. atualização de status em tempo real.',
      'image': 'assets/images/phone.png',
    },
    {
      'text':
      'Crie chamados diretamente para sua área de Suporte. Controlando o tempo de criação e finalização de um chamado.',
      'image': 'assets/images/suporte.png',
    },
    {
      'text':
      'O Grafico mostra qual área seu time está com mais problemas.',
      'image': 'assets/images/pie2.png',
    },
    {
      'text':
      'Agora você esta pronto para usar nosso sistema.',
      'image': 'assets/images/rocket.png',
    },
  ];

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 2),
      height: 6,
      width: currentPage == index ? 15 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Colors.blue
            : Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: ScreenUtil.screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.lightBlueAccent,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                  child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      itemCount: tourData.length,
                    itemBuilder: (context, index) => TourContainer(
                      text: tourData[index]['text'],
                      image: tourData[index]['image'],
                    ),
                  ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          tourData.length, (index) => buildDot(index: index)),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: userBloc.loginStream,
                initialData: [],
                builder: (context, snapshot) {
                  if(snapshot.data != true) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child:  CustomButton(
                        onPressed: currentPage == 4 ? () async {
                          await userBloc.update(userBloc);
                        } : null,
                        widget: currentPage == 4 ? Text('continuar') : Text(''),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomButton(
                        onPressed: () {},
                        widget: CustomColorCircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
