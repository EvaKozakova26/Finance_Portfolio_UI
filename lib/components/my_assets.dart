
import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/model/MyAssets.dart';

import 'asset_info_card.dart';

class MyAssets extends StatelessWidget {
  const MyAssets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My assets",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding
                    )
                ),
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("Add new")
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        GridView.builder(
            shrinkWrap: true,
            itemCount: mockMyAsset.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: defaultPadding,
              childAspectRatio: 2.5
            ),
            itemBuilder: (context, index) => AssetInfoCard(info: mockMyAsset[index],)
        )
      ],
    );
  }
}