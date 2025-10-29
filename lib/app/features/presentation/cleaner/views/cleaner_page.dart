import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';
import 'package:water_eject/app/features/presentation/cleaner/views/cleaner_view.dart';
import 'package:water_eject/core/di/locator.dart';

class CleanerPage extends StatelessWidget {
  const CleanerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ✅ get_it’ten cubit al ve init’i burada tetikle
      create: (_) => sl<CleanerCubit>()..init(),
      child: const CleanerView(),
    );
  }
}
