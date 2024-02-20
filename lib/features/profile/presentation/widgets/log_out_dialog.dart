import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/functions/clear_cache.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    Key? key,
    required this.media,
    required this.ctx,
  }) : super(key: key);

  final Size media;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: media.width * 0.6,
        child: const Text('Are you sure you wanna log out??'),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            ClearCache.clearAllLocalData();
            Navigator.of(context).pop();
            BlocProvider.of<AuthBloc>(ctx).add(SignOutEvent());
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
          child: Text(
            'Yoss',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text(
            'No',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
