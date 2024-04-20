import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../x_res/x_r.dart';
import 'information_fakedata.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin tức',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back,color: Colors.grey,)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
          children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          color: Colors.grey.shade200,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
                fillColor: Colors.white,
                enabledBorder:
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
                hintText: "Tìm kiếm",
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
          ),
        ),
        Image.asset(XR().assetsImage.img_logo,width: 200,height: 200,),
        ListDataInfor(date:'31/10/2023',title:'OCOP giúp Đăk Lawawk xây dựng nông thôn mới bền vững ',
        para: 'Sau 2 năm triển khai Chương trình OCOP đã giúp Đăk Lawk hình thành vùng sản xuất nông sản sạch,...',),
        ListDataInfor(date:'31/10/2023',title:'OCOP giúp Đăk Lawawk xây dựng nông thôn mới bền vững ',
              para: 'Sau 2 năm triển khai Chương trình OCOP đã giúp Đăk Lawk hình thành vùng sản xuất nông sản sạch,...',),
        ListDataInfor(date:'31/10/2023',title:'OCOP giúp Đăk Lawawk xây dựng nông thôn mới bền vững ',
              para: 'Sau 2 năm triển khai Chương trình OCOP đã giúp Đăk Lawk hình thành vùng sản xuất nông sản sạch,...',)
      ]),
    );
  }
}
