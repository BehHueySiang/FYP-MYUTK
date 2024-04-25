import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myutk/models/user.dart';
import 'package:myutk/models/destination.dart';
import 'package:http/http.dart' as http;
import 'package:myutk/ipconfig.dart';


class editdestinationscreen extends StatefulWidget {
  final User user;
   Des destination;
   editdestinationscreen({super.key, required this.user, required this.destination});

  @override
  State<editdestinationscreen> createState() => _editdestinationscreenState();
}

class _editdestinationscreenState extends State<editdestinationscreen> {
     List<File?> _images = List.generate(3, (_) => null);
     int index = 0;
     List<Des> Deslist = <Des>[];
    
     var pathAsset = "assets/images/camera1.png";
     final _formKey = GlobalKey<FormState>();
      late double screenHeight, screenWidth, cardwitdh;
      final TextEditingController _DesnameEditingController =
          TextEditingController();
      final TextEditingController _UrlEditingController =
          TextEditingController();
      final TextEditingController _OpenTimeEditingController =
          TextEditingController();
      final TextEditingController _CloseTimeEditingController =
          TextEditingController();
      final TextEditingController _SuggestTimeEditingController =
          TextEditingController();
      final TextEditingController _ActivityEditingController =
          TextEditingController();
      final TextEditingController _DesBudgetEditingController =
          TextEditingController();
      String desrate = "1";
        List<String> Ratelist = [
          "1","2","3","4","5","6","7","8","9","10",
        ];
        String desstate = "Kedah";
        List<String> Statelist = [
          "Kedah","Pulau Penang","Perlis"
        ];

      @override
       void initState() {
    super.initState();
    print('Debug destination: ${widget.destination.toJson()}');
    _DesnameEditingController.text = widget.destination.desname.toString();
    _UrlEditingController.text = widget.destination.url.toString();
    _OpenTimeEditingController.text = widget.destination.opentime.toString();
    _CloseTimeEditingController.text = widget.destination.closetime.toString();
    _SuggestTimeEditingController.text = widget.destination.suggesttime.toString();
    _ActivityEditingController.text = widget.destination.activity.toString();
    _DesBudgetEditingController.text = widget.destination.desbudget.toString();
    desrate = widget.destination.desrate.toString();
    desstate = widget.destination.desstate.toString();
     if (!Ratelist.contains(widget.destination.desrate)) {
    desrate = Ratelist.first;
  }

  // Check if the selected desstate is in the Statelist, if not set it to the first item
  if (!Statelist.contains(widget.destination.desstate)) {
    desstate = Statelist.first;
  
}

 
  }


      @override
        Widget build(BuildContext context) {
           screenHeight = MediaQuery.of(context).size.height;
           screenWidth = MediaQuery.of(context).size.width;
           return Scaffold(
            appBar: AppBar(
        title: Image.asset(
                    "assets/images/Logo.png",
                  ),
         backgroundColor: Colors.amber[200],
        actions: [
             IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.notifications_active)),
              ]
            ),
            backgroundColor: Colors.amber[50],
            //////////////////////////
             body: SingleChildScrollView( // Make the entire body scrollable
      child: Column(children: [ Card(
            child: SizedBox(
              height: screenHeight / 2.5,
             child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Card(
                      child: Container(
                        width: screenWidth,
                        child: CachedNetworkImage(
                          width: screenWidth,
                          fit: BoxFit.cover,
                          imageUrl:  "${MyConfig().SERVER}/MyUTK/assets/Destination/${widget.destination.desid?.toString() ?? 'default'}_image.png?v=${DateTime.now().millisecondsSinceEpoch}",
                          placeholder: (context, url) => const LinearProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Card(
                      child: Container(
                        width: screenWidth,
                        child: CachedNetworkImage(
                          width: screenWidth,
                          fit: BoxFit.cover,
                          imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Destination/${widget.destination.desid?.toString() ?? 'default'}_image2.png?v=${DateTime.now().millisecondsSinceEpoch}",
                          placeholder: (context, url) => const LinearProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Card(
                      child: Container(
                        width: screenWidth,
                        child: CachedNetworkImage(
                          width: screenWidth,
                          fit: BoxFit.cover,
                          imageUrl: "${MyConfig().SERVER}/MyUTK/assets/Destination/${widget.destination.desid?.toString() ?? 'default'}_image3.png?v=${DateTime.now().millisecondsSinceEpoch}",
                          placeholder: (context, url) => const LinearProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Form(
              key: _formKey,
             
                child: Column(
                  children: [
                  
                        
                        TextFormField(
                                          textInputAction: TextInputAction.next,
                                          validator: (val) =>
                                              val!.isEmpty || (val.length < 3)
                                                  ? "Destination name must be longer than 3"
                                                  : null,
                                          onFieldSubmitted: (v) {},
                                          controller: _DesnameEditingController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            labelText: 'Destination Name',
                                            labelStyle: TextStyle(color: Colors.amber),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2.0),
                                            ),
                                          ),
                                        ),
                                    const SizedBox(height: 20,),
                    TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _UrlEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Redirect Link',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _OpenTimeEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Open Time',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                        ),const SizedBox(width: 20,),
                        Flexible(
                          flex: 5,
                          child:TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _CloseTimeEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Close Time',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                              onFieldSubmitted: (v) {},
                              controller: _SuggestTimeEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Suggest Time',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                                    const SizedBox(height: 20,),
               TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                               maxLines: 4,       
                              onFieldSubmitted: (v) {},
                              controller: _ActivityEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Activities',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                               const SizedBox(height: 20,),
                  //DesState
                    SizedBox(
                              height: 60,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'State',
                                  labelStyle: TextStyle(color: Colors.amber),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                ),
                                value: desstate,
                                onChanged: (newValue) {
                                  setState(() {
                                    desstate = newValue!;
                                    print(desstate);
                                  });
                                },
                                items: Statelist.map((desstate) {
                                  return DropdownMenuItem(
                                    value: desstate,
                                    child: Text(
                                      desstate,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                             const SizedBox(height: 20,),
                    //DesRate
                  SizedBox(
                              height: 60,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Rate',
                                  labelStyle: TextStyle(color: Colors.amber),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),
                                ),
                                value: desrate,
                                onChanged: (newValue) {
                                  setState(() {
                                    desrate = newValue!;
                                    print(desrate);
                                  });
                                },
                                items: Ratelist.map((desrate) {
                                  return DropdownMenuItem(
                                    value: desrate,
                                    child: Text(
                                      desrate,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 20,),
                    Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child:  TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? ""
                                      : null,
                                    
                              onFieldSubmitted: (v) {},
                              controller: _DesBudgetEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Estimate Budget Per/Person',
                                  labelStyle: TextStyle(color: Colors.amber),
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ),border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),)),),
                        ),const SizedBox(width: 20,),
                        Flexible( 
                          flex: 2,
                   child: SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            updateDestination();
                          },
                          child: const Text("Submit",style: TextStyle(color: Colors.black), ),
                          style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),)),))]
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            ),]),),);
    
  }

  
void updateDestination() {
    String DesName = _DesnameEditingController.text;
    String Url = _UrlEditingController.text;
    String OpenTime = _OpenTimeEditingController.text;
    String CloseTime = _CloseTimeEditingController.text;
    String SuggestTime = _SuggestTimeEditingController.text;
    String Activity = _ActivityEditingController.text;
    String DesBudget = _DesBudgetEditingController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/MyUTK/php/update_des.php"),
        body: {
          "userid": widget.user.id.toString(),
          "DesId": widget.destination.desid,
          "desname": DesName,
          "url": Url,
          "opentime": OpenTime,
          "closetime": CloseTime,
          "suggesttime": SuggestTime,
          "activity": Activity,
          "desbudget": DesBudget,
          "desrate": desrate,
          "desstate": desstate,
        
   
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Successfully")));
         
              
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Insert Failed")));
        Navigator.pop(context);
      }
    });
  }

}