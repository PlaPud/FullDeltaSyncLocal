import 'package:full_delta_sync/modules/Input/input_model.dart';

const String kJsonFileName = 'SKU.json';

List<SKU> kJsonWriteMockData = [
  SKU(
    title: 'Title3',
    aliasTitle: 'AliasTitle3',
    barcode: '055456456412123',
    sku: '11516021042460',
    price: 100.0,
    remainInStock: 12,
  ),
  SKU(
    title: 'Cola',
    aliasTitle: 'Coca Cola',
    barcode: '0554545452123',
    sku: '11516544540',
    price: 100.0,
    remainInStock: 12,
  ),
  SKU(
    title: 'product1',
    aliasTitle: 'Product1',
    barcode: '3166545516111',
    sku: '11516544540',
    price: 80.0,
    remainInStock: 24,
  ),
  SKU(
    title: 'product2',
    aliasTitle: 'Product2',
    barcode: '4878845665434',
    sku: '11516544540',
    price: 59.0,
    remainInStock: 9,
  ),
];
