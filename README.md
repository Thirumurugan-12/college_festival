# Sing College - Flutter Web App

A responsive Flutter web application optimized for both mobile and desktop devices, featuring a coffee-themed design with transparent header navigation.

## Features

- **Responsive Design**: Optimized for mobile, tablet, and desktop screens
- **Transparent Header**: Modern transparent navigation bar with gradient overlay
- **Coffee Theme**: Beautiful coffee color scheme with gradients
- **Mobile-First**: Touch-friendly interface for mobile devices
- **Modern UI**: Clean, professional design with smooth animations

## Project Structure

```
lib/
├── constants/
│   └── app_colors.dart          # Color scheme and theme constants
├── screens/
│   └── home_screen.dart         # Main home screen with hero section
├── widgets/
│   └── transparent_header.dart  # Responsive transparent header widget
├── utils/
│   └── responsive.dart          # Responsive design utilities
├── models/                      # Data models (future use)
├── services/                    # API services (future use)
└── main.dart                    # App entry point
```

## Getting Started

1. **Prerequisites**
   - Flutter SDK (3.32.7 or later)
   - Chrome browser for web development

2. **Installation**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web development
   flutter run -d chrome
   
   # For mobile development
   flutter run
   ```

## Design Features

### Color Scheme
- **Primary Coffee**: #6F4E37
- **Light Coffee**: #8B4513
- **Dark Coffee**: #3C2415
- **Cream**: #F5E6D3
- **Latte**: #D2B48C

### Responsive Breakpoints
- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: > 1024px

### Header Features
- Transparent background with gradient overlay
- Responsive navigation (desktop: inline buttons, mobile: hamburger menu)
- Login and "Enter Thiruvala" buttons
- Brand logo/title

## Future Enhancements

- [ ] User authentication system
- [ ] Student portal integration
- [ ] Course catalog
- [ ] Online application system
- [ ] News and announcements
- [ ] Contact forms
- [ ] Multi-language support

## Development

The app uses a clean architecture with:
- **Constants**: Centralized color and theme management
- **Widgets**: Reusable UI components
- **Screens**: Main application screens
- **Utils**: Helper functions for responsive design

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on multiple screen sizes
5. Submit a pull request

## License

This project is licensed under the MIT License.
