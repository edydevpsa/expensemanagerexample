

import 'package:flutter/material.dart';

// Map<String, IconData>types ={
//     'shopping' : Icons.shopping_cart,
//     'alcohol'  : Icons.local_drink,
//     'food'     : Icons.fastfood,
//     'bills'    : Icons.monetization_on_outlined,
//     'travel'   : Icons.directions_car,
//     'tickets'  : Icons.money_sharp,
//     'hotel'    : Icons.hotel,
//     'bussines' : Icons.business_center,
    
// };

final miicon = <String, Icon>{

   'shopping' : Icon(Icons.shopping_cart, color: Colors.orange,),
    'alcohol'  : Icon(Icons.local_drink, color: Colors.lightBlue,),
    'food'     : Icon(Icons.fastfood, color: Colors.amber,),
    'bills'    : Icon(Icons.monetization_on_outlined, color: Colors.blue ),
    'travel'   : Icon(Icons.directions_car, color: Colors.lightGreen,),
    'tickets'  : Icon(Icons.money_sharp, color: Colors.orange,),
    'hotel'    : Icon(Icons.hotel, color: Colors.amber,),
    'bussines' : Icon(Icons.business_center, color: Colors.lightBlue,),
    
  
};

// Icon getIconBlanck(String nombreiconos){
//   return Icon(miicon[nombreiconos]);
// }




final _icons = <String, IconData>{
  'shopping' : Icons.shopping_cart,
  'alcohol'  : Icons.local_drink,
  'foods'    : Icons.fastfood,
  'travel'   : Icons.local_airport,
  'hotel'    : Icons.hotel,
  'tickets'  : Icons.money_sharp,
  'clothing' : Icons.beach_access,
  'cinema'   : Icons.movie,
  'taxi'     : Icons.local_taxi,
  'party'    : Icons.nightlife,
  'beauty'   : Icons.content_cut_outlined,
  'gifts'    : Icons.card_giftcard,
  'fitness'  : Icons.self_improvement,
  'games'    :  Icons.sports_esports,
  'celebrations' : Icons.celebration,//sale de la lista
  'other'    : Icons.emoji_objects_outlined,
  'fuel station' : Icons.local_gas_station,//desde aqui para abajo viene desde la otra lista de la clase MoreCategory(),
  'car repair'   : Icons.car_repair,
  'transports'    : Icons.local_atm_outlined,
  'house repair' : Icons.house,
  'rental'       : Icons.home_work_outlined,
  'health care'  : Icons.local_hospital,
  'pet costs'    : Icons.pets_outlined,
  'light bill'   : Icons.power_rounded,
  'phone bill'   : Icons.phone_in_talk,
  'other costs' : Icons.post_add_outlined,
};
  Icon getIcon(String nombreIcono,){
    //var _colorrandom = Colors.primaries[Random().nextInt(10)];
    return Icon(_icons[nombreIcono],);
  }

