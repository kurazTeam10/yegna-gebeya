import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final models = await remoteDataSource.getAllProducts();
    return models.map<ProductEntity>(_convertModelToEntity).toList();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String category) async {
    final models = await remoteDataSource.getProductsByCategory(category);
    return models.map<ProductEntity>(_convertModelToEntity).toList();
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final models = await remoteDataSource.searchProducts(query);
    return models.map<ProductEntity>(_convertModelToEntity).toList();
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final model = await remoteDataSource.getProductById(id);
    return model != null ? _convertModelToEntity(model) : null;
  }

  ProductEntity _convertModelToEntity(ProductModel model) {
    return ProductEntity(
      id: model.id,
      name: model.name,
      price: model.price,
      imageUrl: model.imageUrl,
      category: model.category,
      description: model.description,
    );
  }
}