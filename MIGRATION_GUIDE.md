# Migration Guide: From Hardcoded Data to API Services

This guide shows how to migrate your existing Flutter app from hardcoded category data to using API services.

## Files Created

1. **Models (`lib/models/category_models.dart`)**
   - `CategoryDetailData` with JSON serialization
   - `EntryFormat`, `JudgingCriterion`, `Awards`, `Voting` classes
   - `CategoryType` enum with extensions

2. **Services (`lib/services/`)**
   - `api_client.dart` - HTTP client utilities  
   - `category_service.dart` - Category API calls with mock data fallback
   - `category_repository.dart` - Repository pattern with caching
   - `category_navigation_helper.dart` - Navigation utilities with loading/error handling

3. **Documentation**
   - `API_ENDPOINTS.md` - Complete API documentation

## Quick Migration Steps

### Step 1: Update Dependencies
```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0
```

### Step 2: Replace Category Navigation (Minimal Change)

**Before (in your home_screen.dart):**
```dart
void openSinging() {
  final data = CategoryDetailData(
    // ... hardcoded data
  );
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => CategoryDetailScreen(data: data, imageAsset: 'lib/assets/singing.png'),
    ),
  );
}
```

**After (using helper):**
```dart
void openSinging() {
  CategoryNavigationHelper.navigateToCategory(
    context: context,
    categoryType: CategoryType.singing,
  );
}
```

### Step 3: Update Imports

Add these imports to your `home_screen.dart`:
```dart
import '../models/category_models.dart';
import '../services/category_navigation_helper.dart';
```

### Step 4: Optional - Preload Data

In your `initState()`:
```dart
@override
void initState() {
  super.initState();
  // Preload category data in background
  CategoryNavigationHelper.preloadCategories();
}
```

## Complete Example: Updated Category Navigation

Here's how to update your existing category navigation methods:

```dart
// lib/screens/home_screen.dart

import '../models/category_models.dart';
import '../services/category_navigation_helper.dart';

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState() {
    super.initState();
    // Preload categories for faster navigation
    CategoryNavigationHelper.preloadCategories();
  }

  // Updated navigation methods
  void openSinging() {
    CategoryNavigationHelper.navigateToCategory(
      context: context,
      categoryType: CategoryType.singing,
    );
  }

  void openActing() {
    CategoryNavigationHelper.navigateToCategory(
      context: context,
      categoryType: CategoryType.acting,
    );
  }

  void openPhoto() {
    CategoryNavigationHelper.navigateToCategory(
      context: context,
      categoryType: CategoryType.photography,
    );
  }

  void openDance() {
    CategoryNavigationHelper.navigateToCategory(
      context: context,
      categoryType: CategoryType.dance,
    );
  }

  // Rest of your existing code remains the same...
}
```

## Advanced Usage

### Using Repository Directly
```dart
final repository = CategoryRepositoryProvider.instance;

// Get specific category
final singingData = await repository.getCategoryData(CategoryType.singing);

// Get all categories
final allCategories = await repository.getAllCategories();

// Clear cache when needed
repository.clearCache();
```

### Custom Loading/Error Handling
```dart
void openSingingWithCustomHandling() async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CircularProgressIndicator(),
    );

    final data = await CategoryRepositoryProvider.instance
        .getCategoryData(CategoryType.singing);
    
    Navigator.pop(context); // Close loading

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(
          data: data,
          imageAsset: CategoryType.singing.imageAsset,
        ),
      ),
    );
  } catch (error) {
    Navigator.pop(context); // Close loading
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }
}
```

## API Configuration

### Setting Your API Base URL

In `lib/services/category_service.dart` and `lib/services/api_client.dart`:

```dart
static const String baseUrl = 'https://your-actual-api-url.com';
```

### Mock Data Fallback

The service automatically falls back to mock data if API calls fail. This means:
- ✅ Your app works offline
- ✅ Your app works during API development
- ✅ Seamless transition from mock to real data

## Testing

### Test with Mock Data (Current State)
Your app will work immediately with realistic mock data.

### Test with Real API
1. Update `baseUrl` in service files
2. Implement actual API endpoints (see API_ENDPOINTS.md)
3. Test API integration

## Benefits of This Architecture

1. **Separation of Concerns**: Data logic separated from UI
2. **Caching**: Reduces API calls and improves performance  
3. **Error Handling**: Graceful handling of network errors
4. **Offline Support**: Falls back to cached/mock data
5. **Easy Testing**: Mock and real data can be swapped easily
6. **Scalability**: Easy to add new categories or modify data structure

## Next Steps

1. **Immediate**: Use the navigation helper for quick migration
2. **Short term**: Implement actual API endpoints
3. **Long term**: Add features like statistics, voting, entry submission

Your existing app will work immediately with better architecture and the ability to easily integrate real APIs later!
