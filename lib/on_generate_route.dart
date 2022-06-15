import 'package:flutter/material.dart';
import 'package:bankmed/app_const.dart';
import 'package:bankmed/feature/presentation/pages/sign_in_page.dart';

import 'feature/domain/entities/wallet_entity.dart';
import 'feature/presentation/pages/add_new_wallet_page.dart';
import 'feature/presentation/pages/sign_up_page.dart';
import 'feature/presentation/pages/update_wallet_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage:
        {
          return materialBuilder(widget: SignInPage());
        }
      case PageConst.signUpPage:
        {
          return materialBuilder(widget: SignUpPage());
        }
      case PageConst.addWalletPage:
        {
          if (args is String) {
            return materialBuilder(
                widget: AddNewWalletPage(
              uid: args,
            ));
          } else {
            return materialBuilder(
              widget: ErrorPage(),
            );
          }
        }
      case PageConst.UpdateWalletPage:
        {
          if (args is WalletEntity) {
            return materialBuilder(
                widget: UpdateWalletPage(
              walletEntity: args,
            ));
          } else {
            return materialBuilder(
              widget: ErrorPage(),
            );
          }
        }
      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
