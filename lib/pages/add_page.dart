import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/categorySelectorWidget.dart';
import 'package:expensemanager/more_icons.dart';
import 'package:expensemanager/provider.dart';
import 'package:flutter/material.dart';


class AddPage extends StatefulWidget {
  //final Expenses expenses;
  AddPage({Key key,}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final database = FirebaseFirestore.instance; //Podemos mover arriba al staful si es necesario
  String category;
  String newCategory;
  String newCategory2;
  int value = 0;
  final scafKey = GlobalKey<ScaffoldState>(); //una forma de mostrar Snackabr con globalKey

  // Map<String, IconData>types() =>{
  //   'shopping' : Icons.shopping_cart,
  //   'alcohol'  : Icons.local_drink,
  //   'food'     : Icons.fastfood,
  //   'bills'    : Icons.monetization_on_outlined,
  //   'travel'   : Icons.directions_car,
  //   'tickets'  : Icons.money_sharp,
  //   'hotel'    : Icons.hotel,
  //   'bussines' : Icons.business_center,
    
  // };

  // Icon getIcon(String nombreIcono){
  //   return Icon(types()[nombreIcono]);
  // }

  var isOpen = false;
  //las varialbes dateStr y date es para selector fecha q incorporaremos
  //String dateStr = 'Today';
  //DateTime date = DateTime.now();


  _toggleOpen (){
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafKey, // key del snackbar
      backgroundColor: Color(0xff2e305f),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: [
            Text('Category', style: TextStyle(color:  Color(0xffdbe9f6)),),
            SizedBox(width: 10.0),
            // GestureDetector(
            //   child: Text(dateStr, style: TextStyle(color:  Color(0xffdbe9f6)) ),
            //   onTap: () {
            //     showDatePicker(
            //       context: context, 
            //       initialDate: DateTime.now(), 
            //       firstDate: DateTime.now().subtract(Duration(hours: 24 * 30)), 
            //       lastDate: DateTime.now(),
            //     ).then((value){
            //       if (value != null) {
            //         setState(() {
            //           date = value;
            //           dateStr = "${date.year.toString()}/${date.month.toString().padLeft(2,'0')}/${date.day.toString().padLeft(2, '0')}";
            //         });
            //       }else{
            //        setState(() {
            //           dateStr = 'Today';
            //        });
            //       }
            //       print(value);
            //     });
            //   },
            // ),//aqui ponemos el selector fecha siquires borramos si da error
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white54,), 
            onPressed: (){
              Navigator.of(context).pop();
            }
          ),
        ],
      ),
      body: _body()
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(top:5.0),
      child: Column(
        children: [
          SizedBox(height: 2.0),
          Text('select one category only', style: TextStyle(color: Colors.white54),),
          SizedBox(height: 10.0),
          _categorySelector(),
          //_alerDialog(context),
          SizedBox(height: 10.0),
          _customButtomAnimation(),
          SizedBox(height: 10.0),
          _currentValue(),
          _numPad(),
          _summit(),
        ],
      ),
    );
  }
  
  Widget _categorySelector() {
    return Container(
      height: 80.0,
      width: double.infinity,
      child: CategorySelectorWidget( // AQUI PASAMOS EL ICONO COMO KEY
        // {
        //   'shopping' : Icons.shopping_cart,
        //   'alcohol'  : Icons.local_drink,
        //   'food'     : Icons.fastfood,
        //   'bills'    : Icons.monetization_on_outlined,
        //   'travel'   : Icons.directions_car,
        //   'tickets'  : Icons.money_sharp,
        //   'hotel'    : Icons.hotel,
        //   'bussines' : Icons.business_center,
        //   'holidays' : Icons.bedtime_sharp,
        // },
        onvalueChanged: (newCategory) => category = newCategory,
        //icono: (iconos) => iconDataParamentro = iconos, //Codigo de Prueba de los Icons
        // getIcon: (nombreicono) {
        //   return Icon(types()[nombreicono]);
        // },
        //categoriess: _customButtomAnimation(),
          
      ),
    );
  }
  
  
  Widget _customButtomAnimation(){
    return Container(
      child: Center(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
              width: isOpen? MediaQuery.of(context).size.width : 40,
              height: 50.0,//50,
              decoration: ShapeDecoration(
                color: Color(0xff2e305f),//Color.fromRGBO(71, 54, 181, 1.0),//Colors.grey[50],//Colors.orange[100],
                shape: StadiumBorder(),
              ),
            ),
            Container(
              width: 40.0,
              margin: EdgeInsets.only(left: 2.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: AnimatedCrossFade(
                duration: Duration(milliseconds: 800),
                firstChild: IconButton(
                  icon: Icon(Icons.control_point, color: Colors.white,),
                  onPressed: (){
                    _toggleOpen();
                  }
                ),
                secondChild: IconButton(
                  icon: Icon(Icons.clear, color: Colors.white,), 
                  onPressed: (){
                    _toggleOpen();
                  }
                ),
                crossFadeState: !isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 1000),
              opacity: isOpen ? 1 : 0,
              child: Container(
                padding: EdgeInsets.only(left: 40.0),
                width: double.infinity, //valor original 240//Aqui els donde delimitaba el tamaño de la listView y container de la clase MoreCategory
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: MoreCategory(
                          onvalueChanged2: (newCategory2) => category = newCategory2,
                        ),
                        fit: FlexFit.tight,
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.handyman_sharp),
                      //   onPressed: () {
                          
                      //   },
                      // ),
                      // Icon(Icons.hearing_outlined),
                      // Icon(Icons.clean_hands_sharp),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _currentValue() {
    var realValue = value / 100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text('\$${realValue.toStringAsFixed(2)}',
        maxLines: 5,
        style: TextStyle(color: Colors.pinkAccent, fontSize: 50.0, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _numPad() {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints){
          double _height = boxConstraints.biggest.height / 4;
          return Table(
            border: TableBorder.all(
              color: Colors.white24,
              width: 0.3,
            ),
            children: [
              TableRow(
                children: [
                  styleNumCell( '1', _height),
                  styleNumCell( '2', _height),
                  styleNumCell( '3', _height),
                ],
              ),
              TableRow(
                children: [
                  styleNumCell( '4', _height),
                  styleNumCell( '5', _height),
                  styleNumCell( '6', _height),
                ],
              ),
              TableRow(
                children: [
                  styleNumCell( '7', _height),
                  styleNumCell( '8', _height),
                  styleNumCell( '9', _height),
                ],
              ),
              TableRow(
                children: [
                  styleNumCell( '.', _height),
                  //Container(child: Text('.', style: TextStyle(color: Colors.grey, fontSize: 50.0),),),
                  styleNumCell( '0', _height),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        value = value ~/ 10; // + (value - value.toInt());
                      });
                    },
                    child: Container(
                      height: _height,
                      child: Center(
                        child: Icon(Icons.backspace, color: Colors.grey, size: 30.0,)
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  Widget styleNumCell(String text, double heights){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if (text == '.') {
            value = value * 100;
          }else{
            value = value * 10 + int.parse(text);
          }
        });
      },
      child: Container( 
        height: heights,
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.grey, fontSize: 40.0, fontWeight: FontWeight.w200),)
        ),
      ),
    );
  }

  Widget _summit () {
    return Hero(
      tag: 'animated materialButton',
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfff34589),
              Color(0xf0f08547),
              
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.centerLeft,
          ),
        ),
        child: MaterialButton(
          child: Text('Add expenses', style: TextStyle(color: Colors.white, fontSize: 20.0),),
          onPressed: _showSnackBar,
        ),
      ),
    );
  }

  void _showSnackBar()async{
    final uid = await Provider.of(context).auth.getCurrentUID();
    // final uid = await Provider.of(context).auth.getCurrentUId();
    //await db.collection('userData').doc(uid).collection('trips').add(trip.toJson());
    //   if (value > 0 && category != '') {
    //     // final icon = tripKeys[index];
    //     database
    //     .collection('userData')
    //     .doc(uid)
    //     .collection('expenses')
    //     .doc()
    //     .set({
    //       'category' : category,
    //       'month' : DateTime.now().month,
    //       'day'  : DateTime.now().day,
    //       'value' : value / 100.0,
    //       //'icono': iconDataParamentro.toString(),
    //       'icono': category,
    //       //'icono' : icon
    //     });
        
    //     Navigator.of(context).pop();
    //   }else if(value > 0 && category == null){
    //     //showAboutDialog(context: context);
    //     SnackBar snackBar = SnackBar(
    //       content:Text('Selecciona una Categoria'),
    //       // action: SnackBarAction(label: 'Cancelar', 
    //       // onPressed: (){
    //       //   // if (value == 0 && category == '') {
              
    //       //   // }
    //       //   print('cancelado');
    //       // }
    //       // ),
    //     );
    //     scafKey.currentState.showSnackBar(snackBar);
    //     //Navigator.of(context).pop();
    //   }else if(value >= 0 && category == ''){
    //     SnackBar snackBar = SnackBar(
    //       content:Text('data diferente de null'),
    //       // action: SnackBarAction(label: 'Cancelar', 
    //       // onPressed: (){
    //       //   // if (value == 0 && category == '') {
            
    //       //   // }
    //       //   print('cancelado');
    //       // }
    //       // ),
    //     );
    //     scafKey.currentState.showSnackBar(snackBar);

    //   }else{
    //     SnackBar snackBar = SnackBar(
    //       content:Text('Secciona un Valor'),
    //       action: SnackBarAction(label: 'Cancelar', 
    //       onPressed: (){
    //         // if (value == 0 && category == '') {
            
    //         // }
    //         print('cancelado');
    //       }
    //       ),
    //     );
    //     scafKey.currentState.showSnackBar(snackBar);
    //   }
    
    // }
    if (value > 0 && category == null) {
     SnackBar snackBar = SnackBar(
        content:Text('Selected an Category'),
         // action: SnackBarAction(label: 'Cancelar', 
          // onPressed: (){
          //   // if (value == 0 && category == '') {
            
          //   // }
          //   print('cancelado');
          // }
          // ),
      );
      scafKey.currentState.showSnackBar(snackBar); 
      // Navigator.of(context).pop();
    }else if(value == 0 && category == null){
      SnackBar snackBar = SnackBar(
        content:Text('Select a category and an expense value'),
        action: SnackBarAction(label: 'Cancel', 
          onPressed: (){
             // if (value == 0 && category == '') {
            
             // }
            print('Cancelado');
          }
        ),
      );
       scafKey.currentState.showSnackBar(snackBar);
    }else if(value == 0 && category != ''){

      SnackBar snackBar = SnackBar(
        content:Text('Select an expense amount'),
        action: SnackBarAction(label: 'Ok', 
          onPressed: (){
             // if (value == 0 && category == '') {
            
             // }
            print('Ok');
          }
        ),
      );
       scafKey.currentState.showSnackBar(snackBar);
      //AQUI ABAJO COMIENZA EL CODIGO DE Category2 ---> PROBANDO
    }else{
      //final uid = await Provider.of(context).auth.getCurrentUId();
      database
      .collection('userData')
      .doc(uid)
      .collection('expenses')
      .doc()
      .set({
        'category' : category,
        'month' : DateTime.now().month,
        'day'  : DateTime.now().day,
        'value' : value / 100.0,
        //'icono': iconDataParamentro.toString(),
        'icono': category,
        //'icono' : icon
      });
        
      Navigator.of(context).pop();  
      
    }
  }

}