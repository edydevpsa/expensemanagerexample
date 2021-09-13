import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/graph_widget.dart';
import 'package:expensemanager/pages/details_page.dart';
import 'package:expensemanager/pages/icon_list.dart';
import 'package:flutter/material.dart';
//import 'package:icons_helper/icons_helper.dart';

enum GraphTypes{lines, pie, charts}

class MonthWidget extends StatefulWidget {
  final List<DocumentSnapshot>documents;
  final double total;
  final List<double>perDay;
  final Map<String, double>categories;
  final int days;
  final GraphTypes graphTypes;
  final int moth;
  //final CategorySelectorWidget categorySelectorWidget;
  //Map<String, IconData> iconosKey; //ojo con el IconData Firebase no recibe un tipo Icon sino String 
  MonthWidget({Key key, @required this.documents, this.days, this.graphTypes, @required this.moth,}) :

  total = documents.map((doc) => doc['value']).fold(0.0, (a, b) => a + b),
  perDay = List.generate(days, (index){
    return documents.where((element) => element['day'] == (index + 1))
    .map((doc) => doc['value']).fold(0.0, (a, b) => a + b);
  }),

  categories = documents.fold({}, (Map<String, double>map, doc){
    if (!map.containsKey('category')) {
      map[doc['category']] = 0.0;
    }
    map[doc['category']] += doc['value'];

    return map;
  });
  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  
  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Column(
         children: [
          _expenses(),
          //_letras('( \$ )', MainAxisAlignment.start),
          _graph(),
          //_letras('days', MainAxisAlignment.end),
          Container(color: Colors.blueGrey.withOpacity(0.15), height: 18.0,),
          _list(),
          //cards(),
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: [
        Text('\$${widget.total.toStringAsFixed(2)}', style: TextStyle(color: Color.fromRGBO(79, 57, 153, 1.0), fontSize: 30.0, fontWeight: FontWeight.bold),),
        Text('Total expenses', style: TextStyle(color: Color.fromRGBO(110, 93, 221, 1.0), fontSize: 15.0, fontWeight: FontWeight.bold),),
      ],
    );
  }
  
  Widget _graph() {
    if (widget.graphTypes == GraphTypes.lines) {
      return Container(
        height: 250,
        child: LinesGraphWidget(data: widget.perDay,),
      );
    }else if(widget.graphTypes == GraphTypes.pie){
      var perCategory = widget.categories.keys.map((e) => widget.categories[e] / widget.total).toList();
      return Container(
        height: 250,
        child: PieGraphWidget(data: perCategory),//data: widget.perDay,
      );
    }else{
      return Container(
        height: 250,
        child: BarGraphWidget(data: widget.perDay,),
      );
    }
  }
  
  //Los Widgets _item() y _list() construyen la lista desplegable del UI
  Widget _item(  dynamic iconData, String nombre, int percent, double value,){
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/detailsPage', arguments: DetailsParams(categoryName: nombre, month: widget.moth));
      },
      leading: getIcon(iconData), //widget.categorySelectorWidget.getIcon(iconData),
      title: Text(nombre, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      subtitle: Text('$percent% of expenses', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('\$ $value', style: TextStyle(color: Colors.blueAccent,fontSize: 18.0, fontWeight: FontWeight.w500)),
        )
      ),
    );
  }
  Widget _list() {
    //widget.categorySelectorWidget.getIcon();
    return Expanded(
      child: ListView.separated(
        itemCount: widget.categories.keys.length,
        itemBuilder: (context, index,) {
          var key = widget.categories.keys.elementAt(index);
          var data = widget.categories[key];
          var icons = widget.documents[index]['icono'];
          //var miicon = widget.categorySelectorWidget.getIcon(icons);
          
          return _item(icons, key, 100 * data ~/ widget.total, data);
        },
        separatorBuilder: (context, index) {
          return Container(
            //color: Colors.blueGrey.withOpacity(0.15),
            color: Colors.blueGrey[700].withOpacity(0.15),
            height: 9.0,
          );
        },
      ),
    );
  }
  //Letras de Dias y Gastos Promedios....
  Widget _letras(String texto, MainAxisAlignment _mainAxisAlignment){
    if (widget.graphTypes == GraphTypes.lines) {
      return Container(
        child: Row(
          mainAxisAlignment: _mainAxisAlignment,
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 5.0, right: 20.0,bottom: 8.0),
              child: Text(texto, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      );
    }else if (widget.graphTypes == GraphTypes.charts) {
      return Container(
        child: Row(
          mainAxisAlignment: _mainAxisAlignment,
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 5.0, right: 20.0,bottom: 8.0),
              child: Text(texto, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      );
    }else{
      return Container();
    }
    
  }
  //ejemplo de Iman StarUp
  // Widget cards(){
  //   return Expanded(
  //         child: ListView.builder(
  //       itemCount: tripList.length,
  //       itemBuilder: (context, index) => buildtripCard(context, index),
          
  //     ),
  //   );
  // }
  // Widget buildtripCard(BuildContext context, int index){
  //   final trip = tripList[index];
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
  //             child: Row(
  //               children: [
  //                 Text(trip.category,style:  TextStyle(fontSize: 30.0),),
  //                 Spacer(),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
  //             child: Row(
  //               children: [
  //                 Text(trip.day.toString()),
  //                 Text(trip.month.toString()),
  //                 Spacer(),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
  //             child: Row(
  //               children: [
  //                 Text(trip.value.toString(), style: TextStyle(fontSize: 25.0),),
  //                 //Text(trip.expensesType),
  //                 Icon(Icons.directions_car),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}