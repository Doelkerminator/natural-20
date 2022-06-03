import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/models/campaign_model.dart';
import 'package:provider/provider.dart';
import '../database/database_firestore.dart';
import '../providers/add_campaign_notifier.dart';

class FormCampaign extends StatefulWidget {
  Campaign? objCampaig;
  FormCampaign({Key? key, this.objCampaig}) : super(key: key);

  @override
  State<FormCampaign> createState() => _FormCampaignState();
}

class _FormCampaignState extends State<FormCampaign> {
  late bool isEnabled;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  var txtNameController = TextEditingController();
  var txtDetailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.objCampaig != null) {
      txtNameController.text = widget.objCampaig!.nombre!;
      txtDetailsController.text = widget.objCampaig!.detalles!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return formAddCampaign();
  }

  Widget formAddCampaign() {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: IgnorePointer(
              ignoring: context.watch<AddCampaignState>().isEnabled,
              child: Column(children: [
                txtFormFieldNameCampaign(),
                const SizedBox(height: 20),
                txtFormFieldDetailsCampaign(),
                const SizedBox(height: 20),
                image(),
                /*widget.objCampaig == null ? ((pickedFile?.name == null ||
                    pickedFile?.name == "Not Image" ||
                    (pickedFile!.extension != "png" &&
                      pickedFile!.extension != "jpg"))
                  ? Image.asset("assets/not-available_campaign.png")
                  : imageSelected()) : (widget.objCampaig!.imagen! == "" ? 
                  Image.asset("assets/not-available_campaign.png") : Image.network(widget.objCampaig!.imagen!)),*/
                Text(context.watch<AddCampaignState>().imageStatus),
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
                              principal:
                              if (_formKey.currentState!.validate()) {
                                if (widget.objCampaig == null) {
                                  if (pickedFile != null) {
                                    if (pickedFile!.extension != "png" &&
                                        pickedFile!.extension != "jpg") {
                                      context
                                          .read<AddCampaignState>()
                                          .imageStatusTypeNotCorrect();
                                      break principal;
                                    } else {
                                      await process();
                                      break principal;
                                    }
                                  }
                                  await process();
                                } else {
                                  if (pickedFile != null) {
                                    if (pickedFile!.extension != "png" &&
                                        pickedFile!.extension != "jpg") {
                                      context
                                      .read<AddCampaignState>()
                                      .imageStatusTypeNotCorrect();
                                      break principal;
                                    } else {
                                      await process();
                                      break principal;
                                    }
                                  } else {await process();}
                                }
                              }
                            },
                            child: const Text('Enviar'),
                          )
                        : Center(
                            child: Column(
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 5),
                              Text(
                                  context.watch<AddCampaignState>().loadMessage)
                            ],
                          ))),
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
    if (pickedFile!.extension != "png" && pickedFile!.extension != "jpg") {
      context.read<AddCampaignState>().imageStatusTypeNotCorrect();
    } else {
      context.read<AddCampaignState>().imageStatusSelected();
    }
  }

  Future<String> uploadImage() async {
    if (pickedFile == null ||
        (pickedFile?.extension != "png" && pickedFile?.extension != "jpg")) {
      return "Not Image";
    } else {
      final path = 'imagesCampaign/${pickedFile?.name}';
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
    if (urlImage == "Not Image") {
      if(widget.objCampaig != null){
        if(pickedFile == null){
          
        }
      }
      urlImage = "";
    }
    if (widget.objCampaig == null) {
      DatabaseFirestore.createCampaign(
          urlImage, txtNameController.text, txtDetailsController.text);
    } else {}
  }

  Future process() async {
    context.read<AddCampaignState>().changeLoad();
    context.read<AddCampaignState>().chengeEnabled();
    await upload();
    context.read<AddCampaignState>().loadMessageComplete();
    await Future.delayed(const Duration(seconds: 3), () {});
    context.read<AddCampaignState>().chengeEnabled();
    context.read<AddCampaignState>().changeLoad();
    context.read<AddCampaignState>().recoveryLoadMessage();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/list_campaign');
  }

  Widget image() {
    if (widget.objCampaig == null) {
      if (pickedFile?.name == null ||
          pickedFile?.name == "Not Image" ||
          (pickedFile!.extension != "png" && pickedFile!.extension != "jpg")) {
        return Image.asset("assets/not-available_campaign.png");
      } else {
        return imageSelected();
      }
    } else {
      if (widget.objCampaig!.imagen! == "" && pickedFile?.name == null) {
        context.watch<AddCampaignState>().imageStatusNoSelected();
        return Image.asset("assets/not-available_campaign.png");
      } else if (widget.objCampaig!.imagen! != "" && pickedFile?.name == null) {
        context.watch<AddCampaignState>().imageStatusSelected();
        return Image.network(widget.objCampaig!.imagen!);
      } else if ((widget.objCampaig!.imagen! != "" ||
              widget.objCampaig!.imagen! == "") &&
          pickedFile?.name != null) {
        context.watch<AddCampaignState>().imageStatusSelected();
        return imageSelected();
      }
      return imageSelected();
    }
  }
}
