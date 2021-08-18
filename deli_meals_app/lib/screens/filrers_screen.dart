import 'package:deli_meals_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routName = '/filters-screen';
  final Function setFilters;
  final Map<String, bool>? currentFilters;
  FiltersScreen(this.currentFilters, this.setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters!['gluten']!;
    _lactoseFree = widget.currentFilters!['lactose']!;
    _vegetarian = widget.currentFilters!['vegetarian']!;
    _vegan = widget.currentFilters!['vegan']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.setFilters(selectedFilters);
            },
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Adjust Your Meal Selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: Text('Gluten Meal'),
                  subtitle: Text('Only include gluten-free meals'),
                  value: _glutenFree,
                  onChanged: (newVal) {
                    setState(
                      () {
                        _glutenFree = newVal;
                      },
                    );
                  },
                ),
                SwitchListTile(
                  title: Text('Lactose Meal'),
                  subtitle: Text('Only include lactose-free meals'),
                  value: _lactoseFree,
                  onChanged: (newVal) {
                    setState(
                      () {
                        _lactoseFree = newVal;
                      },
                    );
                  },
                ),
                SwitchListTile(
                  title: Text('Vegan'),
                  subtitle: Text('Only include vegan meals'),
                  value: _vegan,
                  onChanged: (newVal) {
                    setState(
                      () {
                        _vegan = newVal;
                      },
                    );
                  },
                ),
                SwitchListTile(
                  title: Text('Vegetarian'),
                  subtitle: Text('Only include vegetarian meals'),
                  value: _vegetarian,
                  onChanged: (newVal) {
                    setState(
                      () {
                        _vegetarian = newVal;
                      },
                    );
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
