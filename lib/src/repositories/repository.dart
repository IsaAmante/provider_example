import 'package:exemplo_belo/src/models/product_model.dart';

abstract class Repository {
  Future<List<Product>> getProducts();
}

class RepositoryImpl implements Repository {
  final DataSource dataSource;

  RepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts() async {
    var result = await dataSource.getProducts();
    if (result['code'] == 200)
      return (result['data'] as List<Map<String, dynamic>>)
          .map((product) => Product.fromMap(product))
          .toList();

    return [];
  }
}

abstract class DataSource {
  Future<Map<String, dynamic>> getProducts();
}

class MockDataSourceImpl implements DataSource {
  @override
  Future<Map<String, dynamic>> getProducts() async {
    await Future.delayed(Duration(seconds: 3));
    return {
      'code': 200,
      'data': [
        {
          'id': '1',
          'name': 'Bolsa',
          'price': 105.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvGLfdbCXip6PZBFx_hatxLMlpLyDPanM2_rLCDJfQTlCanbl8-xMkwChXojiWW1RZsGMuxUaGdg&usqp=CAc',
        },
        {
          'id': '2',
          'name': 'Carteira',
          'price': 79.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQytio1CevtlnH69oOqZNkb_0FGvl_ir6SBqcMatupU1Wv6x6B_NQCHuzJSqjhEimPRKL7CP9L&usqp=CAc',
        },
        {
          'id': '3',
          'name': 'Carteira Masculina',
          'price': 62.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://a-static.mlcdn.com.br/618x463/carteira-masculina-de-couro-fechamento-em-ziper-bolso-tonin-marrom/zanline/202164302/295e2c498f46b3d8c7409e59655a66c3.jpg',
        },
        {
          'id': '4',
          'name': 'Clutch',
          'price': 129.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://d1ug6lpn0d6ze6.cloudfront.net/Custom/Content/Products/20/07/2007696_clutch-inah-natural-51-97-0310_z1_637650711247946545.jpg',
        },
        {
          'id': '5',
          'name': 'Cinto de couro ecológico',
          'price': 72.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://img.irroba.com.br/fit-in/600x600/filters:fill(fff):quality(95)/botineir/catalog/cinto-couro-soleta-brown/cinto-cafe-1.jpg',
        },
        {
          'id': '6',
          'name': 'Bolsa',
          'price': 105.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvGLfdbCXip6PZBFx_hatxLMlpLyDPanM2_rLCDJfQTlCanbl8-xMkwChXojiWW1RZsGMuxUaGdg&usqp=CAc',
        },
        {
          'id': '7',
          'name': 'Carteira',
          'price': 79.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQytio1CevtlnH69oOqZNkb_0FGvl_ir6SBqcMatupU1Wv6x6B_NQCHuzJSqjhEimPRKL7CP9L&usqp=CAc',
        },
        {
          'id': '8',
          'name': 'Carteira Masculina',
          'price': 62.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://a-static.mlcdn.com.br/618x463/carteira-masculina-de-couro-fechamento-em-ziper-bolso-tonin-marrom/zanline/202164302/295e2c498f46b3d8c7409e59655a66c3.jpg',
        },
        {
          'id': '9',
          'name': 'Clutch',
          'price': 129.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://d1ug6lpn0d6ze6.cloudfront.net/Custom/Content/Products/20/07/2007696_clutch-inah-natural-51-97-0310_z1_637650711247946545.jpg',
        },
        {
          'id': '10',
          'name': 'Cinto de couro ecológico',
          'price': 72.9,
          'description':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
          'imgUrl':
              'https://img.irroba.com.br/fit-in/600x600/filters:fill(fff):quality(95)/botineir/catalog/cinto-couro-soleta-brown/cinto-cafe-1.jpg',
        },
      ],
    };
  }
}
