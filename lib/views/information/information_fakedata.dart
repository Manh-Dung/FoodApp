import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';


class ListDataInfor extends StatefulWidget {

  final String? date;
  final String? title;
  final String? para;
 // final Image img;
  const ListDataInfor({
      Key? key,
      this.date,
      this.title,
      this.para
  }):super(key:key);

  @override
  State<ListDataInfor> createState() => _ListDataInforState();
}

class _ListDataInforState extends State<ListDataInfor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
      child: Card(
        elevation: 0,
       color: Colors.white54,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.date??"",style: TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 12),),
            Text(widget.title??"",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
            Text(widget.para??"",style: TextStyle(color: Colors.grey,fontSize: 13),),
            SizedBox(height: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
                child: Image.network('https://images2.thanhnien.vn/528068263637045248/2023/6/5/3-trai-bo-shutterstock-16859825578401958356252.jpg'))
          ],
        ),
      ),
    );
  }
}

