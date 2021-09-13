import 'package:flutter/material.dart';

class MoreCategory extends StatefulWidget {
  final Function(String) onvalueChanged2;
  final Icon Function(String) getIcon;
  MoreCategory({ Key key, this.onvalueChanged2, this.getIcon }) : super(key: key);

  @override
  _MoreCategoryState createState() => _MoreCategoryState();
}

class _MoreCategoryState extends State<MoreCategory> {
  String currentItem2 = '';

  Map<String, IconData>types2 ={
    'fuel station' : Icons.local_gas_station,
    'car repair'   : Icons.car_repair,//sale de la lista
    'transports'    : Icons.local_atm_outlined,
    'house repair' : Icons.house,
    'rental'       : Icons.home_work_outlined,
    'health care'  : Icons.local_hospital,
    'pet costs'    : Icons.pets_outlined,
    'light bill'   : Icons.power_rounded,
    'phone bill'   : Icons.phone_in_talk,
    'other costs' : Icons.post_add_outlined,
    
  };
  @override
  Widget build(BuildContext context) {

    List<Widget> moreCategory = [];

    types2.forEach((key, value) { 
      moreCategory.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentItem2 = key;
            });
            widget.onvalueChanged2(key);
          },
          child: CategoryWidget2(
            name: key, 
            iconData: value, 
            selecccion: key == currentItem2,
          ),
        )
      );
    });
    return Container(
      //color: Colors.blueAccent, //color del container
      width: 300.0,
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: moreCategory,
      ),
    );
    // return Container(
    //   alignment: Alignment.center,
    //   //margin: EdgeInsets.only(right: 30.0),
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   child: GridView.count(
    //       shrinkWrap: true,
    //       crossAxisCount: 4,
    //       scrollDirection: Axis.horizontal,
    //       crossAxisSpacing: 10.0,
    //       mainAxisSpacing: 2.0,
    //       primary: false,
    //       children: moreCategory,
    //     ),
    // );
  }
}

class CategoryWidget2 extends StatelessWidget {

  final String name;
  final IconData iconData;
  final bool selecccion;
  CategoryWidget2({ Key key, this.name, this.iconData, this.selecccion }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Column(
        children: [
          Container(
           height: 50.0,
           width: 50.0,
           decoration: BoxDecoration(
            //color: Colors.amber,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
               color: selecccion ? Colors.pinkAccent : Colors.blueGrey,
               width: selecccion ? 3.0 : 1.0,
            ),
           ),
           child: Icon(iconData, color: Color.fromRGBO(219, 233, 246, 1.0),),
            ),
          SizedBox(height: 10.0,),
          Text(name, style: TextStyle( color: Colors.grey[300],),),
        ],
      ),
    );
  }
}