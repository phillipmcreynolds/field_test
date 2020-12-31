import 'package:field_test/helpers/size_helpers.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormWidgetState();

}

class _FormWidgetState extends State<FormWidget> {
  String _keywords, _keywords_display = "";
  String _type, _type_display = "";
  String _state, _state_display = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildKeywordsField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Keywords'),
        onSaved: (String value) {
          _keywords = value;
          print(_keywords + "saved");
        }
    );
  }

  Widget _buildTypeField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Type'),
        onSaved: (String value) {
          _type = value;
          print(_type + "saved");
        }
    );
  }

  Widget _buildStateField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'State'),
        onSaved: (String value) {
          _state = value;
          print(_state + "saved");
        }
    );
  }

  void _update() {
    print("update called");
    setState(() {
      _keywords_display = _keywords;
      _type_display = _type;
      _state_display = _state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Form Widget",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildKeywordsField(),
                            _buildTypeField(),
                            _buildStateField(),
                            SizedBox(height: 15),
                            RaisedButton(
                                child: Text(
                                  'Search',
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () => {
                                  _formKey.currentState.save(),
                                  _update(),
                                })
                          ])),
                  Container(
                    width: displayWidth(context) * .95,
                    height: displayHeight(context) * .75,
                    child: Builder(builder: (_) {
                      return ListView.separated(
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: Colors.orange),
                        itemBuilder: (_, index) {
                          return ListTile(
                            isThreeLine: true,
                            title: Text(
                              "Keywords: " + _keywords_display,
                              style:
                              TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            subtitle: Text(
                              "Type: " +
                                  _type_display +
                                  "\nState: " +
                                  _state_display,
                              maxLines: 2,
                            ),
                          );
                        },
                        itemCount: 1,
                      );
                    }),
                  )
                ])));
  }
}