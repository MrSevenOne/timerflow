import 'package:timerflow/data/services/supabase/database/auth/subscription_service.dart';
import 'package:timerflow/domain/models/subscriptions_model.dart';

class SubscriptionRepository {
  final SubscriptionService subscriptionService;
  SubscriptionRepository(this.subscriptionService);
//Add
  Future<void> addSubscription(SubscriptionModel subscription) async {
    await subscriptionService.createSubscription(subscription);
  }

//Upgrate
  Future upgrateSubscription(SubscriptionModel subscription) async {
    return await subscriptionService.updateSubscription(subscription);
  }
// Get by UserId
  Future getByUserIdSubscription(String userId) async =>
      subscriptionService.getSubscriptionsByUserId(userId);
}
