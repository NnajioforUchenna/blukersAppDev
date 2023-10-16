// DEV
import 'dev/dev_keys.dart';
import 'dev/dev_subscriptions_worker.dart';
import 'dev/dev_subscriptions_company.dart';
import 'dev/dev_subscription_features_worker.dart';
import 'dev/dev_subscription_features_company.dart';

// PROD
import 'prod/prod_keys.dart';
import 'prod/prod_subscriptions_worker.dart';
import 'prod/prod_subscriptions_company.dart';
import 'prod/prod_subscription_features_worker.dart';
import 'prod/prod_subscription_features_company.dart';

bool isDevelopmentMode = true;

class Config {
  // APP VERSION

  String appVersion = "1.0.5";

  // SUBSCRIPTIONS - iOS - WORKER

  var workerPremiumiOSSubscription = isDevelopmentMode
      ? DevSubscriptionsiOSWorker.premium
      : ProdSubscriptionsiOSWorker.premium;

  var workerPremiumPlusiOSSubscription = isDevelopmentMode
      ? DevSubscriptionsiOSWorker.premiumPlus
      : ProdSubscriptionsiOSWorker.premiumPlus;

  // SUBSCRIPTIONS - iOS - COMPANY

  var companyPremiumiOSSubscription = isDevelopmentMode
      ? DevSubscriptionsiOSCompany.premium
      : ProdSubscriptionsiOSCompany.premium;

  // SUBSCRIPTIONS - ANDROID - WORKER

  var workerPremiumAndroidSubscription = isDevelopmentMode
      ? DevSubscriptionsAndroidWorker.premium
      : ProdSubscriptionsAndroidWorker.premium;

  var workerPremiumPlusAndroidSubscription = isDevelopmentMode
      ? DevSubscriptionsAndroidWorker.premiumPlus
      : ProdSubscriptionsAndroidWorker.premiumPlus;

  // SUBSCRIPTIONS - ANDROID - COMPANY

  var companyPremiumAndroidSubscription = isDevelopmentMode
      ? DevSubscriptionsAndroidCompany.premium
      : ProdSubscriptionsAndroidCompany.premium;

  // SUBSCRIPTIONS - STRIPE - WORKER

  var workerPremiumStripeSubscription = isDevelopmentMode
      ? DevSubscriptionsStripeWorker.premium
      : ProdSubscriptionsStripeWorker.premium;

  var workerPremiumPlusStripeSubscription = isDevelopmentMode
      ? DevSubscriptionsStripeWorker.premiumPlus
      : ProdSubscriptionsStripeWorker.premiumPlus;

  // SUBSCRIPTIONS - STRIPE - COMPANY

  var companyPremiumStripeSubscription = isDevelopmentMode
      ? DevSubscriptionsStripeCompany.premium
      : ProdSubscriptionsStripeCompany.premium;

  // SUBSCRIPTION FEATURES - WORKER

  var workerBasicSubscriptionFeatures = isDevelopmentMode
      ? DevSubscriptionFeaturesWorker.basic
      : ProdSubscriptionFeaturesWorker.basic;

  var workerPremiumSubscriptionFeatures = isDevelopmentMode
      ? DevSubscriptionFeaturesWorker.premium
      : ProdSubscriptionFeaturesWorker.premium;

  var workerPremiumPlusSubscriptionFeatures = isDevelopmentMode
      ? DevSubscriptionFeaturesWorker.premiumPlus
      : ProdSubscriptionFeaturesWorker.premiumPlus;

  // SUBSCRIPTION FEATURES - COMPANY

  var companyBasicSubscriptionFeatures = isDevelopmentMode
      ? DevSubscriptionFeaturesCompany.basic
      : ProdSubscriptionFeaturesCompany.basic;

  var companyPremiumSubscriptionFeatures = isDevelopmentMode
      ? DevSubscriptionFeaturesCompany.premium
      : ProdSubscriptionFeaturesCompany.premium;

  var companyPremiumPlusSubscriptionFeatures = isDevelopmentMode
      ? DevSubscriptionFeaturesCompany.premiumPlus
      : ProdSubscriptionFeaturesCompany.premiumPlus;

  // REVENUE CAT - API KEY

  var revenueCatAppApiKey = isDevelopmentMode
      ? DevKeys.revenueCatAppApiKey
      : ProdKeys.revenueCatAppApiKey;

  var workerPremiumSubscriptionRevenueCatEntitlement = isDevelopmentMode
      ? DevSubscriptionsRevenueCatWorkerEntitlements.premium
      : ProdSubscriptionsRevenueCatWorkerEntitlements.premium;

  var workerPremiumPlusSubscriptionRevenueCatEntitlement = isDevelopmentMode
      ? DevSubscriptionsRevenueCatWorkerEntitlements.premiumPlus
      : ProdSubscriptionsRevenueCatWorkerEntitlements.premiumPlus;

  var companyPremiumSubscriptionRevenueCatEntitlement = isDevelopmentMode
      ? DevSubscriptionsRevenueCatCompanyEntitlements.premium
      : ProdSubscriptionsRevenueCatCompanyEntitlements.premium;

  // GCP - APP ENGINE

  var appEngineFunctionsURL = isDevelopmentMode
      ? DevKeys.appEngineFunctionsURL
      : ProdKeys.appEngineFunctionsURL;
}
