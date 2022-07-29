import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../constants/exports.dart';
import 'note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    Key? key,
    required this.crossAxis,
    required this.tiles,
    required this.cards,
  }) : super(key: key);

  final int crossAxis;
  final List<StaggeredTile> tiles;
  final List<NoteCard> cards;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      shrinkWrap: true,
      crossAxisCount: crossAxis,
      staggeredTiles: tiles,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(4),
      children: cards,
    );
  }
}
