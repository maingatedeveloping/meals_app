import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filter';
  final dynamic saveFilters;
  final Map<String, bool> currentFilters;
  Filters(this.saveFilters, this.currentFilters, {super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _isGlutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree =
      false; //this values wont be used any more when the user tap on the save button

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;

    // TODO: implement initState
    super.initState();
  } //the initstate will run imediately, when the currentFilters is ready

  Widget _buildSwitch(
    BuildContext context,
    String switchTitle,
    String subTitle,
    bool value,
    func,
  ) {
    return SwitchListTile(
      title: Text(
        switchTitle,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      value: value,
      onChanged: func,
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              Map<String, bool> selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Ajust your meal selection.',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitch(
                  context,
                  'Gluten-Free',
                  'Only include gluten-free meals.',
                  _isGlutenFree,
                  (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  },
                ),
                _buildSwitch(
                  context,
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitch(
                  context,
                  'Vegan',
                  'Only include Vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
                _buildSwitch(
                  context,
                  'Lactose-Free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
