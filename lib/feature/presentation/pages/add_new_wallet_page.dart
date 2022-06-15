import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/presentation/cubit/wallet/wallet_cubit.dart';
import 'package:bankmed/feature/presentation/widgets/common.dart';

class AddNewWalletPage extends StatefulWidget {
  final String uid;

  const AddNewWalletPage({Key? key, required this.uid}) : super(key: key);

  @override
  _AddNewWalletPageState createState() => _AddNewWalletPageState();
}

class _AddNewWalletPageState extends State<AddNewWalletPage> {
  TextEditingController _nameWalletTextController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _nameWalletTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameWalletTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: Text("Billetera"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_nameWalletTextController.text.length} Characters",
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
            ),
            Expanded(
              child: Scrollbar(
                child: TextFormField(
                  controller: _nameWalletTextController,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nombre de tu billetera"),
                ),
              ),
            ),
            InkWell(
              onTap: _submitNewWallet,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Crear billetera",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitNewWallet() {
    if (_nameWalletTextController.text.isEmpty) {
      snackBarError(
          scaffoldState: _scaffoldStateKey,
          msg: "Por favor colocar un nombre a tu billetera");
      return;
    }
    BlocProvider.of<WalletCubit>(context).addWallet(
      wallet: WalletEntity(
        walletName: _nameWalletTextController.text,
        time: Timestamp.now(),
        uid: widget.uid,
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
