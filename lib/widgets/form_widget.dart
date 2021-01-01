import 'dart:core';

import 'package:field_test/helpers/size_helpers.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormWidgetState();

}

class BreweryType {
  int id;
  String name;

  BreweryType(this.id, this.name);

  static List<BreweryType> getBreweryTypes() {
    return <BreweryType>[
      BreweryType(0, ""),
      BreweryType(1, "Brewpub"),
      BreweryType(2, "MicroBrewery"),
      BreweryType(3, "Contract"),
      BreweryType(4, "Regional"),
    ];
  }
}

class _FormWidgetState extends State<FormWidget> {
  String _keywords, _keywordsDisplay = "";
  String _type, _typeDisplay = "";
  String _state, _stateDisplay = "";

  List<BreweryType> _breweryTypes = BreweryType.getBreweryTypes();
  List<DropdownMenuItem<BreweryType>> _dropDownMenuItems;
  BreweryType _selectedType;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode focusNode;


  @override
  void initState() {
    focusNode = FocusNode();
    _dropDownMenuItems = buildDropDownMenuItems(_breweryTypes);
    _selectedType = _dropDownMenuItems[0].value;
    super.initState();

  }

  List<DropdownMenuItem<BreweryType>> buildDropDownMenuItems(List breweryTypes) {
    List<DropdownMenuItem<BreweryType>> types = [];
    for(BreweryType breweryType in _breweryTypes) {
      types.add(DropdownMenuItem(
        value: breweryType,
        child: Text(breweryType.name),
      ),
      );
    }
    return types;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildKeywordsField() {
    return TextFormField(
      autofocus: true,
      focusNode: focusNode,
      decoration: InputDecoration(labelText: 'Keywords'),
      onSaved: (String value) {
        _keywords = value;
        print(_keywords + "saved");
      }
    );
  }

  Widget _buildTypeField() {
    return DropdownButton(
      value: _selectedType,
      items: _dropDownMenuItems,
      hint: Text("Brewery Type"), // doesn't do anything afaict
      onChanged: onChangeDropdownItem,
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
      _keywordsDisplay = _keywords;
      _typeDisplay = _selectedType.name;
      _stateDisplay = _state;
    });
  }

  onChangeDropdownItem (BreweryType selected) {
    setState(() {
      _selectedType = selected;
    }
    );
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
                  Container(
                      margin: EdgeInsets.all(24),
                      child:
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
                                      FocusScope.of(context).requestFocus(focusNode),
                                    })
                              ])
                      ),
                  ),
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
                              "Keywords: " + _keywordsDisplay,
                              style:
                              TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            subtitle: Text(
                              "Type: " +
                                  _typeDisplay +
                                  "\nState: " +
                                  _stateDisplay,
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

