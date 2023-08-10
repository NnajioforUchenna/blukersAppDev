import 'package:bulkers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/common_widget/auth_input.dart';

class ReferenceForm extends StatefulWidget {
  final int index;

  ReferenceForm({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ReferenceForm> createState() => _ReferenceFormState();
}

class _ReferenceFormState extends State<ReferenceForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      WorkerProvider wp = Provider.of<WorkerProvider>(context, listen: false);
      _nameController.text = wp.references[widget.index]['name'] ?? '';
      _phoneNumberController.text =
          wp.references[widget.index]['phoneNumber'] ?? '';
      _emailController.text = wp.references[widget.index]['email'] ?? '';
      _relationshipController.text =
          wp.references[widget.index]['relationship'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              "Reference Form ${widget.index + 1}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            AuthInput(
              child: TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.references[widget.index]['name'] = value;
                },
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _phoneNumberController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.references[widget.index]['phoneNumber'] = value;
                },
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.references[widget.index]['email'] = value;
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthInput(
              child: TextFormField(
                controller: _relationshipController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                validator: (value) => value!.isEmpty ? "Required" : null,
                onChanged: (value) {
                  wp.references[widget.index]['relationship'] = value;
                },
                decoration: InputDecoration(
                  hintText: "Relationship",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
