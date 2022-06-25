import 'dart:async';

import 'package:guru_bono/core/framework/colors.dart';
import 'package:flutter/material.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/presentation/views/bonos/widgets/bonoEdit.dart';
import 'package:guru_bono/presentation/views/bonos/widgets/bonoResultados.dart';

class cardBono extends StatelessWidget {
  cardBono({Key? key, required this.bono}) : super(key: key);

  final Bono bono;
  @override
  Widget build(BuildContext context) {
    Widget subData(String val1, String val2) {
      return Row(
        children: [
          Text(
            val1,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              color: txtgrey,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 4,
            width: 4,
          ),
          const SizedBox(width: 5),
          Text(
            val2,
            style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 12, color: txtgrey),
          ),
        ],
      );
    }

    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bono.nombre,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              subData('Val nominal: ${bono.valNominal}',
                  'Precio Compra: ${bono.valComercial}'),
              const SizedBox(
                height: 1,
              ),
              subData(
                  'Precio mercado: ${bono.precMercado}', 'Val mercado: 6000'),
              const SizedBox(
                height: 1,
              ),
              subData('Inversión: ${bono.cantidad * bono.valComercial}',
                  'Moneda: ${bono.moneda}'),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BonoEdit(bono: bono),
                ),
              );
            },
            child: Stack(
              children: [
                Positioned(
                  top: -3,
                  right: -1,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: greenPrimary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: greenPrimary,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset("assets/imgs/bono_iconNoBorder.png"),
                ),
              ],
            ),
          )
        ],
      );
    }

    Widget section(Icon icon, String title, String subtitle) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: greenSoft3,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: icon,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontSize: 14, color: txtgrey),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget body() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              section(
                const Icon(
                  Icons.feed_outlined,
                  color: Colors.black,
                ),
                'Cantidad:',
                '${bono.cantidad}',
              ),
              const SizedBox(width: 10),
              section(
                const Icon(
                  Icons.work_outline,
                  color: Colors.black,
                ),
                'Portafolio',
                '20.00%',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              section(
                const Icon(
                  Icons.swap_vert,
                  color: Colors.black,
                ),
                ' Ganancia/Perdida:',
                '18',
              ),
              const SizedBox(width: 10),
              section(
                const Icon(
                  Icons.show_chart_outlined,
                  color: Colors.black,
                ),
                'Rentabilidad',
                '20.00%',
              ),
            ],
          ),
        ],
      );
    }

    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: borderGrey, spreadRadius: 1)]),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            header(),
            const SizedBox(
              height: 15,
            ),
            body(),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.event,
                        color: greenSoft,
                      ),
                      Text(
                        'Cronograma de pagos',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: txtgrey),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BonoResultados(
                            bonoName: bono.nombre + bono.moneda,
                          );
                        });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Resultados',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: txtgrey),
                      ),
                      Icon(
                        Icons.info_outline,
                        color: greenSoft,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
