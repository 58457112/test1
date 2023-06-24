import 'package:flutter/material.dart';
import 'package:test1/ressources/consts_global.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool _isExpanded = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;
  bool _isExpanded4 = false;
  bool _isExpanded5 = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleExpanded2() {
    setState(() {
      _isExpanded2 = !_isExpanded2;
    });
  }

  void _toggleExpanded3() {
    setState(() {
      _isExpanded3 = !_isExpanded3;
    });
  }

  void _toggleExpanded4() {
    setState(() {
      _isExpanded4 = !_isExpanded4;
    });
  }

  void _toggleExpanded5() {
    setState(() {
      _isExpanded5 = !_isExpanded5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Bonjour',
                    style: TextStyle(fontSize: 25, fontFamily: 'font1'),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.waving_hand,
                    color: Colors.amber,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "L'equipe Support Patient est composée d'opérateurs formés a vous accompagner sur Healthy Steps , et a repondre a touters vos questions",
                  style: TextStyle(fontSize: 15, fontFamily: 'font3')),
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/bb/39/16/bb3916e369a617542556b9204bc508ef.jpg'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _toggleExpanded,
                child: Text(
                  "Comment puis-je prendre un rendez-vous ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'font3',
                    fontSize: 18,
                    color: solcolor1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (_isExpanded)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Pour prendre un rendez-vous, cliquez sur le bouton 'Prendre un rendez-vous' dans l'onglet principal de l'application. Ensuite, sélectionnez le médecin que vous souhaitez voir, choisissez la date et l'heure qui vous conviennent, et confirmez votre rendez-vous.",
                    style: TextStyle(
                      fontFamily: 'font3',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _toggleExpanded2,
                child: Text(
                  " Comment puis-je voir mes rendez-vous  ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'font3',
                    fontSize: 18,
                    color: solcolor1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (_isExpanded2)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Pour voir vos rendez-vous à venir, accédez à la section 'Mes rendez-vous' de l'application. Vous verrez une liste de tous vos rendez-vous",
                    style: TextStyle(
                      fontFamily: 'font3',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _toggleExpanded3,
                child: Text(
                  "Comment contacter mon médecin ?",
                  style: TextStyle(
                    fontFamily: 'font3',
                    fontSize: 18,
                    color: solcolor1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (_isExpanded3)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    " Pour contacter votre médecin, accédez à la section 'Mes médecins' de l'application et sélectionnez le médecin que vous souhaitez contacter. Vous pouvez alors voir son numéro de téléphone et son adresse e-mail, ainsi que d'autres informations de contact si elles sont disponibles.",
                    style: TextStyle(
                      fontFamily: 'font3',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _toggleExpanded4,
                child: Text(
                  "Comment puis-je modifier mes informations personnelles ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'font3',
                    fontSize: 18,
                    color: solcolor1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (_isExpanded4)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    " Pour modifier vos informations personnelles, accédez à la section 'Mon profil' de l'application. Vous pouvez alors mettre à jour votre nom, votre adresse, votre numéro de téléphone, votre adresse e-mail, et d'autres informations personnelles si nécessaire.",
                    style: TextStyle(
                      fontFamily: 'font3',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _toggleExpanded5,
                child: Text(
                  "Tu ne comprends pas comment t\'inscrire ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'font3',
                    fontSize: 18,
                    color: solcolor1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (_isExpanded5)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Pour t\'inscrire, tu dois remplir un formulaire en ligne avec tes informations personnelles.",
                    style: TextStyle(
                      fontFamily: 'font3',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
