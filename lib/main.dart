import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 默认的浅色主题颜色，当系统不支持动态颜色时使用
  static final defaultLightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.brown,
    brightness: Brightness.light,
    primary: Colors.brown[600],
    secondary: Colors.amber[600],
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  );
  
  // 默认的深色主题颜色，当系统不支持动态颜色时使用
  static final defaultDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.brown,
    brightness: Brightness.dark,
    primary: Colors.brown[400],
    secondary: Colors.amber[400],
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    background: Colors.grey[900],
    surface: Colors.grey[800],
    onBackground: Colors.white,
    onSurface: Colors.white,
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
      
      // 创建深色主题配置
      final darkTheme = ThemeData(
        useMaterial3: true,
        colorScheme: darkDynamic ?? defaultDarkColorScheme,
        // 配置Material You特有的元素
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          surfaceTintColor: Colors.transparent,
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
      // 设置themeMode为ThemeMode.system，使应用跟随系统的深浅色模式切换
      return MaterialApp(
        title: 'COFFEE',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const MainPage(),
      );
    });
  }
}

// 主页面，包含底部导航栏和Fragment切换
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // 定义各个Fragment页面
  final List<Widget> _pages = [
    const CoffeeFragment(),
    const SettingsFragment(),
  ];

  // 底部导航栏项目
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.coffee),
      label: 'COFFEE',
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings),
      label: '设置',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      // 使用Material You的AppBar样式，背景色通过surfaceTintColor自动处理
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'COFFEE' : '设置'),
        // 使用surfaceTintColor而不是直接设置backgroundColor
        // 这样系统会自动应用Material You的背景色处理规则
        surfaceTintColor: colorScheme.primary,
        // 启用Material You的动态阴影效果
        elevation: 2,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _items,
        // 使用Material 3风格的底部导航栏
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
        backgroundColor: colorScheme.surface,
        elevation: 8,
        // 配置导航栏的外观以符合Material 3设计
        showUnselectedLabels: true,
      ),
    );
  }
}

// COFFEE Fragment，包含原来的开关功能
class CoffeeFragment extends StatefulWidget {
  const CoffeeFragment({super.key});

  @override
  State<CoffeeFragment> createState() => _CoffeeFragmentState();
}

class _CoffeeFragmentState extends State<CoffeeFragment> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    // 获取主题颜色，以便在整个应用中保持一致的Material You风格
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      color: colorScheme.background,
      width: double.infinity,
      height: double.infinity,
      // 使用Center将开关居中显示
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 添加Material Design风格的开关组件
            // 通过transform.scale属性使开关变大
            Transform.scale(
              scale: 2.0, // 将开关放大2倍
              child: Switch(
                value: _isSwitched,
                onChanged: (bool value) {
                  // 触发震动反馈
                  HapticFeedback.lightImpact();
                  
                  setState(() {
                    _isSwitched = value;
                  });
                },
                // 使用Material You的主题颜色
                activeColor: colorScheme.primary,
                activeTrackColor: colorScheme.primary.withOpacity(0.3),
              ),
            ),
            // 添加一个文本标签来指示开关状态
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                _isSwitched ? '已开启' : '已关闭',
                style: TextStyle(
                  fontSize: 18,
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// 设置Fragment，作为第二个页面
class SettingsFragment extends StatelessWidget {
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      color: colorScheme.background,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text(
          '设置页面',
          style: TextStyle(
            fontSize: 24,
            color: colorScheme.onBackground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
