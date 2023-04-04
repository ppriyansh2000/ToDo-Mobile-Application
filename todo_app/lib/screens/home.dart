import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState(){
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      _todoText(),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChange: _handleToDoChange,
                          OnDeleteItem: _handleDelete,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: _addTaskTextBox(),
                ),
                _addTaskButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDelete(String id){
    setState(() {
      todoList.removeWhere((item) => item.id==id);
      _foundToDo.removeWhere((item) => item.id ==id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todoList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enterKeyword){
    List<ToDo> results = [];
    if(enterKeyword.isEmpty){
      results = todoList;
    }else{
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Container _todoText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 20),
      child: const Text(
        'To-Do:',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Container _addTaskTextBox() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _todoController,
        decoration: InputDecoration(
          hintText: 'Add a new todo item',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container _addTaskButton() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        right: 20,
      ),
      child: ElevatedButton(
        onPressed: () {
          _addToDoItem(_todoController.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5F52EE),
          minimumSize: const Size(60,60),
          elevation: 10,
        ),
        child: const Text(
          '+',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  Container _SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF3A3A3A),
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0xFF717171)),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFEEEFF5),
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: Colors.black87,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/x.jpg'),
          ),
        ),
      ]),
    );
  }
}
