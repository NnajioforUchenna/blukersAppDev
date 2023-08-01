import 'package:bulkers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InterestingWorkersTab extends StatelessWidget {
  const InterestingWorkersTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    cp.fetchInterestingWorkers();
    return cp.interestingWorkers.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: cp.interestingWorkers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text(cp.interestingWorkers.values.toList()[index].lastName),
                subtitle: Text(
                    cp.interestingWorkers.values.toList()[index].firstName),
              );
            },
          );
  }
}
