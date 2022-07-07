import 'package:nyoba/services/BaseWooAPI.dart';

String packageName = 'com.revoapps.woocommerce';
String url = "https://skylinekart.com";

// oauth_consumer_key
String consumerKey = "ck_20df66fecf2fda01d395348b176a6b69538911d0";
String consumerSecret = "cs_a81e39b57605f6eb92f53f2d74ec2301ef3805ee";

// String version = '2.5.6';

// baseAPI for WooCommerce
BaseWooAPI baseAPI = BaseWooAPI(url, consumerKey, consumerSecret);

const debugNetworkProxy = false;
