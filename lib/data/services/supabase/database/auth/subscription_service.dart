import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/domain/models/subscriptions_model.dart';

class SubscriptionService {
  final supabase = Supabase.instance.client;
  final String tableName = 'subscriptions';

  Future<List<SubscriptionModel>> getAllSubscriptions() async {
    try {
      final response = await supabase
          .from(tableName)
          .select()
          .order('created_at', ascending: false);

      final data = response as List<dynamic>;
      return data.map((json) => SubscriptionModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('SubscriptionService.getAllSubscriptions error: $e');
      rethrow;
    }
  }
  Future<List<SubscriptionModel>> getSubscriptionsByUserId(String userId) async {
  try {
    final response = await supabase
        .from(tableName)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    final data = response as List<dynamic>;
    return data.map((json) => SubscriptionModel.fromJson(json)).toList();
  } catch (e) {
    debugPrint('SubscriptionService.getSubscriptionsByUserId error: $e');
    rethrow;
  }
}


  Future<SubscriptionModel?> getSubscriptionById(int id) async {
    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('id', id)
          .single();

      return SubscriptionModel.fromJson(response);
    } catch (e) {
      debugPrint('SubscriptionService.getSubscriptionById error: $e');
      return null;
    }
  }

  Future<void> createSubscription(SubscriptionModel subscription) async {
    try {
      await supabase.from(tableName).insert(subscription.toJson());
    } catch (e) {
      debugPrint('SubscriptionService.createSubscription error: $e');
      rethrow;
    }
  }

  Future<void> updateSubscription(SubscriptionModel subscription) async {
    try {
      await supabase
          .from(tableName)
          .update(subscription.toJson())
          .eq('user_id', subscription.userId);
    } catch (e) {
      debugPrint('SubscriptionService.updateSubscription error: $e');
      rethrow;
    }
  }

  Future<void> deleteSubscription(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
    } catch (e) {
      debugPrint('SubscriptionService.deleteSubscription error: $e');
      rethrow;
    }
  }
}
