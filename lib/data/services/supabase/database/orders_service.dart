import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersService {
    final SupabaseClient client = Supabase.instance.client;
  final String tableName = 'orders';

}