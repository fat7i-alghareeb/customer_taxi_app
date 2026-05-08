import 'package:flutter/foundation.dart';

// Blue text
void printB(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[34m[printing] $msg\x1B[0m');
}

// Green text
void printG(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[32m[printing] $msg\x1B[0m');
}

// Yellow text
void printY(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[33m[printing] $msg\x1B[0m');
}

// Red text
void printR(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[31m[printing] $msg\x1B[0m');
}

// white text
void printW(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[37m[printing] $msg\x1B[0m');
}

// cyan text
void printC(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[36m[printing] $msg\x1B[0m');
}

// black text
void printK(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[30m[printing] $msg\x1B[0m');
}

// Additional colors and bright variants
// Magenta text
void printM(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[35m[printing] $msg\x1B[0m');
}

// Light/Bright variants
void printLR(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[91m[printing] $msg\x1B[0m');
}

void printLG(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[92m[printing] $msg\x1B[0m');
}

void printLY(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[93m[printing] $msg\x1B[0m');
}

void printLB(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[94m[printing] $msg\x1B[0m');
}

void printLM(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[95m[printing] $msg\x1B[0m');
}

void printLC(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[96m[printing] $msg\x1B[0m');
}

void printLW(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[97m[printing] $msg\x1B[0m');
}

// Gray (bright black)
void printGray(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[90m[printing] $msg\x1B[0m');
}

void printO(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[38;5;208m[printing] $msg\x1B[0m');
}

void printP(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[38;5;13m[printing] $msg\x1B[0m');
}

void printPink(Object? msg) {
  if (kDebugMode) debugPrint('\x1B[38;5;205m[printing] $msg\x1B[0m');
}
