import 'package:flipcard_game/app/modules/home/views/flipcard_view1/flipcard_game_view.dart';
import 'package:flipcard_game/app/modules/home/views/flipcard_view2/flip_card_view2.dart';
import 'package:flipcard_game/app/modules/home/views/flipcard_view3/flip_card_view3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                // Image
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  alignment: AlignmentDirectional
                      .centerStart, // Mengatur alignment ke start
                  child: Row(
                    children: [
                      Image.asset(
                        "lib/app/assets/home.png",
                        fit: BoxFit.cover,
                        width: 200.0, // Sesuaikan lebar gambar sesuai kebutuhan
                        height: double.infinity,
                      ),
                      SizedBox(
                          width:
                              8.0), // Memberikan jarak antara gambar dan teks
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ayo",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50.0,
                                color: Colors.grey[
                                    800] // Se,suaikan dengan ukuran font yang diinginkan
                                ),
                          ),
                          Text(
                            "Belajar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50.0,
                                color: Colors.grey[
                                    800] // Sesuaikan dengan ukuran font yang diinginkan
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Cards
                Expanded(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCard(
                              'Sub Tema 1', 'Indahnya Peninggalan Sejarah', 5),
                          SizedBox(height: 10),
                          buildCard('Sub Tema 2', 'Budaya Negeriku', null),
                          SizedBox(height: 10),
                          buildCard(
                              'Sub Tema 3', 'Perjuangan Para Pahlawan', null),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, String subtitle, int? count) {
    return Card(
      color: Color(0xFFe9f3f3),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle),
              ],
            ),
            Spacer(),
            if (count != null)
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: Colors.red,
                  ),
                  Text(count.toString()),
                ],
              ),
          ],
        ),
        trailing: Icon(
          Icons.lock_open_rounded,
          color: Colors.yellow,
        ),
        onTap: () {
          if (title == 'Sub Tema 1') {
            Get.to(FlipGameView());
          } else if (title == 'Sub Tema 2') {
            Get.to(FlipGameView2());
          } else if (title == 'Sub Tema 3') {
            Get.to(FlipGameView3());
          } else {
            Get.snackbar("Page 404", "Page Not Found");
          }
        },
      ),
    );
  }
}
