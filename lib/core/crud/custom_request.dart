import 'package:b2b_partenership/core/errors/failure.dart';
import 'package:b2b_partenership/core/network/dio_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

/*
* This class is used to send custom requests to the server using Dio package and return the response as Either of Failure and T
* It has a generic type T which is the type of the Model data
* It has a generic type R which is the type of the response type data
*/

class CustomRequest<T> {
/*
* It has a path which is the endpoint of the request
* It has a queryParameters which is the query parameters of the request
* It has a data which is the request data
* It has a fromJson function which is used to convert the response to the required type
*/

  final String path;
  final Map<String, dynamic> queryParameters;
  final Map<String, dynamic> data;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> files;

  CustomRequest({
    required this.path,
    required this.fromJson,
    this.queryParameters = const {},
    this.data = const {},
    this.files= const {}
  });

/*
* It has sendGetRequest, sendPostRequest, sendPutRequest, sendDeleteRequest, sendPatchRequest methods to send the request
* It returns an Either of Failure and T
* If the request is successful it returns Right with the response data
* If the request fails it returns Left with the Failure
*/

  Future<Either<Failure, T>> sendGetRequest() async {
    try {
      final response = await Get.find<DioLogger>().getDio().get(
            path,
            queryParameters: queryParameters,
            data: data,
          );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, T>> sendPostRequest() async {
    try {
      final response = await Get.find<DioLogger>().getDio().post(
            path,
            data: data,
            queryParameters: queryParameters,
          );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }

      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, T>> sendPutRequest() async {
    try {
      final response = await Get.find<DioLogger>().getDio().put(
            path,
            data: data,
            queryParameters: queryParameters,
          );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, T>> sendDeleteRequest() async {
    try {
      final response = await Get.find<DioLogger>().getDio().delete(
            path,
            data: data,
            queryParameters: queryParameters,
          );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, T>> sendPatchRequest() async {
    try {
      final response = await Get.find<DioLogger>().getDio().patch(
            path,
            data: data,
            queryParameters: queryParameters,
          );

      final jsonData = fromJson(response.data);

      return Right(jsonData);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
