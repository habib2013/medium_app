import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  var validatedInput = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.clear,size: 30.0,color: Colors.blueGrey),onPressed: (){
          Navigator.pop(context);
        },),
        elevation: 0,
        title: Text('Add Blog',style: TextStyle(fontFamily: 'Signatra',fontSize: 30.0,color: Colors.blueGrey),),
        centerTitle: true,
        actions: [
          FlatButton(onPressed: null, child: Text('Preview',style: TextStyle(fontSize: 16.0,color: Colors.blueGrey[400],fontFamily: 'Raleway',fontWeight: FontWeight.bold),)),
        ],
      ),


      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 55.0),
        child: ListView(
          children: [
            _ourInputsForm("Blog Title",),
            SizedBox(height: 30,),
            _ourInputsForm("Body",),
            SizedBox(height: 30,),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _ourInputsForm(String title,{ var ourController}) {
    return TextFormField(
        controller: ourController,
        validator: (value){
          if (value.isEmpty || value.length <= 2) {setState(() {
            validatedInput = false;
          });
          return "❌ ${title} can\'t be empty";
          }
        },
        maxLines: title == 'Body' ? 4 : 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: validatedInput ==  false ?  Colors.red : Colors.deepPurpleAccent,
            ),
          ) ,
          errorStyle: TextStyle(color: Colors.red),
          hintText: title,
          labelText: title,


        ),
        maxLength: title == 'Body' ? 400 : 50,

    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.blueGrey,
                  Colors.blueGrey[300],
                ])),
        child: Text(
          'Add Blog',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: 'Raleway'),
        ),
      ),
    );
  }

}


