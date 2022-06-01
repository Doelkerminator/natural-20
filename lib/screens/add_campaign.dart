import 'dart:io';
import 'package:provider/provider.dart';
import 'package:natural_20/providers/add_campaign_notifier.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/settings/settings_color.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({Key? key}) : super(key: key);
  @override
  State<AddCampaignScreen> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  late bool isEnabled;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  var txtNameController = TextEditingController();
  var txtDetailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Crear Campaña'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
          ),
          body: formAddCampaign()),
    );
  }

  Widget formAddCampaign() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: IgnorePointer(
            ignoring: context.watch<AddCampaignState>().isEnabled,
            child: Column(
              children: [
                txtFormFieldNameCampaign(),
                const SizedBox(height: 20),
                txtFormFieldDetailsCampaign(),
                const SizedBox(height: 20),
                pickedFile != null ? imageSelected() : Container(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: selectImage,
                  child: const Text("Seleccionar Imagen")),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: context.watch<AddCampaignState>().isNotLoading
                    ? ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<AddCampaignState>().changeLoad();
                            context.read<AddCampaignState>().chengeEnabled();
                            await upload();
                            context.read<AddCampaignState>().loadMessageComplete();
                            await Future.delayed(const Duration(seconds: 3), (){});
                            context.read<AddCampaignState>().chengeEnabled();
                            context.read<AddCampaignState>().changeLoad();
                            context.read<AddCampaignState>().recoveryLoadMessage();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/list_campaign');
                          }
                        },
                        child: const Text('Enviar'),
                      )
                    : Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 5),
                            Text("${context.watch<AddCampaignState>().loadMessage}")
                          ],
                        ) 
                      )),
                const SizedBox(height: 20)
              ]),
          ))));
  }

  Widget txtFormFieldNameCampaign() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtNameController,
      decoration: const InputDecoration(
        labelText: 'Nombre de la Campaña',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vacío.';
        }
        return null;
      },
    );
  }

  Widget txtFormFieldDetailsCampaign() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtDetailsController,
      maxLines: 8,
      decoration: const InputDecoration(
        labelText: 'Descripción de la campaña',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vacío.';
        }
        return null;
      },
    );
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<String> uploadImage() async {
    final path = 'imagesCampaign/${pickedFile!.name}';
    print("E");
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

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text('${progress * 100}%',
                      style: const TextStyle(color: Colors.white)),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(height: 50);
        }
      });

  Widget imageSelected() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Image.file(
        File(pickedFile!.path!),
        width: MediaQuery.of(context).size.width / 1.5,
        fit: BoxFit.cover,
      ));
  }

  Future upload() async {
    String urlImage = "";
    urlImage = await uploadImage();
    DatabaseFirestore.createCampaign(
        urlImage, txtNameController.text, txtDetailsController.text);
  }
}
