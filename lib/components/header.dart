import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mystocks_ui/constants/style.dart';


class Header extends StatefulWidget {
  final String userId;

  Header({Key? key, required this.userId}) : super(key: key);

  @override
  _Header createState() => _Header(userId: userId);
}


class _Header extends State<Header> {
  String userId;

  _Header({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headline6,
        ),
        Spacer(flex: 2,),
        Expanded(
          child: SearchField(),
        ),
        ProfileCard(userId: userId)
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String userId;

  ProfileCard({
    Key? key, required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2
            ),
            child: Text(userId),
          )
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
            const BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              margin: EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset("icons/Search.svg"),
            ),
          )
      ),
    );
  }
}