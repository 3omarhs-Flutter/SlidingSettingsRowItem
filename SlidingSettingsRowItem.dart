import 'package:flutter/material.dart';
import 'package:sirocomena_app/UI/Images.dart';
import 'package:sirocomena_app/UI/Widgets.dart';



SettingsItem({required int movingIndex, required int index, required double movingValue, required item, onTap, required List<Widget> children}){
  return Padding(
    padding: EdgeInsets.all(SettingsBetweenItemsPadding),
    child: Stack(
      children: [
        AnimatedSlide(
          duration: Duration(milliseconds: 300),
          offset: Offset(movingIndex==index? 1+movingValue : 1/*-0.7*/, 0),
          child: InkWell(
            // onTap: ()=> setState((){ movingIndex = index; movingValue = movingValue==0? -0.7 : 0;}),
            child: Padding(
              padding: EdgeInsets.only(left: movingIndex==index&&movingValue!=0? 65: 95),
              child: Container(
                padding: SettingsInItemPadding(getData('locale')=='ar'),
                color: MainColorLite,
                height: 65,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: children,
                ),
              ),
            ),
          ),
        ),
        AnimatedSlide(
          duration: Duration(milliseconds: 300),
          offset: Offset(movingIndex==index? movingValue : 0/*-0.7*/, 0),
          child: InkWell(
            onTap: onTap,//()=> setState((){ movingIndex = index; movingValue = movingValue==0? -0.7 : 0;}),
            child: Container(
              padding: SettingsInItemPadding(getData('locale')=='ar'),
              color: TextOverDark,
              height: 65,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(/*items[index]*/item['icon'], color: MainColor),
                      SettingsSpaceBetweenIconAndText,
                      Text(item['label'])
                    ],
                  ),
                  SettingsChevron(reverced: movingIndex==index&&movingValue!=0)
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int movingIndex = -1;
  double movingValue = 0;
  List items = [
    {
      'label': 'Change App Language',
      'icon': Icons.language,
      'children': [
        IconButton(onPressed: (){}, icon: SettingsArabicLanguage),
        IconButton(onPressed: (){}, icon: SettingsEnglishLanguage),
      ]
    },
    {
      'label': 'MAin App Color',
      'icon': Icons.account_circle_outlined,
      'children': [
        IconButton(onPressed: (){}, icon: CircleAvatar(backgroundColor: Colors.blue,)),
        IconButton(onPressed: (){}, icon: CircleAvatar(backgroundColor: Colors.black,)),
        IconButton(onPressed: (){}, icon: CircleAvatar(backgroundColor: Colors.deepPurple,)),
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'App Settings'),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return SettingsItem(movingIndex: movingIndex, index: index, movingValue: movingValue, item: items[index], onTap: ()=> setState((){ movingIndex = index; movingValue = movingValue==0? -0.5 : 0;}), children: items[index]['children']);
        },
      )
    );
  }
}
