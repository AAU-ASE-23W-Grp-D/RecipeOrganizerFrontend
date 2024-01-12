import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import "package:recipe_organizer_frontend/colors.dart";

class RecipeDetailScreenWeb extends StatefulWidget {
  final String image = "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  final String name = "Cheeseburger";
  final String username = "Moser";
  final String userimage = "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  const RecipeDetailScreenWeb({Key? key}) : super(key: key);

  @override
  State<RecipeDetailScreenWeb> createState() => _DetailspageState();
}
class _DetailspageState extends State<RecipeDetailScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
        body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: MediaQuery.sizeOf(context).width*0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Row(
              children:[
                Container(
                  width: MediaQuery.sizeOf(context).width*0.8,
                    decoration: const BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),

                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                            Container(
                    constraints: BoxConstraints(maxHeight: 90.0),
                     child: Text(
                      widget.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        
                      ),
                      
                      ),
                     /*Padding(
                       padding: EdgeInsets.all(8.0),
                       child: SearchBarApp(),
                     ),*/
                   ),
                            Container(
                              height:60,
                              
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                 border: Border.all(color:labelColor,width: 0.1 )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Row(
                                      children: [
                                         CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(widget.userimage),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Text(widget.username,style: const TextStyle(fontSize: 14,color: textColor),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top:8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star,color: primary,size: 15,),
                                              Icon(Icons.star,color: primary,size: 15,),
                                              Icon(Icons.star,color: primary,size: 15,)
                                              ,
                                              Icon(Icons.star,color: primary,size: 15,),
                                              Icon(Icons.star,color: primary,size: 15,)
                                              
                                            ],
                                          ),
                                          Text("169 upvoted",style: TextStyle(fontSize: 12,color: labelColor),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),


                    ),
                  ),
              ] 
            ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text("Ingredients",style: TextStyle(fontSize: 16),),
                                ),
                      Padding(
                                  padding: EdgeInsets.only(top:20.0),
                                  child: DottedBorder(
                                    borderType: BorderType.Rect,
                                    strokeWidth: 0.8,
                                    dashPattern: const [1,],
                                    color: inActiveColor,
                                    child: SizedBox(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    child:const Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.trip_origin, color: primary, size: 20,),
                                                  SizedBox(width: 4,),
                                                  Text("Egg:",style: TextStyle(color: inActiveColor),),
                                                  Text("2")
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.trip_origin, color: primary, size: 20,),
                                                  SizedBox(width: 4,),
                                                  Text("Milk:",style: TextStyle(color: inActiveColor),),
                                                  Text("15ml")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.trip_origin, color: primary, size: 20,),
                                                  SizedBox(width: 4,),
                                                  Text("Sugar:",style: TextStyle(color: inActiveColor),),
                                                  Text("10mg")
                                                ],
                                              ),
                                              Row(
                                                children:  [
                                                  Icon(Icons.trip_origin, color: primary, size: 20,),
                                                  SizedBox(width: 4,),
                                                  Text("cheese:",style: TextStyle(color: inActiveColor),),
                                                  Text("5g")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ),
                                ),
                    ]
                     
            
            
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children:[
                    const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text("Description",style: TextStyle(fontSize: 16))),
                                  const Text("Lorem, ipsum dolor sit amet consectetur adipisicing elit. Incidunt, nihil nobis! Fuga, ipsa cupiditate.",style: TextStyle(color: inActiveColor),),
                                const SizedBox(height: 40,)]
            
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            widget.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                                
                    ),
                  ),
                ),
            
            
            
              ]
              ),
          ],
        )
        )

                  
    );
  }
}

