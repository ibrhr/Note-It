import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:notes/app/constants/exports.dart';
import 'package:notes/app/data/models/note_model/note.dart';
import 'package:notes/app/modules/home/Widgets/notes_grid.dart';
import '../Widgets/my_appbar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  final List<Note> children = const [
    Note(
        title: 'There is no one who loves pain itself',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sed est iaculis, tincidunt metus et, interdum justo. Nam quis ex vitae velit laoreet accumsan vitae ac lectus. Duis laoreet gravida nulla, ut gravida eros vulputate eu. Praesent interdum, elit vel imperdiet gravida, nulla ligula lacinia lectus, dictum faucibus lorem lacus vitae lorem. Cras venenatis sem a orci pharetra, in aliquet velit eleifend. Quisque libero lectus, suscipit vel nulla non, scelerisque auctor ipsum. Etiam turpis eros, gravida vel elementum id, pharetra at nulla. Fusce efficitur neque quis lacus faucibus ultricies. Nunc vehicula libero mi, vel feugiat nibh viverra quis. Ut mattis nunc ipsum, non placerat sapien varius eu. Donec bibendum dui nec ligula imperdiet facilisis.',
        color: Colors.grey),
    Note(
        text:
            'Etiam turpis eros, gravida vel elementum id, pharetra at nulla. Fusce efficitur neque quis lacus faucibus ultricies.',
        color: Colors.blueGrey),
    Note(
        text:
            'Etiam turpis eros, gravida vel elementum id, pharetra at nulla. Fusce efficitur neque quis lacus faucibus ultricies.',
        color: Colors.brown),
    Note(
        title: 'There is no one who loves pain itself',
        text:
            'Etiam turpis eros, gravida vel elementum id, pharetra at nulla. Fusce efficitur neque quis lacus faucibus ultricies.',
        color: Colors.lightBlue),
    Note(
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sed est iaculis, tincidunt metus et, interdum justo. Nam quis ex vitae velit laoreet accumsan vitae ac lectus. Duis laoreet gravida nulla',
        color: Colors.indigo),
    Note(
        text:
            'Etiam turpis eros, gravida vel elementum id, pharetra at nulla. Fusce efficitur neque quis lacus faucibus ultricies.',
        color: Colors.indigoAccent),
    Note(
        title: 'There is no one who loves pain itself',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sed est iaculis, tincidunt metus et, interdum justo. Nam quis ex vitae velit laoreet accumsan vitae ac lectus. Duis laoreet gravida nulla, ut gravida eros vulputate eu. Praesent interdum, elit vel imperdiet gravida, nulla ligula lacinia lectus, dictum faucibus lorem lacus vitae lorem. Cras venenatis sem a orci pharetra, in aliquet velit eleifend. Quisque libero lectus, suscipit vel nulla non, scelerisque auctor ipsum. Etiam turpis eros, gravida vel elementum id, pharetra at nulla. Fusce efficitur neque quis lacus faucibus ultricies. Nunc vehicula libero mi, vel feugiat nibh viverra quis. Ut mattis nunc ipsum, non placerat sapien varius eu. Donec bibendum dui nec ligula imperdiet facilisis.',
        color: Colors.grey),
    Note(
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sed est iaculis, tincidunt metus et, interdum justo. Nam quis ex vitae velit laoreet accumsan vitae ac lectus. Duis laoreet gravida nulla',
        color: Colors.indigo),
    Note(
        text:
            'Etiam turpis eros, gravida vel elementum id, pharetra at nulla. Fusce efficitur neque quis lacus faucibus ultricies.',
        color: Colors.indigoAccent),
    Note(
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sed est iaculis, tincidunt metus et, interdum justo. Nam quis ex vitae velit laoreet accumsan vitae ac lectus. Duis laoreet gravida nulla',
        color: Colors.lime),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const MyAppBar(),
          Expanded(child: NotesGrid(crossAxis: 2, children: children)),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60.h,
        width: 60.h,
        child: FittedBox(
          child: Container(
            margin: const EdgeInsets.all(4),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: ColorManager.appBar,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Icon(
                Icons.add,
                color: ColorManager.icon,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.check_box,
          Icons.draw,
          Icons.mic,
          Icons.add_a_photo
        ],
        activeIndex: 1,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor: ColorManager.appBar,
        inactiveColor: ColorManager.icon,
        activeColor: ColorManager.icon,
        onTap: (i) {},
        // onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}
