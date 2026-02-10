import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Logbook After SRP"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Total Hitungan',
            ),
            Text(
              '${_controller.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () =>
                        setState(() => _controller.decrementCounter()),
                    icon: const Icon(Icons.arrow_back_rounded)),
                IconButton(
                    onPressed: () =>
                        setState(() => _controller.incrementCounter()),
                    icon: const Icon(Icons.arrow_forward_rounded)),
                IconButton(
                  onPressed: () async {
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Konfirmasi"),
                          content: const Text(
                              "Apakah Anda yakin ingin reset hitungan?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Batal"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Reset",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true && context.mounted) {
                      setState(() => _controller.resetCounter());

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Hitungan berhasil direset"),
                          backgroundColor: Colors.blue,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ],
            ),
            SizedBox(),
            const Text(
              "Total Step",
            ),
            Text(
              '${_controller.currentStep}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Slider(
                value: _controller.currentStep.toDouble(),
                min: 0,
                max: 10,
                divisions: 9,
                onChanged: (double newValue) {
                  setState(() => _controller.setStep(newValue.toInt()));
                }),
            Text("5 Riwayat Terakhir"),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.currentHistory.length > 5
                    ? 5
                    : _controller.currentHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                            leading: Icon(Icons.history),
                            title: Text(
                              _controller.currentHistory[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            tileColor: _controller
                                .colorTile(_controller.currentHistory[index]))
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() => _controller.incrementCounter()),
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
