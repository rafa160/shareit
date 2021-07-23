
import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:share_it/components/custom_toast.dart';
import 'package:share_it/helpers/utils.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/employee_model.dart';

class EmailHelper {

  String appName = 'share_it_app@hotmail.com';
  String password = 'Oakraiders1986';
  List<dynamic> emails = ['share_it_app@hotmail.com', 'rafaelpaz86@gmail.com'];

  Future<bool> sendMessageToCompanyPlanZero(String plan, String receiver, String employeesNumbers, String name) async {
    final smtpServer = yahoo(appName, password);
    final message = Message()
        ..from = Address(appName, 'Share IT App')
        ..recipients.add(receiver)
        ..subject = 'Inscrição no Share IT'
      ..html = "<h1 style='color:green'>ShareIT App</h1> <p>&#128525;</p>\n <p>Olá, $name.\n</p> <p>Vamos lá, você escolheu o $plan.\n Para começar, caso você não tenha cadastrado os $employeesNumbers funcionarios pelo App é preciso enviar algumas informações.\n</p>"
          "<p>Para cadastrar no $plan é necessario </p> <i> separar os funcionarios em 3 setores, Gerencia, Funcionário, Suporte</i>\n"
          "<ul><li>e-mail</li><li>nome completo</li><li>cargo</li></ul>\n"
          "<p>após realização do cadastro de todos os funcionarios enviaremos um e-mail com login e senha.</p>\n"
          "<p>Por favor lembrar de informar os responsaveis pelo suporte(Equipe que irá resolver os chamados).</p>\n\n"
          "<p>Caso você tenha cadastrado pelo App, desconsidere o e-mail e aguarde a confirmação de liberação dos cadastros.</p>";

    try {
      var connection = PersistentConnection(smtpServer);
      final sendReport = await send(message,  smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        CustomToast.fail('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }

  Future<bool> sendEmailToSupport(
      List<dynamic> emails, EmployeeModel employeeModel, CalledModel calledModel, DateTime date) async {
    final smtpServer = hotmail(appName, password);
    var time = formatDate(date);
    final message = Message()
      ..from = Address(appName, 'Share IT')
      ..recipients.addAll(emails)
      ..subject = 'Um chamado foi criado por ${employeeModel.name}'
      ..html = "<h1 style='color:green'>ShareIT App</h1>\n"
          "<p>O Funcionário ${employeeModel.email} criou uma solicitação.</p>\n"
          "<p>Assunto: ${calledModel.subject}</p>\n\n"
          "Criado em:  <i>$time</i>";
    try {
      var connection = PersistentConnection(smtpServer);
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        CustomToast.fail('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}