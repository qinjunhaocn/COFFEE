import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 默认的主题颜色，当系统不支持动态颜色时使用
  static final defaultLightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.brown,
    brightness: Brightness.light,
    primary: Colors.brown[600],
    secondary: Colors.amber[600],
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    // 使用DynamicColorBuilder来实现莫奈取色（从系统壁纸提取颜色）
    return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      // 创建基于系统动态颜色的主题
      // 如果系统支持动态颜色，则使用系统颜色，否则使用默认颜色
      final lightTheme = ThemeData(
        useMaterial3: true,
        colorScheme: lightDynamic ?? defaultLightColorScheme,
        // 配置Material You特有的元素
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          surfaceTintColor: Colors.white,
        ),
        // 配置按钮风格为Material You样式
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
        ),
        // 配置输入框样式
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
        // 配置文本样式
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      );

      // 返回MaterialApp，使用动态生成的主题
      return MaterialApp(
        title: 'COFFEE',
        theme: lightTheme,
        home: const CoffeeHomePage(),
      );
    });
  }
}

class CoffeeHomePage extends StatelessWidget {
  const CoffeeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取主题颜色，以便在整个应用中保持一致的Material You风格
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      // 使用Material You的AppBar样式，背景色通过surfaceTintColor自动处理
      appBar: AppBar(
        title: const Text('COFFEE'),
        // 使用surfaceTintColor而不是直接设置backgroundColor
        // 这样系统会自动应用Material You的背景色处理规则
        surfaceTintColor: colorScheme.primary,
        // 启用Material You的动态阴影效果
        elevation: 2,
      ),
      // 主体内容使用colorScheme.background确保与Material You主题一致
      body: Container(
        color: colorScheme.background,
        width: double.infinity,
        height: double.infinity,
        // 可以在这里添加更多Material You风格的控件
      ),
    );
  }
}
