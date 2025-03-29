class Product {
  late String _nameProduct;
  late double _price;
  late String _description;
  late String _shopLink;
  late String _imagePath;
  late String _categories;
  late String _gender;
  late String _filter;

  Product(this._nameProduct, this._price, this._description, this._shopLink, this._imagePath, this._categories, this._gender);

    Product.fromJson(Map<String, dynamic> json) {
    _nameProduct = json['product name']?.toString() ?? 'Unknown';
    _price = (json['price'] as num?)?.toDouble() ?? 0.0;
    _description = json['description']?.toString() ?? 'No description';
    _shopLink = json['link shop']?.toString() ?? '';
    _imagePath = json['product image']?.toString() ?? '';
    _categories = json['categories']?.toString() ?? '';
    _gender = json['gender']?.toString() ?? '';
    _filter = json['filter']?.toString() ?? '';
  }

  Product.withAllData(String? productname, double? price, String? description, String? linkshop, String? productimage, String? categories, String? gender, String? filter) {
    productname??_nameProduct;
    price??_price;
    description??_description;
    linkshop??_shopLink;
    productimage??_imagePath;
    categories??_categories;
    gender??_gender;
    filter??_filter;
  }

  Product copyWith(String? productname, double? price, String? description, String? linkshop, String? productimage, String? categories, String? gender, String? filter) {
    return Product.withAllData(productname??_nameProduct, price??_price, description??_description, linkshop??_shopLink, productimage??_imagePath, categories??_categories, gender??_gender, filter??_filter);
  }

  Map<String, Object?>toJson() {
    return {
      'Product Name':_nameProduct, 
      'Price':_price,
      'Description':_description,
      'Link Shop':_shopLink,
      'Product Image':_imagePath,
      'Categories':_categories,
      'gender':_gender,
      'Filter':_filter
    };
  }

  String getProductname() {
    return _nameProduct;
  }
  double getPrice() {
    return _price;
  }
  String getDescription() {
    return _description;
  }
  String getShopLink() {
    return _shopLink;
  }
  String getProductImage() {
    return _imagePath;
  }
  String getCategories() {
    return _categories;
  }
  String getGender() {
    return _gender;
  }
  String getFiter() {
    return _filter;
  }

  void setProductname(String productname) {
    _nameProduct = productname;
  } 
  void setPrice(double price) {
    _price = price;
  }
  void setDescription(String description) {
    _description = description;
  }
  void setShopLink(String linkshop) {
    _shopLink = linkshop;
  }
  void setProductImage(String productimage) {
    _imagePath = productimage;
  }
  void setCategories(String categories) {
    _categories = categories;
  } 
  void setGender(String gender) {
    _gender = gender;
  }
  void setFilter(String filter) {
    _filter = filter;
  }
}
