import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'number_series_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => NumberSeriesBloc(NumberSeries()),
        child: NumberSeriesPage(),
      ),
    );
  }
}

class NumberSeriesPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  NumberSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final numberSeriesBloc = BlocProvider.of<NumberSeriesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deret Angka'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter N',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final N = int.tryParse(_controller.text);
                    if (N != null) {
                      numberSeriesBloc.add(GenerateSeries1ToN(N));
                    }
                  },
                  child: const Text('Point 1 = 1->N'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final N = int.tryParse(_controller.text);
                    if (N != null) {
                      numberSeriesBloc.add(GenerateSeries1ToNTo1(N));
                    }
                  },
                  child: const Text('Point 2 = 1->N->1'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final N = int.tryParse(_controller.text);
                    if (N != null) {
                      numberSeriesBloc.add(GenerateSpecialSeries(N));
                    }
                  },
                  child: const Text('Point 3 = Special'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final N = int.tryParse(_controller.text);
                    if (N != null) {
                      numberSeriesBloc.add(GenerateSeriesWithReplacements(N));
                    }
                  },
                  child: const Text('Point 4 = Replace'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Result:'),
            BlocBuilder<NumberSeriesBloc, NumberSeriesState>(
              builder: (context, state) {
                if (state is NumberSeriesLoading) {
                  return const CircularProgressIndicator();
                } else if (state is NumberSeriesLoaded) {
                  return Text(state.series);
                } else if (state is NumberSeriesError) {
                  return Text(state.message);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
