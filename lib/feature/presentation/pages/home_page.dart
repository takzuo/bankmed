import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bankmed/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:bankmed/feature/presentation/cubit/wallet/wallet_cubit.dart';

import '../../../app_const.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<WalletCubit>(context).getWallet(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenido a tu cuenta BankMed",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).loggedOut();
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, PageConst.addWalletPage,
              arguments: widget.uid);
        },
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, walletState) {
          if (walletState is WalletLoaded) {
            return _bodyWidget(walletState);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _noWalletsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 80, child: Image.asset('assets/images/logo4.png')),
          SizedBox(
            height: 10,
          ),
          Text("Aun no tienes billeteras activas"),
        ],
      ),
    );
  }

  Widget _bodyWidget(WalletLoaded walletLoadedState) {
    return Column(
      children: [
        Expanded(
          child: walletLoadedState.wallets.isEmpty
              ? _noWalletsWidget()
              : GridView.builder(
                  itemCount: walletLoadedState.wallets.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 3),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.UpdateWalletPage,
                            arguments: walletLoadedState.wallets[index]);
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Borrar billetera"),
                              content: Text(
                                  "Esta seguro que quiere borrar tu billetera?"),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Borrar",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<WalletCubit>(context)
                                        .deleteWallet(
                                            wallet: walletLoadedState
                                                .wallets[index]);
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "No",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(0, 1.5))
                            ]),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nombre de la billetera -> ${walletLoadedState.wallets[index].walletName}",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Numero de cuenta : ${(walletLoadedState.wallets[index].walletId).hashCode}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Saldo  ${walletLoadedState.wallets[index].amount}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                                "Ultimo movimiento ${DateFormat("dd MMM yyy hh:mm a").format(walletLoadedState.wallets[index].time!.toDate())}")
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
