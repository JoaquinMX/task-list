import 'package:flutter/material.dart';
import 'package:task_list/app/view/components/shape.dart';
import 'package:task_list/app/view/components/title.dart';
import 'package:task_list/app/view/home/inherited_widgets.dart';
import 'package:task_list/app/view/task_list/task_list_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatelessWidget {
  final Uri _url = Uri.parse('https://docs.flutter.dev/tos');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Shape(),
            ],
          ),
          const SizedBox(
            height: 79,
          ),
          Image.asset(
            "assets/images/onboarding-image.png",
            width: 180,
            height: 168,
          ),
          const SizedBox(
            height: 99,
          ),
          const H1("Lista de Tareas"),
          Text("Inherited Widget", style: TextStyle(
            color: SpecialColor.of(context).color
          ),),
          const SizedBox(
            height: 21,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TaskListPage();
              }));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                _launchUrl(_url.toString());
              },
              child: const Text("Términos y Condiciones")),
      ]
        )
    );
  }
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}