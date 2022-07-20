import 'package:notes/app/constants/exports.dart';

class SearchBar extends StatelessWidget {
  final Function(String)? onSearch;
  SearchBar({Key? key, this.onSearch}) : super(key: key);
  final controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: ColorManager.grey.withOpacity(0.4))),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                onSearch?.call(controller.text);
              },
              child: SvgPicture.string(
                '<svg viewBox="26.0 21.0 14.0 14.0" ><path transform="translate(26.0, 21.0)" d="M 13.17335224151611 13.99917030334473 C 12.94834232330322 13.99915981292725 12.73020267486572 13.90579986572266 12.57488250732422 13.74304008483887 L 8.745382308959961 9.911740303039551 L 8.741782188415527 9.914449691772461 C 7.804052352905273 10.60919952392578 6.69030237197876 10.97644996643066 5.520932674407959 10.97649002075195 L 5.499982357025146 10.97644996643066 C 4.033082485198975 10.96774005889893 2.654342889785767 10.39120960235596 1.617722749710083 9.353070259094238 C 0.5811027884483337 8.314919471740723 0.006612794008105993 6.93533992767334 8.279417670564726e-05 5.468440055847168 C -0.007967205718159676 4.025739669799805 0.5713428258895874 2.613869905471802 1.58948278427124 1.594850063323975 C 2.602132797241211 0.5813000202178955 4.004412651062012 0 5.436752796173096 0 L 5.460382461547852 4.999999873689376e-05 C 6.927362442016602 0.008750000037252903 8.306112289428711 0.5851500034332275 9.342642784118652 1.623070001602173 C 10.37926292419434 2.661089897155762 10.9537525177002 4.040800094604492 10.96028232574463 5.508039951324463 C 10.96572303771973 6.677799701690674 10.60253238677979 7.795380115509033 9.909982681274414 8.739950180053711 L 13.74308300018311 12.57394027709961 C 13.96075248718262 12.7808198928833 14.04904270172119 13.08981990814209 13.97348213195801 13.38033962249756 C 13.89881229400635 13.67004013061523 13.6718921661377 13.89696025848389 13.38128280639648 13.97254943847656 C 13.31333255767822 13.99020957946777 13.24338245391846 13.99917030334473 13.17335224151611 13.99917030334473 Z M 5.44376277923584 1.098000049591064 C 4.298322677612305 1.098039984703064 3.177242755889893 1.563210010528564 2.367982864379883 2.374239921569824 C 1.553542852401733 3.189579963684082 1.090022802352905 4.318679809570312 1.096282839775085 5.472039699554443 C 1.101502776145935 6.645549774169922 1.56112277507782 7.74921989440918 2.390482902526855 8.579739570617676 C 3.219812870025635 9.410249710083008 4.322842597961426 9.871469497680664 5.496382713317871 9.878449440002441 L 5.513262748718262 9.878469467163086 C 6.660182476043701 9.878509521484375 7.782482624053955 9.413020133972168 8.592382431030273 8.601340293884277 C 9.406822204589844 7.786890029907227 9.870342254638672 6.657789707183838 9.864082336425781 5.5035400390625 C 9.85886287689209 4.329999923706055 9.399242401123047 3.226369857788086 8.569882392883301 2.395959854125977 C 7.740492343902588 1.565520048141479 6.637462615966797 1.104580044746399 5.463982582092285 1.098039984703064 L 5.44376277923584 1.098000049591064 Z" fill="#000000" fill-opacity="0.36" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: TextField(
                  controller: controller,
                  onSubmitted: (txt) {
                    onSearch?.call(txt);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle: const TextStyle(
                        fontFamily: FontConstants.fontFamily,
                        fontSize: 17,
                        color: Color(0x66000000),
                        letterSpacing: -0.41000000190734864,
                        height: 1.2941176470588236,
                      ),
                      hintText: "Search".tr,
                      filled: false)),
            ),
          ],
        ));
  }
}
