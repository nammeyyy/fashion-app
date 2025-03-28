class Product {
  late String _nameProduct;
  late double _price;
  late String _description;
  late String _shopLink;
  late String _imagePath;
  late String _categories;

  Product(this._nameProduct, this._price, this._description, this._shopLink, this._imagePath, this._categories);

  Product.fromJson(Map<String, Object?> json) {
    _nameProduct = json['product name'] as String;
    _price = json['price'] as double;
    _description = json['description'] as String;
    _shopLink = json['link shop'] as String;
    _imagePath = json['product image'] as String;
    _categories = json['categories'] as String;
  }

  Product.withAllData(String? productname, double? price, String? description, String? linkshop, String? productimage, String? categories) {
    productname??_nameProduct;
    price??_price;
    description??_description;
    linkshop??_shopLink;
    productimage??_imagePath;
    categories??_categories;
  }

  Product copyWith(String? productname, double? price, String? description, String? linkshop, String? productimage, String? categories) {
    return Product.withAllData(productname??_nameProduct, price??_price, description??_description, linkshop??_shopLink, productimage??_imagePath, categories??_categories);
  }

  Map<String, Object?>toJson() {
    return {
      'Product Name':_nameProduct, 
      'Price':_price,
      'Description':_description,
      'Link Shop':_shopLink,
      'Product Image':_imagePath,
      'Categories':_categories
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
}
