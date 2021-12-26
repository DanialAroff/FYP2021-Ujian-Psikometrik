import 'package:flutter/material.dart';
import 'appcolors.dart';

const String mainFont = 'Nunito Sans';

const emailInputDecoration = InputDecoration(
  prefixIcon: Icon(
    Icons.email_outlined,
    color: AppColors.gray,
  ),
  isCollapsed: true,
  labelText: 'Kata Laluan',
  floatingLabelBehavior: FloatingLabelBehavior.never,
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.primary,
    ),
  ),
);
const passwordInputDecoration = InputDecoration(
  prefixIcon: Icon(
    Icons.password_outlined,
    color: AppColors.gray,
  ),
  isCollapsed: true,
  labelText: 'Kata Laluan',
  floatingLabelBehavior: FloatingLabelBehavior.never,
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.primary,
    ),
  ),
);
