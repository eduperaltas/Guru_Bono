import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class estadoDialog extends StatelessWidget {
  const estadoDialog({Key? key}) : super(key: key);

  Widget listTimeLine() {
    return ListView(
      shrinkWrap: true,
      children: [
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF27AA69),
            padding: EdgeInsets.all(6),
          ),
          endChild: const _RightChild(
            icon: Icons.check_circle_outline_outlined,
            date: '29/10/2022',
            title: 'Pedido aprobado',
            message: 'El pedido fue aprobado.',
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF27AA69),
            padding: EdgeInsets.all(6),
          ),
          endChild: const _RightChild(
            icon: Icons.receipt_long_outlined,
            date: '29/10/2022',
            title: 'Facturado',
            message: 'El pedido fue facturado.',
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF2B619C),
            padding: EdgeInsets.all(6),
          ),
          endChild: const _RightChild(
            icon: Icons.local_shipping_outlined,
            date: '31/10/2022',
            title: 'Enviado',
            message: 'El pedido fue despachado.',
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
          afterLineStyle: LineStyle(
            color: const Color(0xFFDADADA).withOpacity(0.5),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isLast: true,
          indicatorStyle: IndicatorStyle(
            width: 20,
            color: const Color(0xFFDADADA).withOpacity(0.5),
            padding: const EdgeInsets.all(6),
          ),
          endChild: const _RightChild(
            disabled: true,
            icon: Icons.shopping_bag_sharp,
            date: '01/11/2022',
            title: 'Entregado',
            message: 'El pedido fue entregado.',
          ),
          beforeLineStyle: LineStyle(
            color: const Color(0xFFDADADA).withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: greenDark,
      child: SizedBox(
        height: 470,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10, left: 15),
                child: const Text(
                  'Historial de estados: ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  height: 3,
                  width: ScreenWH(context).width * 0.35,
                  decoration: const BoxDecoration(
                    color: greenSoft,
                  )),
            ),
            //Body
            Expanded(child: listTimeLine())
          ],
        ),
      ),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    required this.date,
    this.disabled = false,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String message;
  final String date;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Icon(
              icon,
              color: disabled ? greenSoft3.withOpacity(0.5) : greenSoft3,
              size: 50,
            ),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: disabled
                      ? const Color(0xFF636564).withOpacity(0.5)
                      : const Color(0xFF636564),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: disabled
                      ? const Color(0xFF636564).withOpacity(0.5)
                      : const Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                // height: 50,
                width: ScreenWH(context).width * 0.47,
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: disabled
                        ? const Color(0xFF636564).withOpacity(0.5)
                        : const Color(0xFF636564),
                    fontSize: 14,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
