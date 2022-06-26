import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:guru_bono/core/framework/colors.dart';
import 'package:flutter/material.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/data/service/bonoService.dart';
import 'package:guru_bono/presentation/views/bonos/widgets/bonoCalendario.dart';
import 'package:guru_bono/presentation/views/bonos/widgets/bonoEdit.dart';
import 'package:guru_bono/presentation/views/bonos/widgets/bonoResultados.dart';
import 'package:intl/intl.dart';

class cardBono extends StatelessWidget {
  cardBono({Key key, this.bono, this.totValMercado}) : super(key: key);

  final Bono bono;
  final double totValMercado;

  getResultado(BuildContext context) async {
    ResultadoBono res =
        await bonoService().getResultadoBono(bono.id ?? "") as ResultadoBono;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BonoResultados(
          bonoResultado: res,
          bono: bono,
        ),
      ),
    );
  }

  orderListByDate(List<CalendarioPagos> list) {
    list.sort((a, b) => DateFormat('dd-MM-yyyy')
        .parse(a.fechaProg)
        .compareTo(DateFormat('dd-MM-yyyy').parse(b.fechaProg)));
    return list;
  }

  getCronograma(BuildContext context) async {
    List<CalendarioPagos> lstPagos =
        await bonoService().getCalendar(bono.id ?? "");
    lstPagos = await orderListByDate(lstPagos);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BonoCalendario(
          bono: bono,
          calPagos: lstPagos,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int cantidad = bono.cantidad;
    double valNominal = bono.valNominal;
    double precioCompra = bono.valComercial;
    double inversion = cantidad * precioCompra;
    double precioMercado = bono.precMercado;
    double valMercado = cantidad * precioMercado;
    double ganPer = valMercado - inversion;
    double rentabilidad = ganPer / inversion;
    double portafolio = valMercado / totValMercado;
    Widget subData(String val1, String val2) {
      return Row(
        children: [
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
            val1,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
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
              subData('Val nominal: ${valNominal.toStringAsFixed(2)}', ''),
              subData('Precio Compra: ${precioCompra.toStringAsFixed(2)}', ""),
              const SizedBox(
                height: 1,
              ),
              subData('Inversión: ${inversion.toStringAsFixed(2)}', ''),
              const SizedBox(
                height: 1,
              ),
              subData(
                  'Precio mercado: ${precioMercado.toStringAsFixed(2)}', ""),
              subData('Val mercado: ${valMercado.toStringAsFixed(2)}', ''),
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
                  height: 100,
                  width: 100,
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
                '${(portafolio * 100).toStringAsFixed(2)}%',
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
                ganPer.toStringAsFixed(2),
              ),
              const SizedBox(width: 10),
              section(
                const Icon(
                  Icons.show_chart_outlined,
                  color: Colors.black,
                ),
                'Rentabilidad',
                '${((rentabilidad) * 100).toStringAsFixed(2)}%',
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
                  onTap: () {
                    getCronograma(context);
                  },
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
                    getResultado(context);
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
