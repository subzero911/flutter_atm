import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/core/app_colors.dart';
import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';

class AtmListBuilder extends StatelessWidget {
  final String categoryName;

  final List<BankCell> items;

  const AtmListBuilder({@required this.categoryName, @required this.items})
      : assert(categoryName != null, items != null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Card(
          color: AppColors.white,
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.gray,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 7,
                children: List.generate(
                  items.length, (index) => _buildListItem(items[index]),
                ),
              )
            ],
          ),
        ),
      bottom: false,
    );
  }

  Widget _buildListItem(BankCell cell) {
    return Text(
      cell.toString(),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
