import 'package:guru_bono/presentation/views/bonos/widgets/bonoNuevo.dart';
import 'package:guru_bono/presentation/widgets/cards/cardBono.dart';
import 'package:guru_bono/presentation/widgets/forms/searchBar.dart';
import 'package:guru_bono/presentation/widgets/screenBase.dart';
import 'package:guru_bono/presentation/widgets/sideBar/navigationBloc.dart';
import 'package:flutter/material.dart';

import '../../../core/framework/colors.dart';
import '../../../core/framework/globals.dart';
import '../../widgets/forms/textForm.dart';
import '../../widgets/texts/screentitle.dart';

class BonosScreen extends StatelessWidget with NavigationStates {
  BonosScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  TextEditingController searchBonosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget btnNuevoCliente(BuildContext context) {
      return ElevatedButton(
          onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BonoNuevo()),
                )
              },
          style: ElevatedButton.styleFrom(
              primary: greenSoft2,
              elevation: 0,
              fixedSize: Size(ScreenWH(context).width * 0.55, 55)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: greenSoft2,
                    size: 40,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Agregar Bono',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: txtPrimary,
                    ),
                  ),
                ],
              )
            ],
          ));
    }

    Widget tab() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TabBar(
                      unselectedLabelColor: Colors.black54,
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(50), // Creates border
                          color: greenPrimary),
                      tabs: const [
                        Tab(
                          child: Text(
                            "USD",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "PEN",
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Searchbar(
                                  placeholder: "Buscar bono",
                                  controller: searchBonosController),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return cardBono();
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Searchbar(
                                  placeholder: "Buscar bono",
                                  controller: searchBonosController),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return cardBono();
                                },
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              )),
        ),
      );
    }

    Widget _body() {
      return Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ScreenTitle(title: 'Bonos'),
              btnNuevoCliente(context),
            ],
          ),
          tab()
          // cardBono(),
          // Expanded(
          //   child: ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: clientes.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return ContactCard(cliente: clientes[index]);
          //       }),
          // ),
        ],
      );
    }

    return ScreenBase(
        body: Center(
      child: _body(),
    ));
  }
}
