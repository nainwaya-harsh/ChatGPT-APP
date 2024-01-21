import 'package:chatgpt_integration/constants/constants.dart';
import 'package:chatgpt_integration/models/models_model.dart';
import 'package:chatgpt_integration/providers/models_provider.dart';
import 'package:chatgpt_integration/services/api_services.dart';
import 'package:chatgpt_integration/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                      dropdownColor: cardColor,
                      items: List<DropdownMenuItem<String>>.generate(
                          snapshot.data!.length,
                          (index) => DropdownMenuItem(
                              value: snapshot.data![index].id,
                              child: TextWidget(
                                label: snapshot.data![index].id,
                                fontSize: 15,
                              ))),
                      value: currentModel,
                      onChanged: (value) {
                        setState(() {
                          currentModel = value.toString();
                          modelsProvider.setCurrentModel(value.toString());
                        });
                      }),
                );
        });
  }
}

// DropdownButton(
//         dropdownColor: cardColor,
//         items: getModelsItem,
//         value: currentModel,
//         onChanged: (value) {
//           setState(() {
//             currentModel = value.toString();
//           });
//         }); 


