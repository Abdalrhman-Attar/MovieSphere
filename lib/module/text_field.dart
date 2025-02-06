import 'package:flutter/material.dart';
import 'package:movie_sphere/common/controllers.dart';
import 'package:movie_sphere/common/my_icons.dart';
import 'package:movie_sphere/module/dynamic_icon_viewer.dart';

Widget globalTextFormField({
  String? identifier,
  String? label,
  required String hint,
  required TextEditingController controller,
  required String validateText,
  required TextInputType keyboardType,
  String initialValue = '',
  required bool enabled,
  required int maxLength,
  required String? icon,
  Function(String)? onChanged,
  String? infoLable,
  String infoLableTitle = '',
  void Function()? onInfoLableTap,
  required void Function(PointerDownEvent)? onTapOutside,
  required void Function(String)? onFieldSubmitted,
  void Function()? onTap,
  bool? isObscure,
  bool alignmentIsEditable = true,
  inputFormatters,
  TextInputAction? textInputAction,
  required Color mainColor,
  bool? isIconTapable,
  void Function()? onIconTap,
}) {
  bool? localIsObscure = isObscure;

  if (controller.text.isEmpty) {
    controller.text = initialValue;
  }

  TextAlign textAlign = TextAlign.left;

  return StatefulBuilder(builder: (context, setState) {
    void updateTextDirection() {
      final text = controller.text;
      if (text.isNotEmpty) {
        final firstChar = text.characters.first;
        if (RegExp(r'^[\u0600-\u06FF]').hasMatch(firstChar)) {
          setState(() {
            textAlign = TextAlign.right;
          });
        } else {
          setState(() {
            textAlign = TextAlign.left;
          });
        }
      }
    }

    controller.addListener(updateTextDirection);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (identifier != null)
                Text(
                  identifier,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              if (infoLable != null)
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: onInfoLableTap,
                  child: const Icon(
                    Icons.info,
                  ),
                ),
            ],
          ),
        ),
        if (identifier != null) const SizedBox(height: 10),
        TextFormField(
          textInputAction: textInputAction,
          onTapOutside: onTapOutside,
          onTap: onTap ?? () {},
          enabled: enabled,
          onChanged: (value) {
            onChanged?.call(value);
            setState(() {
// Update validity on change
            });
          },
          onFieldSubmitted: onFieldSubmitted,
          controller: controller,
          autofocus: false,
          maxLength: maxLength,
          buildCounter: (
            BuildContext context, {
            int? currentLength,
            int? maxLength,
            bool? isFocused,
          }) =>
              null,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              setState(() {
// Mark input as invalid
              });
              return validateText;
            }
            setState(() {
// Mark input as valid
            });
            return null;
          },
          textAlign: alignmentIsEditable
              ? textAlign
              : Controllers.locale.appLocale.value.languageCode == 'ar'
                  ? TextAlign.right
                  : TextAlign.left,
          autocorrect: false,
          obscureText: localIsObscure ?? false,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              borderSide: BorderSide(
                color: mainColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              borderSide: BorderSide(
                color: mainColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              borderSide: BorderSide(
                color: mainColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              // Added for disabled state
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              borderSide: BorderSide(
                color: mainColor.withOpacity(0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              // Added for focused error state
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            errorBorder: OutlineInputBorder(
              // Added for error state
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            labelStyle: TextStyle(
              color: mainColor.withOpacity(0.5),
              fontSize: 14,
            ),
            hintStyle: TextStyle(
              color: mainColor.withOpacity(0.5),
              fontSize: 14,
            ),
            suffixIcon: isObscure ?? false
                ? IconButton(
                    icon: DynamicIconViewer(
                      filePath: localIsObscure ?? false ? MyIcons.passwordHide : MyIcons.passwordShow,
                      size: 20,
                      color: mainColor,
                    ),
                    onPressed: () {
                      setState(() {
                        localIsObscure = !localIsObscure!;
                      });
                    },
                  )
                : IconButton(
                    icon: DynamicIconViewer(
                      filePath: icon ?? '',
                      size: 20,
                      color: mainColor,
                    ),
                    onPressed: () {
                      if (isIconTapable ?? false) {
                        onIconTap?.call();
                      }
                    },
                  ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
          ),
        ),
      ],
    );
  });
}
