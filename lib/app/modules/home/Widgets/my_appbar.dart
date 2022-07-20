import '../../../constants/exports.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        InkWell(
          child: Container(
            width: Get.width,
            height: 50.w,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: ColorManager.appBar,
                borderRadius: BorderRadius.all(Radius.circular(24.w))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu,
                    size: 24.w,
                  ),
                  splashRadius: 24.w,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: PrimaryText(
                      'Search',
                      color: Colors.white,
                      fontSize: 14.h,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.grid_view_outlined,
                    size: 24.w,
                  ),
                  splashRadius: 24.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
