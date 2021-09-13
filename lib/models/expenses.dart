
class Expenses {
  String category;
  int day = 23;
  int month = 9;
  double value = 20.0;
  String expensesType = 'icono';
  
  Expenses(this.category, this.day, this.month, this.value,);



  Map<String, dynamic>toJson() =>{
    'category'    : category,
    'day'         : day,
    'month'       : month,
    'value'       : value,
    'expensesType': expensesType,
  };

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
  // Map<String, IconData>categoryIcon={
  //       'shopping' : Icons.shopping_cart,
  //     'alcohol'  : Icons.local_drink,
  //     'food'     : Icons.fastfood,
  //     'bills'    : Icons.monetization_on_outlined,
  //     'travel'   : Icons.directions_car,
  //     'tickets'  : Icons.money_sharp,
  //     'hotel'    : Icons.hotel,
  //     'bussines' : Icons.business_center,
  // };
  // Expenses.fromSnapshot(DocumentSnapshot snapshot):
  //   category = snapshot.data()['category'],
  //   day = snapshot.data()['day'],
  //   month = snapshot.data()['month'],
  //   value = snapshot.data()['value'],
  //   icono = snapshot.data()['icono'];
  
}