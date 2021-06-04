import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/style.dart';

class PortfolioDetailsInfoCard extends StatelessWidget {
  const PortfolioDetailsInfoCard({
    Key? key,
    required this.title,
    required this.code,
    required this.percentage,
  }) : super(key: key);

  final String title, code;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: primaryColor.withOpacity(0.15),
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding)
          )
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 50,
            child: Text(code),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    /*Text(
                      "50%",
                      style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white70),
                    )*/
                  ],
                ),
              )
          ),
          Text("$percentage %")
        ],
      ),
    );
  }
}