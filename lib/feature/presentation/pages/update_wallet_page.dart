import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/presentation/cubit/wallet/wallet_cubit.dart';

class UpdateWalletPage extends StatefulWidget {
  final WalletEntity walletEntity;

  const UpdateWalletPage({Key? key, required this.walletEntity})
      : super(key: key);

  @override
  _UpdateWalletPageState createState() => _UpdateWalletPageState();
}

class _UpdateWalletPageState extends State<UpdateWalletPage> {
  int amounts = 0;
  late int count;

  late List<dynamic> history;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billetera ${(widget.walletEntity.walletId).hashCode}"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} ",
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Nombre de tu billetera : ${widget.walletEntity.walletName}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Saldo actual \$ ${widget.walletEntity.amount}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "Historial de movimientos",
              style: TextStyle(fontSize: 16),
            )),
            _historyBox(context),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _btnAddMoney("Agregar +100 de saldo", 100),
                _btnAddMoney("Gastar -50 de saldo", -50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.yellow,
        height: 400,
        child: ListView.builder(
          itemCount: widget.walletEntity.history?.length ?? 0,
          itemBuilder: (context, index) {
            var amount = widget.walletEntity.history![index];
            return Card(
              color: Colors.white38,
              child: ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Fecha movimiento : ${DateFormat("dd MMM hh:mm a").format((amount["time"]).toDate())}"),
                    Text("Valor movimiento \$ ${amount["amount"]}"),
                  ],
                ),
                title: Text("movimiento # ${index}"),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _btnAddMoney(String title, int cant) {
    amounts = widget.walletEntity.amount ?? 0;
    return ElevatedButton(
        onPressed: () {
          amounts = amounts + cant;
          _submitUpdateWallet(amounts);
        },
        child: Text("$title"));
  }

  void _submitUpdateWallet([amount]) async {
    var time = Timestamp.now();
    Map<dynamic, dynamic> histories = {"time": time, "amount": amount};
    history = widget.walletEntity.history ?? [];
    count = widget.walletEntity.count ?? 0;
    history.add(histories);
    BlocProvider.of<WalletCubit>(context).updateWallet(
      wallet: WalletEntity(
        walletId: widget.walletEntity.walletId,
        time: Timestamp.now(),
        uid: widget.walletEntity.uid,
        amount: amount,
        count: count + 1,
        history: history,
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
