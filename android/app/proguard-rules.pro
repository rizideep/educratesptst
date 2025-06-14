# Keep all Stripe push provisioning related classes
-keep class com.stripe.android.pushProvisioning.** { *; }

# Optional: Suppress warnings about missing Stripe push provisioning classes
-dontwarn com.stripe.android.pushProvisioning.**

# Suppress warnings about missing classes
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.PaymentsClient
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.Wallet
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.WalletUtils
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

# Keep ProGuard annotations to avoid removal
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
# Prevent R8 from stripping BackEvent class used in Android 14+
-keep class android.window.BackEvent { *; }

# Keep FlutterActivity methods that use BackEvent
-keep class io.flutter.embedding.android.FlutterActivity {
    void startBackGesture(android.window.BackEvent);
    void onBackGestureProgress(android.window.BackEvent);
    void onBackGestureCancelled();
    void onBackGestureComplete();
}

# Keep Razorpay classes and any other relevant classes
-keep class com.razorpay.** { *; }
# Prevent R8 from removing or trying to resolve BackEvent class
-dontwarn android.window.BackEvent
-dontwarn android.view.WindowOnBackInvokedDispatcher
-dontwarn android.window.OnBackInvokedCallback
# Keep FlutterView even if it references newer APIs
-keep class io.flutter.view.FlutterView { *; }
-dontwarn android.window.BackEvent

