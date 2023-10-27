import 'package:flutter/material.dart';
import 'package:todo/Constants/Colors.dart';
import 'package:todo/Widgets/ToDo_Item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: AppBar(
        backgroundColor: tdBgColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('Assets/mo.jpg'),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Column(
            children: [
             searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50,bottom: 20),
                      child: const Text('All ToDos',style: TextStyle(
                        fontSize:30 ,fontWeight: FontWeight.w500,
                      ),),
                    ),
                    ToDoItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget searchBox()=> Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)),
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints:
            BoxConstraints(maxHeight: 20, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)),
      ),
    ),
  );
