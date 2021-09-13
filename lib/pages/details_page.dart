import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/provider.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class DetailsPage extends StatefulWidget {
  final DetailsParams detailsParams;
  final database = FirebaseFirestore.instance;
  //final String categoryName;
  //final Expenses expenses;
  DetailsPage({ Key key, @required this.detailsParams }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //Stream<QuerySnapshot> _query;
  @override
  void initState(){
    // final uid = Provider.of(context).auth.getCurrentUID();
    // _query = FirebaseFirestore.instance.collection('userData').doc(uid)
    // .collection('expenses')
    // .where('month', isEqualTo: widget.detailsParams.month + 1)
    // .where('category', isEqualTo: widget.detailsParams.categoryName)
    // .snapshots();

    super.initState();
  }

  Stream<QuerySnapshot> getUserStreamCategorySnapshot(BuildContext context)async*{
    final uid = await Provider.of(context).auth.getCurrentUID();
    //yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('trips').orderBy('startDate').snapshots();
    yield* FirebaseFirestore.instance
    .collection('userData')
    .doc(uid)
    .collection('expenses')
    .where('month', isEqualTo: widget.detailsParams.month+1)
    .where('category', isEqualTo: widget.detailsParams.categoryName)
    .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final double _borderRadius = 20.0;
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor:  Color(0xffdbe9f6), //Color(0xff4f3099), //Color(0xff2e305f),//, // ,//,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(widget.detailsParams.categoryName.toUpperCase(), style:  TextStyle( color: Color.fromRGBO(79, 57, 153, 1.0),)),
        //   ],
        // ),//Text(widget.detailsParams.categoryName),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.blueGrey,), 
            onPressed: (){
              Navigator.of(context).pop();
            }
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                //color: Colors.blueGrey,//(0xffdbe9f6),
                height: _height / 8,
                width: _width / 1.025,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.detailsParams.categoryName.toUpperCase(), style:  TextStyle(fontSize: 30.0, color: Color.fromRGBO(79, 57, 153, 1.0),)),
                    SizedBox(height: 5.0,),
                    Text('expenses incurred during the month', style: TextStyle(color: Color(0xff2e305f),fontSize: 16.0,)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            StreamBuilder(
              stream: getUserStreamCategorySnapshot(context),
              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot ){
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  return Expanded(
                    flex: 4,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: _height,
                        maxWidth: _width,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff2e305f),//Color(0xff6b5ad9),//Color(0xff4530b5),//Color(0xff2e305f),//Color(0xff4f3099),//Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index){
                            var document = snapshot.data.docs[index];
                            return Dismissible(
                              key: Key(document.id),
                              onDismissed: (direction)async { 
                                final uid = await Provider.of(context).auth.getCurrentUID();
                                widget.database
                                .collection('userData')
                                .doc(uid)
                                .collection('expenses')
                                .doc(document.id)
                                .delete();
                                // .where('month', isEqualTo: widget.detailsParams.month+1)
                                // .where('category', isEqualTo: widget.detailsParams.categoryName)
                                // .snapshots();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 90.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(_borderRadius),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.pink, 
                                            Colors.red,
                                            Colors.deepOrange
                                            //Color(0xff6b5ad9),
                                            //Color(0xff4f3099),
                                            //Color(0xff379ab9),
                                            //Color(0xff3ac2e7),//
                                            //Color(0xff379ab9),//
                                            //Color(0xffa798ff),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomLeft,
                                        ),
                                          
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: CustomPaint(
                                        size: Size(70, 90),
                                        painter: CustomCardShapePainter(_borderRadius,Colors.red, Colors.pinkAccent,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            children: [
                                              Text('day', style: TextStyle(color: Color(0xffdbe9f6), fontSize: 15.0), textAlign: TextAlign.center,),
                                              Text(" ${document['day']}".toString(), style: TextStyle(fontSize: 30.0), textAlign: TextAlign.center,),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text('expense',  style: TextStyle(color: Color(0xffdbe9f6), fontSize: 15.0), textAlign: TextAlign.center,),
                                              Text('\$${document['value'].toStringAsFixed(2)}',maxLines: 2, style: TextStyle(color: Color(0xff4f3099), fontSize: 30.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text('month',  style: TextStyle(color: Color(0xffdbe9f6), fontSize: 15.0), textAlign: TextAlign.center,),
                                              Text(document['month'].toString(), style: TextStyle(color: Color(0xff2e305f), fontSize: 30.0), textAlign: TextAlign.center,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ListTile(
                              //   tileColor: Colors.amber,
                              //   leading: Stack(
                              //     children: [
                              //       //Icon(Icons.calendar_today, size: 30.0,),
                              //       Text(document['day'].toString()),
                              //     ],
                              //   ),
                              //   title: Text('\$ ${document['value'].toStringAsFixed(2)}', textAlign: TextAlign.center,),
                              //   trailing: Text(document['month'].toString()),
                              // ),
                            );
                          }
                        
                        ),
                      ),
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsParams {
  final String categoryName;
  final int month;
  DetailsParams({@required this.categoryName, @required this.month});
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);
  

    @override
    void paint(Canvas canvas, Size size) {
      var radius = 24.0;
      var paint = Paint();
      paint.shader = ui.Gradient.linear(
        Offset(0, 0), 
        Offset(size.width, size.height), 
        [
          HSLColor.fromColor(startColor).withLightness(0.8).toColor(), 
          endColor,
        ]
      );

      var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

      canvas.drawPath(path, paint);
    }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    //throw UnimplementedError();
  }
  
}