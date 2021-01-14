import 'package:attendance_application/src/widget/custom_dialog/custom_dialog.dart';
import 'package:attendance_application/src/widget/custom_dialog/download_failed.dart';
import 'package:attendance_application/src/widget/custom_dialog/process_dialog.dart';
import 'package:flutter/material.dart';
import 'package:attendance_application/src/widget/custom_dialog/loading_dialog.dart';

class PopDialog {
  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
            return LoadingDialog();
        }
    );
  }

  static showDownloadFailed(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DownloadFailed();
        }
    );
  }

  static showUpdateDialog(BuildContext context, Widget message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return message;
        }
    );
  }

  static showProcessDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProcessDialog();
        }
    );
  }

  static showBottomDialog(BuildContext context, Widget message) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return message;
        }
    );
  }

  static showLoginFailed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          color: Colors.red,
          title: 'Login Gagal',
          text: 'Akun anda tidak terdaftar',
        );
      }
    );
  }

  static showNoInternetConnection(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            color: Colors.red,
            title: 'Gagal',
            text: 'Mohon periksa konseksi anda',
          );
        }
    );
  }

  static showEmployeeNotFound(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            color: Colors.red,
            title: 'Invalid ID',
            text: 'QR Code ID tidak ditemukan',
          );
        }
    );
  }

  static showSubmitToLocalSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            color: Colors.green,
            title: 'Berhasil',
            text: 'Anda tidak terhubung ke server, untuk sementara data masuk ke local db',
          );
        }
    );
  }

  static showUpdateSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            color: Colors.green,
            title: 'Berhasil',
            text: 'Data karyawan berhasil diperbarui',
          );
        }
    );
  }
}