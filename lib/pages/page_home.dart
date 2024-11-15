import 'package:flutter/material.dart';
import 'package:gardmenu_training/pages/page_menu_generator.dart';
import 'package:gardmenu_training/pages/page_recipes.dart';
import 'package:gardmenu_training/widgets/atoms/text_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gard Menu'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 146, 106)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Générateur de menu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageMenuGenerator(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Mes recettes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, right: 16, bottom: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 146, 106),
                ),
                child: Center(
                  child: Text(
                    'Bienvenue dans Gard Menu !',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image(
                    image: AssetImage('/images/cookbook.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Qu'est-ce que Gardmenu ?",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      const Text(
                          "Gardmenu c'est l'application qui vous permet d'écrire et de stocker vos recettes de cuisine à vous ! Faites votre liste d'ingrédients avec les quantités, écrivez les instructions de réalisation, ajouter une photo et voilà !"),
                      SizedBox(height: 15),
                      Wrap(
                        runSpacing: 15,
                        children: const [
                          TextCardWidget(
                              text:
                                  "Mais aussi c'est un Générateur de Menu de la semaine !"),
                          TextCardWidget(
                              text:
                                  "Choisissez le type de menu que vous souhaitez pour la semaine, verrouillez et regénérer votre menu jusqu'à ce qu'il vous plaise !"),
                          TextCardWidget(
                              text:
                                  "Le générateur vous fournit la liste de tous les ingrédients nécessaires pour préparer les plats de la semaine!"),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
