import 'package:note_it/app/constants/exports.dart';

class GlobalDialog extends StatelessWidget {
  final String title;
  final Widget details;
     const GlobalDialog({Key? key, required this.title, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding:    const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [PrimaryText(title,fontSize: 24,), details],
        ),
      ),
    );
  }
}
