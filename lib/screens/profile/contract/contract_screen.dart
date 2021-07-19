import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/blocs/company_bloc.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_plan_card.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/helpers/strings.dart';
import 'package:share_it/models/company_model.dart';
import 'package:share_it/screens/profile/contract/contract_module.dart';

class ContractScreen extends StatefulWidget {
  final String companyId;

  const ContractScreen({Key key, this.companyId}) : super(key: key);

  @override
  _ContractScreenState createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  var companyBloc = ContractModule.to.getBloc<CompanyBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.APPBAR_TITLE_CONTRACT,
          style: appBarTitle,
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: companyBloc.getCompanyById(widget.companyId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    default:
                  }
                  CompanyModel companyModel = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Strings.CONTRACT_OWNER} ${companyModel.name}',
                          style: textPlanCard,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.DOC_HINT,
                              style: textPlanCard,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              companyModel.document,
                              style: textPlanCard,
                            )
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.EMAIL_HINT_TWO,
                              style: textPlanCard,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              companyModel.email,
                              style: textPlanCard,
                            )
                          ],
                        ),
                        Divider(),
                        // SizedBox(
                        //   height: 40,
                        // ),
                        // Center(child: Text(Strings.PLAN_INFO.toUpperCase(), style: appBarTitle,)),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Center(
                        //   child: CustomPlanCard(
                        //     title: companyModel.planModel.name,
                        //     subTitle: companyModel.planModel.value,
                        //     text: '',
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
