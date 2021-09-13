import 'dart:math';
//import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class CategorySelectorWidget extends StatefulWidget {
  //final Map<String, IconData>categoryIcon;
  //final Map<String, Icon>categoryIcon;
  //final Function(IconData) icono;
  //final Function(Icon) icono;
  //final Expenses expenses;
  final Function (String) onvalueChanged;
  final Icon Function(String)getIcon;
  final Widget categoriess;
  CategorySelectorWidget({Key key, this.onvalueChanged, this.getIcon, this.categoriess }) : super(key: key);

  @override
  _CategorySelectorWidgetState createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {

  String currentItem = ''; //encargado de seleccionar los items el icon
  Map<String, IconData>types ={
    'shopping' : Icons.shopping_cart,
    'alcohol'  : Icons.local_drink,
    'foods'     : Icons.fastfood,
    'travel'   : Icons.local_airport,
    'hotel'    : Icons.hotel,
    'tickets'  : Icons.money_sharp,
    'clothing' : Icons.beach_access,
    'cinema'   : Icons.movie,
    'taxi'     : Icons.local_taxi,
    'party'    : Icons.nightlife,
    'beauty'   : Icons.content_cut_outlined,
    'fitness'  : Icons.self_improvement,
    'gifts'    : Icons.card_giftcard,
    'games'    :  Icons.sports_esports,
    'celebrations' : Icons.celebration,//sale de la lista
    'other'    : Icons.emoji_objects_outlined,
    
  };
  // getIcon(String nombreIcono){
  //   return Icon(types[nombreIcono]);
  // }

  final ScrollController _controller = ScrollController();
  bool _final = false;
  List<Widget> moreCategory = [];
  _listener(){
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;

    if (_controller.offset >= maxScroll) {
      print('ya estas en el final');
      setState(() {
        _final = true;
      });
    }

    if (_controller.offset <= minScroll) {
      setState(() {
        _final = false;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
  
    types.forEach((key, value) { 
      widgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentItem = key;
            });
            widget.onvalueChanged(key);
            //widget.icono(value); //esto es prueba con "value q es iconData"
            //widget.getIcon(key);
            //getIcon(key);
          },
          child: CategoryWidget(
            name: key,
            iconData: value,
            selected: key == currentItem,
          ),
        )
      );
    });
    return Row(
      children: [
        Container(
          child: Expanded(
              child: ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: widgets.length,
                itemBuilder: (BuildContext context, int index){
                return widgets[index];
              }
            ),
          ),
        ),
        //_iconButton(),
        //_expansion(),
        //widget.categoriess,
      ],
    );
    // return ListView(
    //   scrollDirection: Axis.horizontal,
    //   children: widgets,
    // );
  }


  void agregaricon(){
    for (var item in moreCategory) {
      moreCategory.add(item);
    }
  }
}
// Widget _alerDialog (BuildContext context){
//   return AlertDialog(
//     scrollable: true,
//     title: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text('More categories', style: TextStyle(color: Colors.blueGrey), textAlign: TextAlign.center,),
//         IconButton(
//           icon: Icon(Icons.close), 
//           onPressed: (){
//             Navigator.of(context).pop();
//           }
//         ),
//       ],
//     ),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         MoreCategory(),
//       ],
//     ), //recive un Widget,
//     actions: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           //SizedBox(width: 40.0),
//           FlatButton(
//             onPressed: (){
//               Navigator.of(context).pop();
//             }, 
//             child: Text('Ok')
//           ),
//         ],
//       ),
//     ],
//   );
// }


//classe para añadir Icono
class CategoryWidget extends StatelessWidget {
  final String name;
  final IconData iconData;
  final bool selected;
  CategoryWidget({Key key, this.name, this.iconData, this.selected,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _selectedColorRandomIcon = Colors.primaries[Random().nextInt(3)];
    var _unselestedColorRandomIcon = Colors.blueGrey;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: selected? _selectedColorRandomIcon : _unselestedColorRandomIcon,
                width: selected? 3.0 : 1.0,
              ),
            ),
            child: Icon(iconData, color: Color.fromRGBO(247, 216, 121, 1.0),),
          ),
          SizedBox(height: 10.0),
          Text(name, style: TextStyle( color: Colors.grey[300],),),
        ],
      ),
    );
  }
}