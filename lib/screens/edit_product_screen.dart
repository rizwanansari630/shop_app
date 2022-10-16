import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product-screen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var _editedProduct =
      Product(id: null, title: '', price: 0, imageUrl: '', description: '');
  var _initialValues = {
    'title': '',
    'price': '',
    'imageUrl': '',
    'description': ''
  };

  // global key is needed to access the forms
  final _form = GlobalKey<FormState>();
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      print('product id $productId');
     if(productId != null){
       _editedProduct =
       Provider.of<Products>(context).findProductById(productId);
     }
      if (_editedProduct.id != null) {
        _initialValues ={
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'imageUrl': _editedProduct.imageUrl,
          'description': _editedProduct.description
        };
        _imageUrlController.text = _initialValues['imageUrl'];
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // to dispose focus node when leaving the screen other wise memory leaks
    _priceFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.endsWith('png')) {
        return;
      }
      setState(() {
        print("in state");
      });
    }
  }

  // submit form
  void _saveForm() {
    // this will calls the onSave method of every field, do your stuff in on save of your field.
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print("save ${_editedProduct.id}");
    if(_editedProduct.id != null){
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct);
    }
    else{
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    child: TextFormField(
                      initialValue: _initialValues['title'],
                      decoration: InputDecoration(
                        label: Text('Title'),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the title.'; // if value is not valid return your error message
                        }
                        return null; //if the validations are fullfilled return null
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            title: value,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            description: _editedProduct.description);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    child: TextFormField(
                          initialValue: _initialValues['price'],
                        decoration: InputDecoration(
                          label: Text('Price'),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the Price.'; // if value is not valid return your error message
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number.';
                          }
                          if (double.parse(value) < 10) {
                            return 'Minimum price should be greater then 10';
                          }
                          return null; //if the validations are fullfilled return null
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              title: _editedProduct.title,
                              price: double.parse(value),
                              imageUrl: _editedProduct.imageUrl,
                              description: _editedProduct.description);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    child: TextFormField(
                      initialValue: _initialValues['description'],
                        decoration: InputDecoration(
                          label: Text('Description'),
                        ),
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter product Description.';
                          }
                          if (value.length < 10) {
                            return 'Description should contain atleast 10 chars.';
                          }
                          return null;
                        },
                        maxLines: 5,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                              description: value);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                              decoration: InputDecoration(
                                label: Text('Image URL'),
                              ),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onEditingComplete: () {
                                setState(() {});
                              },
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    title: _editedProduct.title,
                                    price: _editedProduct.price,
                                    imageUrl: value,
                                    description: _editedProduct.description);
                              }),
                        ),
                        Container(
                          height: 75,
                          width: 75,
                          margin: EdgeInsets.only(top: 5, left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.brown,
                                  style: BorderStyle.solid)),
                          child: _imageUrlController.text.isEmpty
                              ? Text('No Image URL !!')
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.contain),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}
