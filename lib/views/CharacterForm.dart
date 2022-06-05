
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:natural_20/settings/settings_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../database/database_firestore.dart';
import '../models/CharacterModel.dart';
import '../providers/CharacterNotifier.dart';
import '../settings/settings_color.dart';

class CharacterForm extends StatefulWidget {
  Character? character;
  CharacterForm({Key? key, this.character}) : super (key: key);

  @override
  State<CharacterForm> createState() => _CharacterForm();
}

class _CharacterForm extends State<CharacterForm> {
  late bool isEnabled;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  var txtName = TextEditingController();
  var txtClass = TextEditingController();
  var txtLvl = TextEditingController();
  var txtRace = TextEditingController();

  var txtSTR = TextEditingController();
  var txtDEX = TextEditingController();
  var txtCON = TextEditingController();
  var txtINT = TextEditingController();
  var txtWIS = TextEditingController();
  var txtCHR = TextEditingController();
  var txtAlignment = TextEditingController();
  var txtBackground = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: SettingsColor.secondaryColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height*3/10,
                            width: MediaQuery.of(context).size.width*7/16,
                            child: (pickedFile == null ? Image.asset('assets/defaultAppearance.jpg') : imageSelected()),
                          ),
                          onTap: selectImage
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height/18,
                                width: MediaQuery.of(context).size.width*3/8,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: txtName,
                                    decoration: SettingsForm.textFieldDecoration('Nombre'),
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {
                                        return ':c';
                                      }
                                      return null;
                                    }
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height/18,
                                width: MediaQuery.of(context).size.width*3/8,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: txtClass,
                                    decoration: SettingsForm.textFieldDecoration('Clase'),
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {
                                        return ':c';
                                      }
                                      return null;
                                    }
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height/18,
                                width: MediaQuery.of(context).size.width*3/8,
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: txtLvl,
                                    decoration: SettingsForm.textFieldDecoration('Nivel'),
                                    validator: (value) {
                                      if(value == null || value.isEmpty || double.parse(value) % 1 != 0) {
                                        return ':c';
                                      }
                                      return null;
                                    }
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height/18,
                                width: MediaQuery.of(context).size.width*3/8,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: txtRace,
                                    decoration: SettingsForm.textFieldDecoration('Raza'),
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {
                                        return ':c';
                                      }
                                      return null;
                                    }
                                )
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child:
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height/12,
                                width: MediaQuery.of(context).size.width*4/5,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: txtAlignment,
                                    decoration: SettingsForm.textFieldDecoration('Alineación'),
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {
                                        return ':c';
                                      }
                                      return null;
                                    }
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height/12,
                                width: MediaQuery.of(context).size.width*4/5,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: txtBackground,
                                    decoration: SettingsForm.textFieldDecoration('Trasfondo'),
                                    validator: (value) {
                                      if(value == null || value.isEmpty) {
                                        return ':c';
                                      }
                                      return null;
                                    }
                                )
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height/12,
                                    width: MediaQuery.of(context).size.width/5,
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: txtSTR,
                                        decoration: SettingsForm.textFieldDecoration('STR'),
                                        validator: (value) {
                                          if(value == null || value.isEmpty || double.parse(value) % 1 != 0) {
                                            return ':c';
                                          }
                                          return null;
                                        }
                                    )
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height/12,
                                    width: MediaQuery.of(context).size.width/5,
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: txtDEX,
                                        decoration: SettingsForm.textFieldDecoration('DEX'),
                                        validator: (value) {
                                          if(value == null || value.isEmpty || double.parse(value) % 1 != 0) {
                                            return ':c';
                                          }
                                          return null;
                                        }
                                    )
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height/12,
                                    width: MediaQuery.of(context).size.width/5,
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: txtCON,
                                        decoration: SettingsForm.textFieldDecoration('CON'),
                                        validator: (value) {
                                          if(value == null || value.isEmpty || double.parse(value) % 1 != 0) {
                                            return ':c';
                                          }
                                          return null;
                                        }
                                    )
                                )
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height/12,
                                    width: MediaQuery.of(context).size.width/5,
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: txtINT,
                                        decoration: SettingsForm.textFieldDecoration('INT'),
                                        validator: (value) {
                                          if(value == null || value.isEmpty || double.parse(value) % 1 != 0) {
                                            return ':c';
                                          }
                                          return null;
                                        }
                                    )
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height/12,
                                    width: MediaQuery.of(context).size.width/5,
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: txtWIS,
                                        decoration: SettingsForm.textFieldDecoration('WIS'),
                                        validator: (value) {
                                          if(value == null || value.isEmpty || double.parse(value) % 1 != 0) {
                                            return ':c';
                                          }
                                          return null;
                                        }
                                    )
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height/12,
                                    width: MediaQuery.of(context).size.width/5,
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: txtCHR,
                                        decoration: SettingsForm.textFieldDecoration('CHR'),
                                        validator: (value) {
                                          if(value == null || value.isEmpty || double.parse(value) % 1 != 0) {
                                            return ':c';
                                          }
                                          return null;
                                        }
                                    )
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: true
                    ? ElevatedButton(
                    onPressed: () async {
                      secondary:
                      if(_formKey.currentState!.validate()) {
                        if(pickedFile != null) {
                          if(pickedFile!.extension != "png" && pickedFile!.extension != "jpg") {
                            break secondary;
                          }
                          else {
                            await process();
                            break secondary;
                          }
                        }
                      }
                    },
                    child: const Text('Enviar'),
                  )
                      : Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 5),
                          Text(
                              'nao nao')
                        ],
                      )))
            ],
          ),
      ),
    );
  }
  Future<String> uploadImage() async {
    if (pickedFile == null ||
        (pickedFile?.extension != "png" && pickedFile?.extension != "jpg")) {
      return "Not Image";
    } else {
      String name = sha256.convert(utf8.encode('${pickedFile!.name} $Random()')).toString();
      final path = 'imagesCharacters/$name';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlImage = await snapshot.ref.getDownloadURL();
      setState(() {
        uploadTask = null;
      });
      return urlImage;
    }
  }

  Future upload() async {
    User? user = FirebaseAuth.instance.currentUser;
    String urlImage = "";
    urlImage = await uploadImage();
    if (urlImage == "Not Image") {
      urlImage = "";
    }
    Character character = Character(
      uid: sha256.convert(utf8.encode(txtName.text + txtRace.text + txtClass.text + user!.uid)).toString(),
      name: txtName.text,
      level: int.parse(txtLvl.text),
      classe: txtClass.text,
      background: txtBackground.text,
      playerName: user.displayName,
      race: txtRace.text,
      alignment: txtAlignment.text,
      strength: int.parse(txtSTR.text),
      dexterity: int.parse(txtDEX.text),
      constitution: int.parse(txtCON.text),
      intelligence: int.parse(txtINT.text),
      wisdom: int.parse(txtWIS.text),
      charisma: int.parse(txtCHR.text),
      appearance: urlImage
    );
    DatabaseFirestore.createCharacter(character);
  }

  Future process() async {
    await upload();
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/characters');
  }

  Widget imageSelected() {
    return Image.file(
      File(pickedFile!.path!),
      fit: BoxFit.cover,
    );
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    if (pickedFile!.extension != "png" && pickedFile!.extension != "jpg") {
      context.read<CharacterState>().imageStatusTypeNotCorrect();
    } else {
      context.read<CharacterState>().imageStatusSelected();
    }
  }
}