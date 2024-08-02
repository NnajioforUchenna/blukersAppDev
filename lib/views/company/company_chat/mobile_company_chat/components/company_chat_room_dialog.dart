import 'package:blukers/views/company/company_chat/mobile_company_chat/components/company_chat_room.dart';
import 'package:flutter/material.dart';

class CompanyChatRoomDialog extends StatelessWidget {
  const CompanyChatRoomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          const CompanyChatRoom(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  child: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
