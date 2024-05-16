import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../config/index.dart';

const String appUserCollections = "AppUsers";
const String workersCollections = "workers";
const String industriesCollections = "Industries";
const String jobPostsCollections = "ScrappedJobs";
const String companyCollections = "Companies";
const String appVersionsCollection = "AppVersions";
const String transactionsCollection = "Transactions";
const String transactionsByUIDCollection = "TransactionsByUID";
const String appleCollection = "AppleSubscriptionsPaymentDetails";
const String googleCollection = "GoogleSubscriptionsPaymentDetails";
const String productsCollection = "Products";
const String productCategoriesCollection = "ProductCategories";
const String productSubcategoriesCollection = "ProductSubcategories";
const String productStatusesCollection = "ProductStatuses";
const String leadsCollection = "Leads";
const String leadStatusesCollection = "LeadStatuses";
const String leadContactSessionsCollection = "LeadContactSessions";
const String leadContactSessionStatusesCollection =
    "LeadContactSessionStatuses";
const String leadContactsCollection = "LeadContacts";
const String leadContactStatusesCollection = "LeadContactStatuses";
const String leadContactMethodsCollection = "LeadContactMethods";
String baseUrlAppEngineFunctions = Config().appEngineFunctionsURL;

getCRMFireStoreInstance() async {
  FirebaseApp additionalApp = await Firebase.initializeApp(
    name: 'SecondaryApp', // Give your app a custom name
    options: const FirebaseOptions(
        apiKey: "AIzaSyBefN8HB2FRN7ygJdJyAI_xOE4eKaB1D5k",
        authDomain: "blukerscrm.firebaseapp.com",
        projectId: "blukerscrm",
        storageBucket: "blukerscrm.appspot.com",
        messagingSenderId: "460836121292",
        appId: "1:460836121292:web:f9f079425727ad08a5f069",
        measurementId: "G-N6KVZ8TWS0"
// Add other required options
        ),
  );

  // Create a Firestore instance for the new app
  FirebaseFirestore firestoreForAdditionalApp =
      FirebaseFirestore.instanceFor(app: additionalApp);

  return firestoreForAdditionalApp;
}
