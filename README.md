# blukers

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Declaring Providers
JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
UserProvider up = Provider.of<UserProvider>(context);
IndustriesProvider ip = Provider.of<IndustriesProvider>(context);
WorkerProvider wp = Provider.of<WorkerProvider>(context);

# Anonymously Navigate to a page
Navigator.push(
context,
MaterialPageRoute(
    builder: (context) =>
        ListOfAppliedWorkers(jobPost: jobPost)),
);

# Navigate to Named Route
context.go( '/workers');

# Showing a Dialog Box
showDialog(
    context: context,
    builder: (context) => DisplayJobPostDialog(
          jobPost: jobPost,));

# After Flutter Upgrade Codes to Run
1. flutter upgrade
2. flutter clean
3. flutter pub get
4. flutter pub upgrade


# Fixing Common Ios Build Errors
1. cd ios
2. rm Podfile.lock
3. rm Podfile
4. pod install

