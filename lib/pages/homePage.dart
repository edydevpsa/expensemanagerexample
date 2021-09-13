import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/month_widget.dart';
import 'package:expensemanager/pages/utils.dart';
import 'package:expensemanager/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _currentPage = DateTime.now().month - 1;
  //Stream<QuerySnapshot> _query;
  GraphTypes graphTypes = GraphTypes.lines;
  @override
  void initState() {

    // _query = FirebaseFirestore.instance
    // .collection('expenses')
    // .where('month', isEqualTo: _currentPage + 1)
    // .snapshots();

    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.4,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(79, 57, 153, 1.0),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottonAction(Icons.show_chart, (){
              setState(() {
                graphTypes = GraphTypes.lines;
              });
            }),
            _bottonAction(Icons.pie_chart, (){
              setState(() {
                graphTypes = GraphTypes.pie;
              });
            }),
            SizedBox(width: 48.0,),
            _bottonAction(Icons.bar_chart, (){
              setState(() {
                graphTypes = GraphTypes.charts;
              });
            } ),
            _bottonAction(Icons.settings, (){
              Navigator.pushReplacementNamed(context, '/settings');
            }),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: 'animated materialButton',
        backgroundColor: Color.fromRGBO(138, 120, 231, 1.0),
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed('/add');
        }
      ),
      body: _body(context),
    );
  }

  Widget _bottonAction(IconData icon, Function callback){
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Icon(icon, color: Colors.blueGrey[500]),
      ),
      onTap: callback, //en onTap Pasamos la Function callback 
    );
  }
  
  Stream<QuerySnapshot>getUserStreamSnapshot(BuildContext context)async*{
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('expenses').where("month", isEqualTo: _currentPage + 1).snapshots();
    
  }

  Widget _body(BuildContext context){
    //se agrego un container debajo del SafeArea si da error lo podemos eliminar
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //Color(0xff6b5ada),
              ////Color(0xff6b5ad9),
              //Color(0xff4f3099),
              ////Color(0xff4530b5),
              Color(0xffe8f0f9),
              Color(0xffdbe9f6),
              
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
            children: [
              _selector(),
              StreamBuilder(
        stream: getUserStreamSnapshot(context), //_query
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading....')
            );
          }else{
            return  MonthWidget(
              documents:snapshot.data.docs,
              days: daysInMonth(_currentPage + 1),
              graphTypes: graphTypes,
              moth: _currentPage,
            );
          }
        }
              ),
              
            ],
          ),
      ),
    );
  }
  Widget _pageItem(String nombre, int position){
    var _aligment;
    final selected = TextStyle(color: Colors.blueAccent, fontSize: 20.0, fontWeight: FontWeight.bold);
    final unSelected = TextStyle(color: Colors.blueGrey. withOpacity(0.5), fontSize: 20.0, fontWeight: FontWeight.normal);
    if (position == _currentPage) {
      _aligment = Alignment.center;
    }else if(position > _currentPage){
      _aligment = Alignment.centerRight;
    }else{
      _aligment = Alignment.centerLeft;
    }
    return Align(
      alignment: _aligment,
      child: Text(nombre, style: (position == _currentPage)? selected : unSelected,),
    );
  }
  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        controller: _pageController,
        onPageChanged: (newPage) {
          setState(() {
            _currentPage = newPage;
            //  _query = FirebaseFirestore.instance
            //     .collection('expenses')
            //     .where("month", isEqualTo: _currentPage + 1)
            //     .snapshots();
            // //_query = getUserStreamSnapshot(context);
          });
        },
        children: [
          _pageItem('January', 0),
          _pageItem('February', 1),
          _pageItem('March', 2),
          _pageItem('April', 3),
          _pageItem('May', 4),
          _pageItem('June', 5),
          _pageItem('Julio', 6),
          _pageItem('August', 7),
          _pageItem('September', 8),
          _pageItem('October', 9),
          _pageItem('November', 10),
          _pageItem('December', 11),
        ],
      ),
    );
  }

}