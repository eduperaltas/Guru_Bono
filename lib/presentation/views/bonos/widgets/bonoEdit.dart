import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/data/service/bonoService.dart';
import 'package:guru_bono/presentation/views/bonos/bonosScreen.dart';
import 'package:guru_bono/presentation/widgets/forms/textForm.dart';
import 'package:guru_bono/presentation/widgets/imgsContainers/circlularimg.dart';
import 'package:guru_bono/presentation/widgets/screenBase.dart';
import 'package:guru_bono/presentation/widgets/sideBar/navigationBloc.dart';
import 'package:guru_bono/presentation/widgets/texts/screentitle.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

class BonoEdit extends StatefulWidget {
  BonoEdit({Key key, this.bono}) : super(key: key);
  final Bono bono;

  @override
  State<BonoEdit> createState() => _BonoEditState();
}

class _BonoEditState extends State<BonoEdit> {
  final TextStyle _txtStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  //Valores y controladores de los campos de texto
  final TextEditingController _valNominalController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
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
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precMercadoController = TextEditingController();

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
  final List<String> sujetoGasto = ["Emisor", "Bonista", "Ambos"];

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

  Map<String, String> selectedValues = {
    "Metodo": null,
    "Moneda": null,
    "FrecCupon": null,
    "diasxAno": null,
    "TipTasa": null,
    "Capitalizacion": null,
    "sujEst": null,
    "sujCol": null,
    "sujFlo": null,
    "sujCav": null,
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
        const ScreenTitle(title: 'Editar Bono'),
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
    txtForm _txtFormNombre = txtForm(
      title: 'Nombre',
      controller: _nombreController,
      inputType: InputType.Default,
      placeholder: widget.bono.nombre,
      form: true,
    );
    txtForm _txtFormCantidad = txtForm(
      title: 'Cantidad',
      controller: _cantidadController,
      inputType: InputType.Number,
      placeholder: widget.bono.cantidad.toString(),
      form: true,
    );
    txtForm _txtFormPrecMerc = txtForm(
      title: 'Precio de mercado',
      controller: _precMercadoController,
      inputType: InputType.Number,
      placeholder: widget.bono.precMercado.toString(),
      form: true,
    );
    txtForm _txtFormValNom = txtForm(
      title: 'Valor nominal',
      controller: _valNominalController,
      inputType: InputType.Number,
      placeholder: widget.bono.valNominal.toString(),
      form: true,
    );
    txtForm _txtFormValCom = txtForm(
      title: 'Valor comercial',
      controller: _valComercialController,
      inputType: InputType.Number,
      placeholder: widget.bono.valComercial.toString(),
      form: true,
    );
    txtForm _txtFromNdeAnos = txtForm(
      title: 'N° de años',
      controller: _numAnosController,
      inputType: InputType.Number,
      placeholder: widget.bono.NdeAnos.toString(),
      form: true,
    );
    txtForm _txtFormDiasxAno = txtForm(
      title: 'Días por año',
      controller: _diasXAController,
      inputType: InputType.Number,
      placeholder: widget.bono.diasXAno.toString(),
      form: true,
    );
    txtForm _txtFormTasainteres = txtForm(
      title: 'Tasa de interés %',
      controller: _tasaInteresController,
      inputType: InputType.Number,
      placeholder: (widget.bono.tasaInteres * 100).toStringAsFixed(2),
      form: true,
    );
    txtForm _txtFormTasaAnualDsct = txtForm(
      title: 'Tasa anual de descuento %',
      controller: _tasaAnualDsctoController,
      inputType: InputType.Number,
      placeholder: (widget.bono.tasaAnualDscto * 100).toStringAsFixed(2),
      form: true,
    );
    txtForm _txtFormImpRenta = txtForm(
      title: 'Imp. a la renta %',
      controller: _impRentaController,
      inputType: InputType.Number,
      placeholder: (widget.bono.impuestoRenta * 100).toStringAsFixed(2),
      form: true,
    );
    txtForm _txtFormFecEmi = txtForm(
      title: 'Fecha de emisión',
      controller: _fecEmisionController,
      inputType: InputType.Default,
      placeholder: widget.bono.fecEmision.toString(),
      form: true,
    );
    return SizedBox(
      width: ScreenWH(context).width * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _txtFormNombre,
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormCantidad),
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormPrecMerc),
              ],
            ),
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
                dropdownMenu(
                    context,
                    'Frec. del cupón',
                    frecCupon,
                    widget.bono.frecCupon,
                    ScreenWH(context).width * 0.41,
                    "FrecCupon"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dropdownMenu(
                    context,
                    'Días x Año',
                    diasxAno,
                    widget.bono.diasXAno,
                    ScreenWH(context).width * 0.41,
                    "diasxAno"),
                dropdownMenu(
                    context,
                    'Tipo tasa de interes',
                    tipTasa,
                    widget.bono.tipTasaInteres,
                    ScreenWH(context).width * 0.41,
                    "TipTasa"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dropdownMenu(
                    context,
                    'Capitalización',
                    capitalizacion,
                    widget.bono.capitalizacion,
                    ScreenWH(context).width * 0.41,
                    "Capitalizacion"),
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
      placeholder: (widget.bono.prima * 100).toStringAsFixed(2),
      form: true,
    );
    txtForm _txtFormEstructuracion = txtForm(
      title: '% Estructuración',
      controller: _estructuracionController,
      inputType: InputType.Number,
      placeholder:
          (double.parse(widget.bono.estructuracion.split('-')[0]) * 100)
              .toStringAsFixed(2),
      form: true,
    );
    txtForm _txtFormColocacion = txtForm(
      title: '% Colocación',
      controller: _colocacionController,
      inputType: InputType.Number,
      placeholder: (double.parse(widget.bono.colocacion.split('-')[0]) * 100)
          .toStringAsFixed(2),
      form: true,
    );
    txtForm _txtFormFlotacion = txtForm(
      title: '% Flotación',
      controller: _flotacionController,
      inputType: InputType.Number,
      placeholder: (double.parse(widget.bono.flotacion.split('-')[0]) * 100)
          .toStringAsFixed(2),
      form: true,
    );
    txtForm _txtFormCAVALI = txtForm(
      title: '% CAVALI',
      controller: _cavaliController,
      inputType: InputType.Number,
      placeholder: (double.parse(widget.bono.cavali.split('-')[0]) * 100)
          .toStringAsFixed(2),
      form: true,
    );
    return SizedBox(
      width: ScreenWH(context).width * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _txtFormPrima,
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormEstructuracion),
                dropdownMenu(
                    context,
                    'Sujeto',
                    sujetoGasto,
                    widget.bono.estructuracion.split('-')[1],
                    ScreenWH(context).width * 0.41,
                    "sujEst"),
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
                dropdownMenu(
                    context,
                    'Sujeto',
                    sujetoGasto,
                    widget.bono.colocacion.split('-')[1],
                    ScreenWH(context).width * 0.41,
                    "sujCol"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormFlotacion),
                dropdownMenu(
                    context,
                    'Sujeto',
                    sujetoGasto,
                    widget.bono.flotacion.split('-')[1],
                    ScreenWH(context).width * 0.41,
                    "sujFlo"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: ScreenWH(context).width * 0.41,
                    child: _txtFormCAVALI),
                dropdownMenu(
                    context,
                    'Sujeto',
                    sujetoGasto,
                    widget.bono.cavali.split('-')[1],
                    ScreenWH(context).width * 0.41,
                    "sujCav"),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Bono bono = Bono(
          id: widget.bono.id,
          user: widget.bono.user,
          nombre: _nombreController.text == ""
              ? widget.bono.nombre
              : _nombreController.text,
          metCalculo: selectedValues["Metodo"] ?? widget.bono.metCalculo,
          moneda: selectedValues["Moneda"] ?? widget.bono.moneda,
          cantidad: int.parse(_cantidadController.text == ""
              ? widget.bono.cantidad.toString()
              : _cantidadController.text),
          precMercado: double.parse(_precMercadoController.text == ""
              ? widget.bono.precMercado.toString()
              : _precMercadoController.text),
          valNominal: double.parse(_valNominalController.text == ""
              ? widget.bono.valNominal.toString()
              : _valNominalController.text),
          valComercial: double.parse(_valComercialController.text == ""
              ? widget.bono.valComercial.toString()
              : _valComercialController.text),
          NdeAnos: int.parse(_numAnosController.text == ""
              ? widget.bono.NdeAnos.toString()
              : _numAnosController.text),
          frecCupon: selectedValues["FrecCupon"] ?? widget.bono.frecCupon,
          diasXAno: selectedValues["diasxAno"] ?? widget.bono.diasXAno,
          tipTasaInteres:
              selectedValues["TipTasa"] ?? widget.bono.tipTasaInteres,
          capitalizacion:
              selectedValues["Capitalizacion"] ?? widget.bono.capitalizacion,
          tasaInteres: _tasaInteresController.text == ""
              ? widget.bono.tasaInteres
              : double.parse(_tasaInteresController.text) / 100,
          fecEmision: _fecEmisionController.text == ""
              ? widget.bono.fecEmision
              : _fecEmisionController.text,
          impuestoRenta: _impRentaController.text == ""
              ? widget.bono.impuestoRenta
              : double.parse(_impRentaController.text) / 100,
          tasaAnualDscto: _tasaAnualDsctoController.text == ""
              ? widget.bono.tasaAnualDscto
              : double.parse(_tasaAnualDsctoController.text) / 100,
          prima: _primaController.text == ""
              ? widget.bono.prima
              : double.parse(_primaController.text) / 100,
          estructuracion:
              "${_estructuracionController.text == '' ? widget.bono.colocacion.split('-')[0] : _estructuracionController.text}-${selectedValues["sujEst"] ?? widget.bono.colocacion.split('-')[1]}",
          colocacion:
              "${_colocacionController.text == '' ? widget.bono.colocacion.split('-')[0] : _colocacionController.text}-${selectedValues["sujCol"] ?? widget.bono.colocacion.split('-')[1]}",
          flotacion:
              "${_flotacionController.text == '' ? widget.bono.flotacion.split('-')[0] : _flotacionController.text}-${selectedValues["sujFlo"] ?? widget.bono.flotacion.split('-')[1]}",
          cavali:
              "${_cavaliController.text == '' ? widget.bono.cavali.split('-')[0] : _cavaliController.text}-${selectedValues["sujCav"] ?? widget.bono.cavali.split('-')[1]}",
        );
        bonoService()
            .updateBono(bono)
            .whenComplete(() => Navigator.pop(context));
      },
      style: ElevatedButton.styleFrom(
          primary: greenPrimary, padding: const EdgeInsets.all(10)),
      child: const Text(
        'Guardar',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget baseData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
              dropdownMenu(
                  context,
                  'Metodo de cálculo',
                  metodos,
                  widget.bono.metCalculo,
                  ScreenWH(context).width * 0.45,
                  "Metodo"),
              const SizedBox(height: 10),
              dropdownMenu(context, 'Moneda', moneda, widget.bono.moneda,
                  ScreenWH(context).width * 0.45, "Moneda"),
            ],
          ),
        ],
      ),
    );
  }

  Widget dropdownMenu(BuildContext context, String title, List<String> items,
      String placeholder, double menuWidth, String valName) {
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
