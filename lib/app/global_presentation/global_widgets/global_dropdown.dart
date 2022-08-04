import '../../constants/exports.dart';

class PrimaryDropDown extends StatefulWidget {
     const PrimaryDropDown({
    Key? key,
    required this.items,
    required this.hint,
    required this.value,
  }) : super(key: key);

  final List<String> items;
  final String hint;
  final String value;
  @override
  State<PrimaryDropDown> createState() => _PrimaryDropDownState();
}

class _PrimaryDropDownState extends State<PrimaryDropDown> {
  late String dropDownValue;

  @override
  void initState() {
    dropDownValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        focusColor: ColorManager.primary,
        hintText: widget.hint,
        hintStyle: TextStyle(color: ColorManager.primary),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      ),
      child: DropdownButton(
          underline:    const SizedBox.shrink(),
          isExpanded: true,
          style: TextStyle(color: ColorManager.primary),
          hint: PrimaryText(
            widget.hint,
            color: ColorManager.fontColor,
            fontSize: 20,
          ),
          value: dropDownValue,
          borderRadius: BorderRadius.circular(8),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: ColorManager.grey2,
          ),
          items: widget.items.map((String itemValue) {
            return DropdownMenuItem(
              value: itemValue,
              child: PrimaryText(
                itemValue,
                color: ColorManager.fontColor,
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              dropDownValue = value!;
            });
          }),
    );
  }
}
