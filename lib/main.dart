import 'package:flutter/material.dart';
import './pages/page_menu_generator.dart';
import './pages/page_recipes.dart';

void main() {
  runApp(const GardMenu());
}

class GardMenu extends StatelessWidget {
  const GardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gard Menu',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Color.fromARGB(255, 4, 139, 154), // Background color
            foregroundColor: Colors.white, // Text color
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold), // Text style
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14), // Button shape
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

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
                      const Text(
                          "Gardmenu c'est l'application qui vous permet d'écrire et de stocker vos recettes de cuisine à vous ! Faites votre liste d'ingrédients avec les quantités, écrivez les instructions de réalisation, ajouter une photo et voilà !"),
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
