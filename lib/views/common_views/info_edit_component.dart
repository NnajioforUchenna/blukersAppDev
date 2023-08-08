import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/auth/common_widget/auth_input.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class InfoEditComponent extends StatefulWidget {
  const InfoEditComponent(
      {super.key,
      required this.placeHolder,
      required this.value,
      required this.action,
      required this.onChangeValue,
      this.ext,
      this.onChangeExtValue,
       this.textInputType = TextInputType.text});
  final String placeHolder;
  final String value;
  final TextInputAction action;
  final String? ext;
  final Function(String value) onChangeValue;
  final Function(String value)? onChangeExtValue;
  final TextInputType textInputType;

  @override
  State<InfoEditComponent> createState() => _InfoEditComponentState();
}

class _InfoEditComponentState extends State<InfoEditComponent> {
  TextEditingController controller = TextEditingController();
  String? ext;
  @override
  void initState() {
    controller.text = widget.value;
    ext = widget.ext;
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
            Text(
              widget.placeHolder,
              style:
                  ThemeTextStyles.informationDisplayPlaceHolderThemeTextStyle,
            ),
            Row(
              children: [
                if (ext != null)
                  Container(
                    height: 50,
                    //width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    child: AuthInput(
                      child: Center(
                        child: CountryCodePicker(
                          onChanged: (value) {
                            print(value);
                            // _onCountryChange(value);
                            ext = value.dialCode;
                            widget.onChangeExtValue!(value.dialCode!);
                          },
                          initialSelection: ext,
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
                      controller: controller,
                      textInputAction: widget.action,
                      keyboardType: widget.textInputType,
                      onChanged: (val) {
                        if (ext != null) {
                          widget.onChangeValue("${ext!}-$val");
                        } else {
                          widget.onChangeValue(val);
                        }
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: widget.placeHolder),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
