import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/auth/common_widget/auth_input.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfoEditListComponent extends StatefulWidget {
  const InfoEditListComponent(
      {super.key,
      required this.placeHolder,
      required this.value,
      this.ext,
      required this.onChangeValue,
      this.onChangeExtValue});
  final String placeHolder;
  final List<String> value;

  final List<String>? ext;
  final Function(List<String> value) onChangeValue;
  final Function(String value)? onChangeExtValue;

  @override
  State<InfoEditListComponent> createState() => _InfoEditListComponentState();
}

class _InfoEditListComponentState extends State<InfoEditListComponent> {
  List<TextEditingController> controller = [];
  List<String>? ext;

  List<Map<String, dynamic>> value = [];

  @override
  void initState() {
    for (int i = 0; i < widget.value.length; ++i) {
      // controller.add(TextEditingController(text: widget.value[i]));
      value.add({
        "controller": TextEditingController(text: widget.value[i]),
        "ext": widget.ext != null ? widget.ext![i] : null
      });
    }
    // ext = widget.ext;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.placeHolder,
                    style: ThemeTextStyles
                        .informationDisplayPlaceHolderThemeTextStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      value.add({
                        "controller": TextEditingController(),
                        "ext": widget.ext != null ? "" : null
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[700]!)),
                    child: Icon(
                      Icons.add,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            ...value
                .map(
                  (e) => Row(
                    children: [
                      if (e["ext"] != null)
                        Container(
                          height: 50,
                          //width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          child: AuthInput(
                            child: Center(
                              child: CountryCodePicker(
                                onChanged: (val) {
                                  print(val);
                                  // _onCountryChange(value);
                                  e["ext"] = val.dialCode;
                                  List<String> res = [];
                                  for (int i = 0; i < value.length; ++i) {
                                    if (e["ext"] != null) {
                                      //widget.onChangeValue("${e["ext"]!}-$val");
                                      res.add(value[i]["ext"] +
                                          "-" +
                                          value[i]["controller"].text);
                                    } else {
                                      // widget.onChangeValue(val);
                                      res.add(value[i]["controller"].text);
                                    }
                                  }
                                  widget.onChangeValue(res);
                                  // widget.onChangeExtValue!(value.dialCode!);
                                },
                                initialSelection: e["ext"],
                                favorite: const ['+1', '+52', 'FR'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.all(16),
                          // width: 200,//MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              // color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.blueAccent)),
                          child: TextField(
                            controller: e["controller"],
                            //  textInputAction: widget.action,
                            onChanged: (val) {
                              // print(value[0]["controller"]);
                              List<String> res = [];
                              for (int i = 0; i < value.length; ++i) {
                                if (e["ext"] != null) {
                                  //widget.onChangeValue("${e["ext"]!}-$val");
                                  res.add(value[i]["ext"] +
                                      "-" +
                                      value[i]["controller"].text);
                                } else {
                                  // widget.onChangeValue(val);
                                  res.add(value[i]["controller"].text);
                                }
                              }
                              widget.onChangeValue(res);
                              // if (e["ext"] != null) {
                              //   widget.onChangeValue("${e["ext"]!}-$val");
                              // } else {
                              //   widget.onChangeValue(val);
                              // }
                            },
                            decoration: InputDecoration.collapsed(
                                hintText: widget.placeHolder),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
