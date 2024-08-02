import 'package:flutter/material.dart';
import '../../../models/messages.dart';
import 'package:file_picker/file_picker.dart';



class ReplyMessageDialog extends StatefulWidget {
  final void Function(Message) onSend;
  final Message? replyTo;

  const ReplyMessageDialog({required this.onSend, this.replyTo, super.key});

  @override
  _ReplyMessageDialogState createState() => _ReplyMessageDialogState();
}

class _ReplyMessageDialogState extends State<ReplyMessageDialog> {
  final TextEditingController _messageController = TextEditingController();
  List<PlatformFile>? _files;

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _files = result.files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reply to Message'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.replyTo != null)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue[50],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.reply, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Replying to:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(widget.replyTo!.content ?? 'No content'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Enter your message',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickFiles,
              icon: const Icon(Icons.attach_file),
              label: const Text('Attach Files'),
            ),
            if (_files != null)
              Column(
                children: _files!.map((file) => Text(file.name)).toList(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final content = _messageController.text;
            if (content.isNotEmpty) {
              final message = Message(
                sender: 'Your Name',
                content: content,
                replyTo: widget.replyTo,
                timestamp: DateTime.now(),
                subject: ' ',
                receiver: '',
                attachments: _files?.map((file) => file.path).toList() ?? [],
              );
              widget.onSend(message);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Send'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}





// class ComposeMessageDialog extends StatefulWidget {
//   final void Function(Message) onSend;
//
//   const ComposeMessageDialog({required this.onSend, super.key});
//
//   @override
//   _ComposeMessageDialogState createState() => _ComposeMessageDialogState();
// }
//
// class _ComposeMessageDialogState extends State<ComposeMessageDialog> {
//   final TextEditingController _receiverController = TextEditingController();
//   final TextEditingController _subjectController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   List<PlatformFile>? _files;
//
//   Future<void> _pickFiles() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (result != null) {
//       setState(() {
//         _files = result.files;
//       });
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Compose New Message'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _receiverController,
//               decoration: InputDecoration(
//                 labelText: 'Recepient username or email',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _subjectController,
//               decoration: InputDecoration(
//                 labelText: 'Subject',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your message',
//               ),
//               maxLines: 5,
//             ),
//             SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: _pickFiles,
//               icon: Icon(Icons.attach_file),
//               label: Text('Attach Files'),
//             ),
//             if (_files != null)
//               Column(
//                 children: _files!.map((file) => Text(file.name)).toList(),
//               ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             final subject = _subjectController.text;
//             final content = _messageController.text;
//             if (content.isNotEmpty) {
//               final message = Message(
//                 sender: 'Your Name',
//                 receiver: 'Username or email',
//                 content: content,
//                 subject: 'Subject',
//                 timestamp: DateTime.now(),
//                 attachments: _files?.map((file) => file.path).toList() ?? [],
//                 replyTo: null,
//               );
//               widget.onSend(message);
//               Navigator.of(context).pop();
//             }
//           },
//           child: Text('Send'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('Cancel'),
//         ),
//       ],
//     );
//   }
// }
