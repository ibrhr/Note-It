import '../../../constants/exports.dart';
import '../../../data/models/note_model/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: note.color == ColorManager.scaffoldDarkColor
                ? ColorManager.borderGrey
                : ColorManager.scaffoldDarkColor,
          ),
          color: note.color),
      child: Column(children: [
        note.image ?? Container(),
        note.title != null
            ? Container(
                padding: const EdgeInsets.all(8),
                child: PrimaryText(
                  note.title!,
                  fontSize: 15,
                ))
            : Container(),
        Container(
            padding: const EdgeInsets.all(8), child: PrimaryText(note.text))
      ]),
    );
  }
}
