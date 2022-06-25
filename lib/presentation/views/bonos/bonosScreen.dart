import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/data/service/bonoService.dart';
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

class BonosScreen extends StatefulWidget with NavigationStates {
  BonosScreen({Key? key}) : super(key: key);

  @override
  State<BonosScreen> createState() => _BonosScreenState();
}

class _BonosScreenState extends State<BonosScreen> {
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

    Widget nodata() {
      return Center(
        child: Column(
          children: [
            Image.asset(
              'assets/imgs/sin_bonos.png',
              width: 250,
              height: 350,
            ),
            const Text('Aún no agregas un bono')
          ],
        ),
      );
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
                      child: FutureBuilder(
                          future: bonoService().getBonos(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: greenPrimary,
                              ));
                            } else {
                              List<Bono> lstBonos = snapshot.data as List<Bono>;
                              List<Bono> lstBonosUSD = lstBonos
                                  .where((bono) => bono.moneda == "USD")
                                  .toList();
                              List<Bono> lstBonosPEN = lstBonos
                                  .where((bono) => bono.moneda == "PEN")
                                  .toList();
                              return TabBarView(children: [
                                lstBonosUSD.isNotEmpty
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Searchbar(
                                                placeholder: "Buscar bono",
                                                controller:
                                                    searchBonosController),
                                          ),
                                          Expanded(
                                              child: ListView.builder(
                                            itemCount: lstBonosUSD.length,
                                            itemBuilder: (context, index) {
                                              return cardBono(
                                                  bono: lstBonosUSD[index]);
                                            },
                                          )),
                                        ],
                                      )
                                    : nodata(),
                                lstBonosPEN.isNotEmpty
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Searchbar(
                                                placeholder: "Buscar bono",
                                                controller:
                                                    searchBonosController),
                                          ),
                                          Expanded(
                                              child: ListView.builder(
                                            itemCount: lstBonosPEN.length,
                                            itemBuilder: (context, index) {
                                              return cardBono(
                                                  bono: lstBonosPEN[index]);
                                            },
                                          )),
                                        ],
                                      )
                                    : nodata(),
                              ]);
                            }
                          }),
                    )
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
        ],
      );
    }

    return ScreenBase(
        body: Center(
      child: _body(),
    ));
  }
}
