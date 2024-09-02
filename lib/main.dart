import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

// Forma personalizada del AppBar
class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double x = 210; // Ajusta el valor según sea necesario para la curvatura
    double y = rect.bottomRight.dy;
    Path path = super.getOuterPath(rect, textDirection: textDirection);
    path.lineTo(rect.width, y);
    path.quadraticBezierTo(rect.width - x, y + x / 2, rect.width - 2 * x, y);
    path.lineTo(rect.width - rect.width, y);
    return path;
  }
}

class Pokemon {
  final String nombre;
  final List<String> tipo;
  final int numeroPokedex;
  final String imagenUrl;

  Pokemon(
      {required this.nombre,
      required this.tipo,
      required this.numeroPokedex,
      required this.imagenUrl});
}

class MyApp extends StatelessWidget {
  final List<Pokemon> pokemones = [
    Pokemon(
        nombre: 'Bulbasaur',
        tipo: ['Planta', 'Veneno'],
        numeroPokedex: 001,
        imagenUrl: './assets/001.png'),
    Pokemon(
        nombre: 'Charmander',
        tipo: ['Fuego'],
        numeroPokedex: 004,
        imagenUrl: './assets/002.png'),
    Pokemon(
        nombre: 'Squirtle',
        tipo: ['Agua'],
        numeroPokedex: 007,
        imagenUrl: './assets/003.png'),
    Pokemon(
        nombre: 'Pikachu',
        tipo: ['Eléctrico'],
        numeroPokedex: 025,
        imagenUrl: './assets/004.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
              backgroundColor: Colors.pink,
              shape: CustomShapeBorder(),
              centerTitle: true,
              title: Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text(
                  'Pokédex Kanto',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'Nunito'),
                ),
              )),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '',
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: CarouselSlider.builder(
                  itemCount: pokemones.length,
                  options: CarouselOptions(
                    height: 330.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                    aspectRatio: 2.0,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return buildCard(pokemones[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(Pokemon pokemon) {
    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            pokemon.imagenUrl,
            height: 180.0,
            width: 180.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10.0),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pokemon.nombre,
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '#00${pokemon.numeroPokedex}',
                  style: const TextStyle(fontSize: 23.0),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                buildTags(pokemon.tipo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTags(List<String> tipos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var tipo in tipos) buildTag(tipo),
      ],
    );
  }

  Widget buildTag(String tipo) {
    Color color;
    switch (tipo.toLowerCase()) {
      case 'planta':
        color = Colors.green;
        break;
      case 'fuego':
        color = Colors.orange;
        break;
      case 'agua':
        color = Colors.blue;
        break;
      case 'veneno':
        color = Colors.purple;
        break;
      case 'eléctrico':
        color = Colors.yellow;
        break;
      // Agrega más casos según sea necesario
      default:
        color = Colors.grey;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        tipo,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
