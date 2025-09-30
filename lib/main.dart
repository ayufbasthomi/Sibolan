import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: SibolanCloneApp(),
    ),
  );
}

/* ---------------------------
   Models & Providers
   --------------------------- */

class Product {
  final String id;
  final String title;
  final int price;
  final String sold;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.sold,
    required this.image,
  });
}

class CartProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  int get count => _items.length;

  int get totalPrice => _items.fold(0, (sum, p) => sum + p.price);

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/* ---------------------------
   App
   --------------------------- */

class SibolanCloneApp extends StatelessWidget {
  const SibolanCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sibolan Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: MainPage(),
    );
  }
}

/* ---------------------------
   Main Layout with Bottom Nav
   --------------------------- */

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text("Trending Page (placeholder)")),
    Center(child: Text("Live & Video Page (placeholder)")),
    Center(child: Text("Notifications Page (placeholder)")),
    Center(child: Text("Profile Page (placeholder)")),
  ];

  void _onItemTapped(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: "Trending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: "Live & Video",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifikasi",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Saya"),
        ],
      ),
    );
  }
}

/* ---------------------------
   Home Page (big chunk)
   --------------------------- */

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> bannerImages = [
    "https://picsum.photos/800/300?random=1",
    "https://picsum.photos/800/300?random=2",
    "https://picsum.photos/800/300?random=3",
  ];

  final List<Map<String, String>> SibolanLive = [
    {
      "title": "Huawei Payday",
      "image": "https://picsum.photos/400/400?random=11",
    },
    {
      "title": "Super Brand Day",
      "image": "https://picsum.photos/400/400?random=12",
    },
    {
      "title": "Promo Gadget",
      "image": "https://picsum.photos/400/400?random=13",
    },
  ];

  final List<Map<String, String>> SibolanVideo = [
    {"title": "OOTD Trend", "image": "https://picsum.photos/400/400?random=21"},
    {
      "title": "Makeup Tips",
      "image": "https://picsum.photos/400/400?random=22",
    },
    {
      "title": "Gadget Review",
      "image": "https://picsum.photos/400/400?random=23",
    },
  ];

  final List<Product> products = [
    Product(
      id: "p1",
      title: "Huawei Watch Fit 3",
      price: 1299000,
      sold: "12RB+",
      image: "https://picsum.photos/400/400?random=31",
    ),
    Product(
      id: "p2",
      title: "Sepatu Sneakers Pria",
      price: 299000,
      sold: "8RB+",
      image: "https://picsum.photos/400/400?random=32",
    ),
    Product(
      id: "p3",
      title: "Headphone Bluetooth",
      price: 159000,
      sold: "20RB+",
      image: "https://picsum.photos/400/400?random=33",
    ),
    Product(
      id: "p4",
      title: "Tas Ransel Anti Air",
      price: 99000,
      sold: "5RB+",
      image: "https://picsum.photos/400/400?random=34",
    ),
    Product(
      id: "p5",
      title: "iPhone 14 Pro Max",
      price: 18000000,
      sold: "2RB+",
      image: "https://picsum.photos/400/400?random=35",
    ),
    Product(
      id: "p6",
      title: "Smart TV 50 Inch 4K",
      price: 5999000,
      sold: "1RB+",
      image: "https://picsum.photos/400/400?random=36",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // AppBar with search bar + icons with badges
        SliverAppBar(
          backgroundColor: Colors.blue,
          pinned: true,
          floating: true,
          expandedHeight: 90,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(color: Colors.blue),
          ),
          title: _buildSearchRow(context),
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Menu
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildQuickMenu(),
              ),

              // Banner carousel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CarouselSlider(
                  items: bannerImages.map((url) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 7,
                    enlargeCenterPage: true,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Sibolan Live
              _sectionTitle("Sibolan Live"),
              SizedBox(
                height: 200,
                child: _buildHorizontalCardList(SibolanLive),
              ),

              const SizedBox(height: 12),

              // Sibolan Video
              _sectionTitle("Sibolan Video"),
              SizedBox(
                height: 200,
                child: _buildHorizontalCardList(SibolanVideo),
              ),

              const SizedBox(height: 12),

              // Promo heading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Sibolan Mall | 100% ORI",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),

        // Recommended product grid (SliverGrid)
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                "Rekomendasi Untukmu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = products[index];
              return _productCard(context, product);
            }, childCount: products.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.62,
            ),
          ),
        ),

        // bottom spacing
        SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    final cartCount = context.watch<CartProvider>().count;
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "Huawei Watch Fit 3",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          GestureDetector(
            onTap: () {
              // open cart
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage()),
              );
            },
            child: badges.Badge(
              showBadge: cartCount > 0,
              position: badges.BadgePosition.topEnd(top: -8, end: -6),
              badgeContent: Text(
                cartCount > 99 ? "99+" : cartCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: Icon(Icons.shopping_cart, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.chat_bubble_outline, color: Colors.grey[700]),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildQuickMenu() {
    final items = [
      {"icon": Icons.phone_android, "label": "Pulsa"},
      {"icon": Icons.fastfood, "label": "SibolanFood"},
      {"icon": Icons.card_giftcard, "label": "SibolanVIP"},
      {"icon": Icons.card_giftcard, "label": "Hadiah"},
      {"icon": Icons.discount, "label": "Diskon"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
        children: items.map((item) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade100,
                child: Icon(item['icon'] as IconData, color: Colors.blue),
              ),
              const SizedBox(height: 6),
              Text(
                item['label'] as String,
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildHorizontalCardList(List<Map<String, String>> items) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemCount: items.length,
      itemBuilder: (context, idx) {
        final item = items[idx];
        return Container(
          width: 140,
          margin: EdgeInsets.only(right: 12),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item['title']!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _productCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            // image
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            // info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Rp ${product.price}",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Terjual ${product.sold}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------
   Product Detail Page
   --------------------------- */

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  String formatPrice(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+$)'),
      (m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartPage()),
            ),
            icon: badges.Badge(
              badgeContent: Text(
                context.watch<CartProvider>().count.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Image.network(
                  product.image,
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Rp ${formatPrice(product.price)}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Terjual ${product.sold}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Deskripsi produk (demo). Ini adalah contoh deskripsi singkat untuk produk. Tambahkan detail, spesifikasi, dan informasi lain di sini.",
                      ),
                      const SizedBox(height: 300), // demo space
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Add to cart bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      cart.add(product);
                      final snack = SnackBar(
                        content: Text(
                          "${product.title} ditambahkan ke keranjang",
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text("Tambah ke Keranjang"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    cart.add(product);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.blue),
                  ),
                  child: Text(
                    "Beli Sekarang",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------------------
   Cart Page
   --------------------------- */

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Keranjang (${cart.count})"),
      ),
      body: cart.count == 0
          ? Center(child: Text("Keranjang kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, idx) {
                      final p = cart.items[idx];
                      return ListTile(
                        leading: Image.network(
                          p.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          p.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text("Rp ${p.price}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            context.read<CartProvider>().remove(p);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total: Rp ${cart.totalPrice}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          // demo checkout: clear cart
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Checkout Demo"),
                              content: Text(
                                "Lanjutkan ke pembayaran? (Demo akan mengosongkan keranjang)",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<CartProvider>().clear();
                                    Navigator.pop(ctx);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Checkout completed (demo)",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text("Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
