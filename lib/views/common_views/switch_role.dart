import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider_parts/user_provider.dart';

class SwitchRole extends StatefulWidget {
  @override
  _SwitchRoleState createState() => _SwitchRoleState();
}

class _SwitchRoleState extends State<SwitchRole> {
  bool isWorker = true;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        // up.switchUserRole();
        setState(() {
          isWorker = !isWorker;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isWorker ? Icons.work : Icons.business),
            const SizedBox(width: 8.0),
            Text(
              isWorker ? 'Switch to Company' : 'Switch to Worker',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
