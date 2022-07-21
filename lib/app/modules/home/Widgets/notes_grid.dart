import 'package:notes/app/data/models/note_model/note.dart';
import 'package:notes/app/modules/home/Widgets/note_card.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../constants/exports.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({Key? key, required this.crossAxis, required this.children})
      : super(key: key);
  final int crossAxis;
  final List<Note> children;
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      staggeredTiles: children.map((e) => const StaggeredTile.fit(2)).toList(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(4),
      children: children.map((e) => NoteCard(note: e)).toList(),
    );
  }
}
