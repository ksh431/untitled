import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/input_field.dart';
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList=[
    5,
    10,
    15,
    20,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "일정 추가",
                  style: headingStyle,
                ),
                MyInputField(title: "일정", hint: "일정을 입력하세요"),
                MyInputField(title: "메모", hint: "메모를 입력하세요"),
                MyInputField(title: "날짜", hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: Icon(Icons.calendar_today_outlined,
                      color: Colors.grey
                      ),
                      onPressed: (){
                      _getDateFromUser();
                    },
                  )),
                Row(
                  children: [
                    Expanded(
                        child: MyInputField(
                          title: "시작 시간",
                          hint: _startTime,
                          widget: IconButton(
                            onPressed: (){
                              _getTimeFromUser(isStartTime:true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                      child: MyInputField(
                        title: "종료 시간",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime:false);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                MyInputField(title: "알람", hint: "$_selectedRemind 분 전",
                  widget: DropdownButton(
                    icon:Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey,),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitleStyle,
                    underline: Container(height: 0,),
                    onChanged: (String? newValue){
                      setState(() {
                        _selectedRemind=int.parse(newValue!);
                      });
                    },
                    items: remindList.map<DropdownMenuItem<String>>((int value){
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }
                    ).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap:(){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Get.isDarkMode?Colors.white:Colors.black
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/profile.png"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate:DateTime(2100)
    );

    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }else{
      print("오류임");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time canceld");
    }else if(isStartTime==true){
      setState(() {
        _startTime=_formatedTime;
      });
    }else if(isStartTime==false){
      setState(() {
        _endTime=_formatedTime;
      });
    }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0])
      )
    );
  }
}
