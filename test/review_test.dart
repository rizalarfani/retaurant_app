import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/providers/reviews_provider.dart';

@GenerateMocks([http.Client, ReviewsProvider])
void main() {}
