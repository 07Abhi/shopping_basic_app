import 'package:shopappstmg/providermanagment/productmanagement.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shopappstmg/models/productmodel.dart';
import 'package:shopappstmg/screens/editingscreen.dart';
import 'package:flutter/material.dart';

class EditingPage extends StatefulWidget {
  static const String id = 'editingpage';

  @override
  _EditingPageState createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusNodeprice = FocusNode();
  final _focusNodeDescription = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  /*we take init flag for one time run of the didChangeDependency*/
  var init = true;

  /*We make a map for the editing of the map or we can make instance of product class*/
  var _initFormdata = {
    'productName': '',
    'desc': '',
    'imageUrl': '',
    'price': ''
  };
  var _editedProduct =
      Product(productName: '', price: 0.0, id: null, imageUrl: '', desc: '');

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https') &&
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    bool isvalid = _formKey.currentState.validate();
    if (!isvalid) {
      return;
    }
    _formKey.currentState.save();
    print('what is id here ${_editedProduct.id}');
    if (_editedProduct.id != null) {
      print('inside the update section!!');
      Provider.of<ProductManagement>(
        context,
        listen: false,
      ).updateProductData(_editedProduct.id, _editedProduct);
    } else {
      print('inside the add section!!');
      Provider.of<ProductManagement>(context, listen: false)
          .addItem(_editedProduct);
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      String prodId = ModalRoute.of(context).settings.arguments;
      //checking the proId is present or not because it will run when we take the '+' too.
      if (prodId != null) {
        _editedProduct = Provider.of<ProductManagement>(context, listen: false)
            .getIntanceById(prodId);
        _initFormdata = {
          'productName': _editedProduct.productName,
          'desc': _editedProduct.desc,
          'imageUrl': '',
          'price': _editedProduct.price.toString(),
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text('Product Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initFormdata['productName'],
                autofocus: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Product Name',
                  hintText: 'Valid Text',
                ),
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusNodeprice);
                },
                onSaved: (val) {
                  _editedProduct = Product(
                    productName: val,
                    isfavorite: _editedProduct.isfavorite,
                    id: _editedProduct.id,
                    imageUrl: _editedProduct.imageUrl,
                    desc: _editedProduct.desc,
                    price: _editedProduct.price,
                  );
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Required Field';
                  } else if (val.length < 3) {
                    return 'Name is too short...';
                  } else if (val.length > 20) {
                    return 'Name is too long';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                initialValue: _initFormdata['price'],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Product Price',
                  hintText: 'Market Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _focusNodeprice,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusNodeDescription);
                },
                onSaved: (val) {
                  _editedProduct = Product(
                    productName: _editedProduct.productName,
                    isfavorite: _editedProduct.isfavorite,
                    id: _editedProduct.id,
                    imageUrl: _editedProduct.imageUrl,
                    desc: _editedProduct.desc,
                    price: double.parse(val),
                  );
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Required field';
                  }
                  if (double.tryParse(val) == null) {
                    return 'This Number is not allowed!!';
                  } else if (double.tryParse(val) <= 0) {
                    return 'Enter price greater than zero';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: _initFormdata['desc'],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Product Description',
                  hintText: 'Description.....',
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _focusNodeDescription,
                onSaved: (val) {
                  _editedProduct = Product(
                    productName: _editedProduct.productName,
                    isfavorite: _editedProduct.isfavorite,
                    id: _editedProduct.id,
                    imageUrl: _editedProduct.imageUrl,
                    desc: val,
                    price: _editedProduct.price,
                  );
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Required Field';
                  } else if (val.length < 10) {
                    return 'Must be greater than 10 characters';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.0, right: 15.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black45),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text(
                              'Image Preview',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Flexible(
                    child: TextFormField(
//                      initialValue: _initFormdata['imageUrl'],
                      decoration: InputDecoration(
                          labelText: 'Image Url', hintText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (val) {
                        _editedProduct = Product(
                          productName: _editedProduct.productName,
                          isfavorite: _editedProduct.isfavorite,
                          id: _editedProduct.id,
                          imageUrl: val,
                          desc: _editedProduct.desc,
                          price: _editedProduct.price,
                        );
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Required Field';
                        } else if (!val.startsWith('http') &&
                            !val.startsWith('https')) {
                          return 'Invalid Url';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//this will avoid the memory leaks of the app.
  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _focusNodeprice.dispose();
    _focusNodeDescription.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }
}
