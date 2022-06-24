import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/presentation/widgets/forms/textForm.dart';
import 'package:guru_bono/presentation/widgets/imgsContainers/circlularimg.dart';
import 'package:guru_bono/presentation/widgets/screenBase.dart';
import 'package:guru_bono/presentation/widgets/sideBar/navigationBloc.dart';
import 'package:guru_bono/presentation/widgets/texts/screentitle.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

class BonoNuevo extends StatefulWidget {
  BonoNuevo({Key? key}) : super(key: key);

  @override
  State<BonoNuevo> createState() => _BonoNuevoState();
}

class _BonoNuevoState extends State<BonoNuevo> {
  final TextStyle _txtStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  //Valores y controladores de los campos de texto
  final TextEditingController _valNominalController = TextEditingController();
  final TextEditingController _valComercialController = TextEditingController();
  final TextEditingController _numAnosController = TextEditingController();
  final TextEditingController _diasXAController = TextEditingController();
  final TextEditingController _tasaInteresController = TextEditingController();
  final TextEditingController _tasaAnualDsctoController =
      TextEditingController();
  final TextEditingController _impRentaController = TextEditingController();
  final TextEditingController _fecEmisionController = TextEditingController();
  final TextEditingController _primaController = TextEditingController();
  final TextEditingController _estructuracionController =
      TextEditingController();
  final TextEditingController _colocacionController = TextEditingController();
  final TextEditingController _flotacionController = TextEditingController();
  final TextEditingController _cavaliController = TextEditingController();

  final List<String> metodos = ["Americano", "Aleman", "Frances"];
  final List<String> moneda = ["USD", "PEN"];
  final List<String> frecCupon = [
    "Mensual",
    "Bimestral",
    "Trimestral",
    "Cuatrimestral",
    "Semestral",
    "Anual"
  ];
  final List<String> diasxAno = ["360", "365"];
  final List<String> tipTasa = ["Efectiva", "Nominal"];
  final List<String> capitalizacion = [
    "Diaria",
    "Quincenal",
    "Mensual",
    "Bimestral",
    "Trimestral",
    "Cuatrimestral",
    "Semestral",
    "Anual"
  ];

  Map<String, String?> selectedValues = {
    "Metodo": null,
    "Moneda": null,
    "FrecCupon": null,
    "diasxAno": null,
    "TipTasa": null,
    "Capitalizacion": null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            title: Container(
              alignment: Alignment.center,
              child: Image.asset('assets/imgs/guru_logo.png',
                  height: ScreenWH(context).height * 0.15,
                  width: ScreenWH(context).width * 0.3),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: greenPrimary,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: SingleChildScrollView(
          child: _body(context),
        ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const ScreenTitle(title: 'Nuevo Bono'),
        baseData(context),
        FormdelBono(context),
        const ScreenTitle(title: 'Costes/Gastos iniciales'),
        FormdeGastosCostos(context),
        const SizedBox(height: 10),
        SizedBox(
            width: ScreenWH(context).width * 0.9, child: saveButton(context)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget FormdelBono(BuildContext context) {
    txtForm _txtFormValNom = txtForm(
      title: 'Valor nominal',
      controller: _valNominalController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormValCom = txtForm(
      title: 'Valor comercial',
      controller: _valComercialController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFromNdeAnos = txtForm(
      title: 'N° de años',
      controller: _numAnosController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormDiasxAno = txtForm(
      title: 'Días por año',
      controller: _diasXAController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormTasainteres = txtForm(
      title: 'Tasa de interés',
      controller: _tasaInteresController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormTasaAnualDsct = txtForm(
      title: 'Tasa anual de descuento',
      controller: _tasaAnualDsctoController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormImpRenta = txtForm(
      title: 'Impuesto a la renta',
      controller: _impRentaController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormFecEmi = txtForm(
      title: 'Fecha de emisión',
      controller: _fecEmisionController,
      inputType: InputType.Default,
      form: true,
    );
    return SizedBox(
      width: ScreenWH(context).width * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormValNom),
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormValCom),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFromNdeAnos),
                dropdownMenu(context, 'Frec. del cupón', frecCupon, null,
                    ScreenWH(context).width * 0.41, "FrecCupon"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dropdownMenu(context, 'Días x Año', diasxAno, null,
                    ScreenWH(context).width * 0.41, "diasxAno"),
                dropdownMenu(context, 'Tipo tasa de interes', tipTasa, null,
                    ScreenWH(context).width * 0.41, "TipTasa"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dropdownMenu(context, 'Capitalización', capitalizacion, null,
                    ScreenWH(context).width * 0.41, "Capitalizacion"),
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormTasainteres),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dropdownMenu(context, 'Capitalización', capitalizacion, null,
                    ScreenWH(context).width * 0.41, "Capitalizacion"),
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormTasainteres),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormFecEmi),
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormImpRenta),
              ],
            ),
            const SizedBox(height: 10),
            _txtFormTasaAnualDsct,
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget FormdeGastosCostos(BuildContext context) {
    txtForm _txtFormPrima = txtForm(
      title: '% Prima',
      controller: _primaController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormEstructuracion = txtForm(
      title: '% Estructuración',
      controller: _estructuracionController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormColocacion = txtForm(
      title: '% Colocación',
      controller: _colocacionController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormFlotacion = txtForm(
      title: '% Flotación',
      controller: _flotacionController,
      inputType: InputType.Number,
      form: true,
    );
    txtForm _txtFormCAVALI = txtForm(
      title: '% CAVALI',
      controller: _cavaliController,
      inputType: InputType.Number,
      form: true,
    );
    return SizedBox(
      width: ScreenWH(context).width * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormPrima),
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormEstructuracion),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormColocacion),
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormFlotacion),
              ],
            ),
            const SizedBox(height: 10),
            _txtFormCAVALI,
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          primary: greenPrimary, padding: EdgeInsets.all(10)),
      child: const Text(
        'Guardar',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget baseData(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircularImg(
            pathImg: 'assets/imgs/bono_icon.png',
            vHeight: 140,
            vWidth: 140,
          ),
          Column(
            children: [
              dropdownMenu(context, 'Metodo de cálculo', metodos, null,
                  ScreenWH(context).width * 0.45, "Metodo"),
              const SizedBox(height: 10),
              dropdownMenu(context, 'Moneda', moneda, null,
                  ScreenWH(context).width * 0.45, "Moneda"),
            ],
          ),
        ],
      ),
    );
  }

  Widget dropdownMenu(BuildContext context, String title, List<String> items,
      String? placeholder, double menuWidth, String valName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: txtPrimary,
                  decoration: TextDecoration.none),
            )),
        CustomDropdownButton2(
          buttonHeight: 45,
          buttonWidth: menuWidth,
          dropdownWidth: menuWidth,
          hint: placeholder ?? 'Seleccione',
          dropdownItems: items,
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderGrey,
              width: 2,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 20,
          value: selectedValues[valName],
          onChanged: (value) {
            setState(() {
              selectedValues[valName] = value;
            });
          },
        ),
      ],
    );
  }
}
