import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/models/campaign_model.dart';
import 'package:natural_20/settings/SettingsButtons.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:provider/provider.dart';
import '../database/database_firestore.dart';
import '../providers/add_campaign_notifier.dart';
import '../settings/settings_form.dart';

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
    return Container(
      color: SettingsColor.primaryColor,
      child: formAddCampaign(),
    );
  }

  Widget formAddCampaign() {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: SingleChildScrollView(
                child: IgnorePointer(
              ignoring: context.watch<AddCampaignState>().isEnabled,
              child: Column(children: [
                txtFormFieldNameCampaign(),
                const SizedBox(height: 20),
                txtFormFieldDetailsCampaign(),
                const SizedBox(height: 20),
                image(),
                Text(
                  context.watch<AddCampaignState>().imageStatus,
                  style: TextStyle(color: SettingsColor.textColor),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: SettingsButtons.buttonStyle1(),
                    onPressed: selectImage,
                    child: const Text("Seleccionar Imagen")),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: context.watch<AddCampaignState>().isNotLoading
                        ? Column(children: [
                            ElevatedButton(
                              onPressed: () async {
                                principal:
                                if (_formKey.currentState!.validate()) {
                                  if (widget.objCampaig == null) {
                                    if (pickedFile != null) {
                                      if (pickedFile!.extension != "png" &&
                                          pickedFile!.extension != "jpg" &&
                                          pickedFile!.extension != "jpeg") {
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
                                          pickedFile!.extension != "jpg" &&
                                          pickedFile!.extension != "jpeg") {
                                        context
                                            .read<AddCampaignState>()
                                            .imageStatusTypeNotCorrect();
                                        break principal;
                                      } else {
                                        await process();
                                        break principal;
                                      }
                                    } else {
                                      await process();
                                    }
                                  }
                                }
                              },
                              child: const Text('Enviar'),
                              style: SettingsButtons.buttonStyle1(),
                            ),
                            const SizedBox(height: 10),
                            widget.objCampaig != null
                                ? ElevatedButton(
                                    onPressed: () {
                                      delete();
                                    },
                                    child: const Text("Borrar partida"),
                                    style: SettingsButtons.buttonStyle1(),
                                  )
                                : Container()
                          ])
                        : Center(
                            child: Column(
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 5),
                              Text(
                                  context.watch<AddCampaignState>().loadMessage,
                                  style:
                                      TextStyle(color: SettingsColor.textColor))
                            ],
                          ))),
                const SizedBox(height: 5),
              ]),
            ))));
  }

  Widget txtFormFieldNameCampaign() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtNameController,
      style: const TextStyle(color: Colors.white),
      decoration: SettingsForm.textFieldDecoration('Nombre de la campa??a'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vac??o.';
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
      style: const TextStyle(color: Colors.white),
      decoration: SettingsForm.textFieldDecoration('Descripci??n de la campa??a'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vac??o.';
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
    if (pickedFile!.extension != "png" &&
        pickedFile!.extension != "jpg" &&
        pickedFile!.extension != "jpeg") {
      context.read<AddCampaignState>().imageStatusTypeNotCorrect();
    } else {
      context.read<AddCampaignState>().imageStatusSelected();
    }
  }

  Future<String> uploadImage() async {
    if (pickedFile == null ||
        (pickedFile?.extension != "png" &&
            pickedFile?.extension != "jpg" &&
            pickedFile!.extension != "jpeg")) {
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
    String? urlImage = "";
    urlImage = await uploadImage();
    if (urlImage == "Not Image") {
      urlImage = "";
    }
    if (widget.objCampaig == null) {
      DatabaseFirestore.createCampaign(
          urlImage, txtNameController.text, txtDetailsController.text);
    } else {
      if (widget.objCampaig != null) {
        if (widget.objCampaig?.imagen != "" && pickedFile?.name == null) {
          urlImage = widget.objCampaig?.imagen;
        }
      }
      DatabaseFirestore.updateCampaign(widget.objCampaig?.id, urlImage,
          txtNameController.text, txtDetailsController.text);
    }
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
    context.read<AddCampaignState>().imageStatusNoSelected();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/list_campaign');
  }

  Future delete() async {
    context.read<AddCampaignState>().changeLoad();
    context.read<AddCampaignState>().chengeEnabled();
    await DatabaseFirestore.deleteCampaign(widget.objCampaig?.id);
    context.read<AddCampaignState>().loadMessageDelete();
    await Future.delayed(const Duration(seconds: 3), () {});
    context.read<AddCampaignState>().chengeEnabled();
    context.read<AddCampaignState>().changeLoad();
    context.read<AddCampaignState>().recoveryLoadMessage();
    context.read<AddCampaignState>().imageStatusNoSelected();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/list_campaign');
  }

  Widget image() {
    if (widget.objCampaig == null) {
      if (pickedFile?.name == null ||
          pickedFile?.name == "Not Image" ||
          (pickedFile!.extension != "png" &&
              pickedFile!.extension != "jpg" &&
              pickedFile!.extension != "jpeg")) {
        return Image.asset("assets/images/not-available_campaign.png");
      } else {
        return imageSelected();
      }
    } else {
      if (widget.objCampaig!.imagen! == "" && pickedFile?.name == null) {
        return Image.asset("assets/images/not-available_campaign.png");
      } else if (widget.objCampaig!.imagen! != "" && pickedFile?.name == null) {
        context.watch<AddCampaignState>().imageStatusSelected();
        return Image.network(widget.objCampaig!.imagen!);
      } else if (pickedFile?.name != null &&
          (pickedFile!.extension == "png" ||
              pickedFile!.extension == "jpg" ||
              pickedFile!.extension == "jpeg")) {
        context.watch<AddCampaignState>().imageStatusSelected();
        return imageSelected();
      } else if (pickedFile?.name != null &&
          (pickedFile!.extension != "png" &&
              pickedFile!.extension != "jpg" &&
              pickedFile!.extension != "jpeg")) {
        context.watch<AddCampaignState>().imageStatusTypeNotCorrect();
        return Image.asset("assets/images/not-available_campaign.png");
      }
      return imageSelected();
    }
  }
}
