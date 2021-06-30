
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:share_it/components/custom_toast.dart';

class EmailHelper {

  String appName = 'lord_spfc@hotmail.com';
  String password = 'oakraiders1986';

  Future<bool> sendMessageToCompanyPlanZero(String plan, String receiver, String employeesNumbers, String name) async {
    final smtpServer = hotmail(appName, password);
    final message = Message()
        ..from = Address(appName, 'ShareIT App')
        ..recipients.add(receiver)
        ..subject = 'Inscrição no ShareIT'
      ..html = "<h1 style='color:green'>ShareIT App</h1> <p>&#128525;</p>\n <p>Olá, $name.\n</p> <p>Vamos lá, você escolheu o $plan.\n Para começar é preciso enviar algumas informações dos $employeesNumbers funcionarios.\n</p>"
          "<p>Para cadastrar no $plan é necessario </p> <i> separar os funcionarios em 3 setores, Gerencia, Funcionario, Suporte</i>>\n"
          "<ul><li>e-mail</li><li>nome completo</li><li>cargo</li></ul>\n"
          "<p>após realização do cadastro de todos os funcionarios enviaremos um e-mail com login e senha.</p>\n"
          "<p>Por favor lembrar de informar os responsaveis pelo suporte(Equipe que irá resolver os chamados).</p>";

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


}