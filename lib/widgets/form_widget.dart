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
      BreweryType(0, "Brewery Type"),
      BreweryType(1, "Brewpub"),
      BreweryType(2, "MicroBrewery"),
      BreweryType(3, "Contract"),
      BreweryType(4, "Regional"),
    ];
  }
}

class BreweryState {
  int id;
  String name;

  BreweryState(this.id, this.name);

  static List<BreweryState> getBreweryStates() {
    return <BreweryState>[
      BreweryState(0, "Brewery State"),
      BreweryState(1, "Alaska"),
      BreweryState(2, "Alabama"),
      BreweryState(3, "Florida"),
      BreweryState(4, "Georgia"),
    ];
  }
}

class _FormWidgetState extends State<FormWidget> {
  String _keywords, _keywordsDisplay = "";
  String _typeDisplay = "";
  String  _stateDisplay = "";
  bool _andSearch = false;

  List<BreweryType> _breweryTypes = BreweryType.getBreweryTypes();
  List<DropdownMenuItem<BreweryType>> _typeDropDownMenuItems;
  BreweryType _selectedType;
  List<BreweryState> _breweryStates = BreweryState.getBreweryStates();
  List<DropdownMenuItem<BreweryState>> _stateDropDownMenuItems;
  BreweryState _selectedState;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode focusNode;


  @override
  void initState() {
    focusNode = FocusNode();
    _typeDropDownMenuItems = buildTypeDropDownMenuItems(_breweryTypes);
    _selectedType = _typeDropDownMenuItems[0].value;
    _stateDropDownMenuItems = buildStateDropDownMenuItems(_breweryStates);
    _selectedState = _stateDropDownMenuItems[0].value;
    super.initState();

  }

  List<DropdownMenuItem<BreweryType>> buildTypeDropDownMenuItems(List breweryTypes) {
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

  List<DropdownMenuItem<BreweryState>> buildStateDropDownMenuItems(List breweryStates) {
    List<DropdownMenuItem<BreweryState>> states = [];
    for(BreweryState breweryState in _breweryStates) {
      states.add(DropdownMenuItem(
        value: breweryState,
        child: Text(breweryState.name),
      ),
      );
    }
    return states;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildSearchTypeRadio() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Search:'),
            Radio(
              value: true,
              groupValue: _andSearch,
              onChanged: (bool value) {
                setState(() {
                  _andSearch = value;
                });
              },
            ),
            Text('AND'),
            Radio(
              value: false,
              groupValue: _andSearch,
              onChanged: (bool value) {
                setState(() {
                  _andSearch = value;
                });
              },
            ),
            Text('OR'),
          ]
        )
      ]
    );
  }

  Widget _buildKeywordsField() {
    return Container(
      width: 300,
      child: TextFormField(
          autofocus: true,
          focusNode: focusNode,
          decoration: InputDecoration(labelText: 'Keywords'),
          onSaved: (String value) {
            _keywords = value;
            print(_keywords + "saved");
          }
      )
    );
  }

  Widget _buildTypeField() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.orange,
        border: Border.all(
          color: Colors.white,
        )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          style: new TextStyle(color: Colors.white),
          value: _selectedType,
          items: _typeDropDownMenuItems,
          hint: Text("Brewery Type"), // doesn't do anything afaict
          onChanged: onChangeTypeDropdownItem,
          dropdownColor: Colors.orangeAccent,
        ),
      ),
      );
  }

  Widget _buildStateField() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.orange,
          border: Border.all(
            color: Colors.white,
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          style: new TextStyle(color: Colors.white),
          value: _selectedState,
          items: _stateDropDownMenuItems,
          hint: Text("Brewery State"), // doesn't do anything afaict
          onChanged: onChangeStateDropdownItem,
          dropdownColor: Colors.orangeAccent,
        ),
      ),
    );
  }


  void _update() {
    print("update called");
    setState(() {
      _keywordsDisplay = _keywords;
      // have to check this because I'm storing hte label as the first type
      if (_selectedType.id != 0) {
        _typeDisplay = _selectedType.name;
      } else {
        _typeDisplay = "";
      }
      if (_selectedState.id != 0) {
        _stateDisplay = _selectedState.name;
      } else {
        _stateDisplay = "";
      }
    });
  }

  onChangeTypeDropdownItem (BreweryType selected) {
    setState(() {
      _selectedType = selected;
    }
    );
  }

  onChangeStateDropdownItem (BreweryState selected) {
    setState(() {
      _selectedState = selected;
    }
    );
  }

  String searchTypeString() {
    return (_andSearch) ? "AND" : "OR";
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
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _buildKeywordsField(),
                                        _buildSearchTypeRadio(),
                                      ]
                                  )
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Spacer(),
                                        _buildStateField(),
                                        VerticalDivider(),
                                        _buildTypeField(),
                                        Spacer(),
                                      ]
                                  ),
                                ),
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
                              "Keywords: " + _keywordsDisplay +
                                  ", Search Type: " + searchTypeString(),
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

