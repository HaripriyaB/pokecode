import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermlh/Course.dart';
import 'package:fluttermlh/CourseVideoList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Poke Code",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
        debugShowCheckedModeBanner: false,
      home: CoursePage()
    );
  }
}
class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('Course Catalog'))
      ),
      body: Center(child: CourseCardList(),
      ),
      backgroundColor: Colors.red,

    );
  }
}

class CourseCardList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ListCourseWidget();
  }
}
class ListCourseWidget extends State<CourseCardList> {

  final List<Course> courseList = [
    Course("Kotlin Basics",1,20.5,AssetImage('Images/kotlin.jpg')),
    Course("Java Tutorials",2,30.0,AssetImage('Images/java.jpg')),
    Course("Python",3,30.5,AssetImage('Images/python.jpg')),
    Course("C Programming",4,25.0,AssetImage('Images/cprog.jpg')),
    Course("C++ Basic",5,35.5,AssetImage('Images/cpp.jpg')),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: courseList.length,
          itemBuilder: (BuildContext context,int index) => buildCourseCard(context, index)
      ),
    );
  }

  Widget buildCourseCard(BuildContext context,int index){
    final course = courseList[index];
    return Container(
      child: Card(
        color: Colors.lime[100],
        elevation: 10,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
              children: <Widget>[
                  Text(
                      course.title,
                      textScaleFactor: 2,
                      style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                Spacer(),
                Text(
                  course.hours.toString()+" hours",
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold),
              ),
                Icon(Icons.timer)
              ]
                  ),
                ),
                Image(
                  image : course.courseImage,
                  fit: BoxFit.fill,
                ),

              ],
        ),
            ),
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => CourseVList(course:course)),
              );
            },
          ),
      ),
    );
  }
}

