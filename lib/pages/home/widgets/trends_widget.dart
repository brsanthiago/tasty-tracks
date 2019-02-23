import 'package:flutter/material.dart';

class TrendsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TrendsWidgetState();
  }
}

class TrendsWidgetState extends State<TrendsWidget> {
  @override
  void initState() {
    super.initState();
    // TODO Fetch trends data
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Trends',
              style: theme.textTheme.title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Text(
                'No trends to show yet!',
                style: theme.textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
