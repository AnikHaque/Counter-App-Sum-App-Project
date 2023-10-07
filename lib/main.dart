import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Bag'),
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              'MY BAG',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ProductDetailsScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double totalAmount = 0.0; // Initialize the total amount

  void updateTotalAmount() {
    // Calculate the total amount based on individual product quantities and prices
    setState(() {
      totalAmount = (30.0 * hoodieItemCount) +
          (25.0 * sweatshirtItemCount) +
          (10.0 * tshirtItemCount);
    });
  }

  int hoodieItemCount = 1;
  int sweatshirtItemCount = 1;
  int tshirtItemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ProductCard(
            productName: 'Hoodie',
            imageUrl:
            'https://i.etsystatic.com/24528332/r/il/f38558/4412439546/il_794xN.4412439546_g0wy.jpg',
            productColor: 'Black',
            productSize: 'M',
            unitPrice: 30.0,
            itemCount: hoodieItemCount,
            onIncrement: () {
              setState(() {
                hoodieItemCount++;
                updateTotalAmount();
              });
            },
            onDecrement: () {
              if (hoodieItemCount > 1) {
                setState(() {
                  hoodieItemCount--;
                  updateTotalAmount();
                });
              }
            },
          ),
          SizedBox(height: 16.0),
          ProductCard(
            productName: 'Sweatshirt',
            imageUrl:
            'https://i.etsystatic.com/24528332/r/il/0c7f2b/4459991957/il_794xN.4459991957_9bz2.jpg',
            productColor: 'Gray',
            productSize: 'L',
            unitPrice: 25.0,
            itemCount: sweatshirtItemCount,
            onIncrement: () {
              setState(() {
                sweatshirtItemCount++;
                updateTotalAmount();
              });
            },
            onDecrement: () {
              if (sweatshirtItemCount > 1) {
                setState(() {
                  sweatshirtItemCount--;
                  updateTotalAmount();
                });
              }
            },
          ),
          SizedBox(height: 16.0),
          ProductCard(
            productName: 'T-Shirt',
            imageUrl:
            'https://i.etsystatic.com/24528332/r/il/0746f2/5353986472/il_794xN.5353986472_hev3.jpg',
            productColor: 'White',
            productSize: 'XL',
            unitPrice: 10.0,
            itemCount: tshirtItemCount,
            onIncrement: () {
              setState(() {
                tshirtItemCount++;
                updateTotalAmount();
              });
            },
            onDecrement: () {
              if (tshirtItemCount > 1) {
                setState(() {
                  tshirtItemCount--;
                  updateTotalAmount();
                });
              }
            },
          ),
          SizedBox(height: 16.0),
          TotalAmountAndCheckout(totalAmount: totalAmount),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final String productColor;
  final String productSize;
  final double unitPrice;
  final int itemCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  ProductCard({
    required this.productName,
    required this.imageUrl,
    required this.productColor,
    required this.productSize,
    required this.unitPrice,
    required this.itemCount,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = itemCount * unitPrice;

    return Center(
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                imageUrl,
                width: 100,
                height: 100,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          productName,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.more_vert), // Three vertical dots icon
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                  onTap: () {
                                    // Handle edit action
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                  onTap: () {
                                    // Handle delete action
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Text(
                          'Color: ',
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          productColor,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Size: ',
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          productSize,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: onDecrement,
                            ),
                            Text(
                              itemCount.toString(),
                              style: TextStyle(fontSize: 20.0),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: onIncrement,
                            ),
                          ],
                        ),
                        Text(
                          '\$${unitPrice.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalAmountAndCheckout extends StatelessWidget {
  final double totalAmount;

  TotalAmountAndCheckout({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total Amount:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$$totalAmount',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.0), // Add spacing between the row and the button
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Checkout completed!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                width: double.infinity, // Make the button width full
                child: Center(
                  child: Text('CHECK OUT'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
