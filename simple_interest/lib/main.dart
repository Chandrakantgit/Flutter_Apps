import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        title: 'Simple Interest Calculator',
        home: SIFORM(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo,
          brightness: Brightness.dark,
          accentColor: Colors.indigoAccent,
        )),
  );
}

class SIFORM extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Formstate();
  }
}

class Formstate extends State<SIFORM> {
  var minimum = 5.0;
  List<String> _currencies = ["Rupees", "Dollar", "Pounds"];
  var _currentItemselected = 'Rupees';


  TextEditingController principalController=TextEditingController();
  TextEditingController interestController=TextEditingController();
  TextEditingController timeController=TextEditingController();

  String Displaytext= '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(title: Text("Simple Calculator")),
        body: Container(
            margin: EdgeInsets.all(minimum * 5),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                TextField(
                    style: textStyle,
                    controller: principalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        hintText: 'Enter Principal e.g. 2000',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
                Padding(
                    padding: EdgeInsets.only(top: minimum, bottom: minimum),
                    child: TextField(
                        style: textStyle,
                        controller: interestController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Interest',
                            hintText: 'Enter Interest rate e.g. 5',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))))),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                            style: textStyle,
                            controller: timeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Time',
                                hintText: 'Time in years',
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(5.0))))),
                    Container(width: minimum * 5),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemselected,
                      onChanged: (String newValueSelected) {
                        _onDropdownSelected(newValueSelected);
                      },
                    ))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: minimum, top: minimum),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          child: Text("Calculate"),
                          onPressed: () {
                            setState(() {
                             this.Displaytext= _calculateTotalReturns();
                            });

                          },
                        )),
                        Container(
                          width: minimum * 5,
                        ),
                        Expanded(
                            child: RaisedButton(
                          child: Text("Reset"),
                          onPressed: () {
                            _reset();
                          },
                        )),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(minimum * 2),
                    child: Text(this.Displaytext,
                      style: textStyle,

                    ))
              ],
            )));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('Images/money.png');
    Image image = Image(image: assetImage);

    return Container(child: image);
  }

  void _onDropdownSelected(String newValueSelected){
    setState(() {
      this._currentItemselected=newValueSelected;

    });
  }
  String _calculateTotalReturns(){

    double principal=double.parse(principalController.text);
    double rate = double.parse(interestController.text);
    double time=double.parse(timeController.text);

    double Totalamount =principal+ (principal*rate*time)/100;

     String Result ='After $time years, your investment will be $Totalamount $_currentItemselected';
     return Result;
  }

  void _reset(){

      principalController.text = '';
      interestController.text='';
      timeController.text='';
      Displaytext='';
      _currentItemselected=_currencies[0];


  }
}



