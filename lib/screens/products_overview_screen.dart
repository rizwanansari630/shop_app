import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  All,
  Favorites,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
   // Provider.of<Products>(context).getProducts(); ofContext will not work here as the state is not initialized. work around below 2 options
   //option 1 is
   // Future.delayed(Duration.zero).then((_) {Provider.of<Products>(context).getProducts();});// basically it executed apter the init initailization of widget.
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // option 2 after initialization and before build method
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).getProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          Consumer<Cart>(
            builder: ((context, cartDate, ch) => Badge(
                child: ch, value: cartDate.cartCount.toString())),
            child: IconButton(icon: Icon(Icons.shopping_cart),onPressed: () => launchCartDetailScreen(context)),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert_sharp),
            onSelected: (FilterOptions selectedFilter) {
              setState(() {
                if (selectedFilter == FilterOptions.All) {
                  _showOnlyFavorites = false;
                } else {
                  _showOnlyFavorites = true;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: Text('Show Favorites'),
                value: FilterOptions.Favorites,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) :ProductsGrid(_showOnlyFavorites),
    );
  }

  launchCartDetailScreen(BuildContext context) {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }
}
