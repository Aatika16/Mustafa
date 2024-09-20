// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shop_pe_app/Constants/constants.dart';
// import 'package:shop_pe_app/screens/User/productDetails.dart';

// class SecondSearch extends StatefulWidget {
//   final String name;
//   final String email;
//   final String Userid;
//   final String contact;
//   const SearchScreen(
//       {super.key,
//       required this.name,
//       required this.email,
//       required this.Userid,
//       required this.contact});

//   @override
//   State<SecondSearch> createState() => _SecondSearch();
// }

// class _SecondSearch extends State<SecondSearch> {
//   List _allResults = [];
//   List _resultList = [];

//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     _searchController.addListener(_onSearchChanged);
//     super.initState();
//   }

//   _onSearchChanged() {
//     print(_searchController.text);
//     searchResultList();
//   }

//   searchResultList() {
//     var showResults = [];
//     if (_searchController.text != "") {
//       for (var productSnapshot in _allResults) {
//         var product = productSnapshot['productName'].toString().toLowerCase();
//         if (product.contains(_searchController.text.toLowerCase())) {
//           showResults.add(productSnapshot);
//         }
//       }
//     } else {
//       showResults = List.from(_allResults);
//     }
//     setState(() {
//       _resultList = showResults;
//     });
//   }

//   Future<void> getProductStream() async {
//     try {
//       var data = await FirebaseFirestore.instance
//           .collection('Products')
//           .orderBy('productName')
//           .get();

//       List<Map<String, dynamic>> fetchedProducts = [];

//       for (var doc in data.docs) {
//         Map<String, dynamic> productData = doc.data();
//         String productId = doc.id;

//         // Get image URL from Firebase Storage
//         String imageUrl = await FirebaseStorage.instanceFor(
//                 bucket: "gs://watchhub-311b2.appspot.com")
//             .ref('products/$productId')
//             .getDownloadURL();

//         fetchedProducts.add({
//           'productId': productId,
//           'productName': productData['productName'],
//           'price': productData['price'],
//           'description': productData['description'],
//           'imageUrl': imageUrl,
//         });
//       }

//       setState(() {
//         _allResults = fetchedProducts;
//       });
//       searchResultList();
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     getProductStream();
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenwidth = MediaQuery.of(context).size.width;
//     double screenheight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 20),
//             width: screenwidth * 1,
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             child: Text("Filter Products",
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.domine(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w900,
//                   fontSize: 25,
//                 )),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 60, left: 20, right: 20),
//             width: screenwidth * 1,
//             //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

//             /// padding: EdgeInsets.symmetric(horizontal: 30),
//             child: CupertinoSearchTextField(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.5),
//                 border: Border.all(color: Colors.amber.shade400),
//                 borderRadius: BorderRadius.circular(
//                     50), // Adjust the value for more rounded corners
//               ),
//               controller: _searchController,
//               //backgroundColor: Constants.greyColor,
//               itemColor: Colors.amber,
//               placeholder: "Search.....",
//               style: TextStyle(color: Colors.amber),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 100),
//             child: ListView.builder(
//                 itemCount: _resultList.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {},
//                     child: Container(
//                       height: 100,
//                       width: screenwidth * 1,
//                       margin:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.amber.shade400.withOpacity(0.5),
//                         border: Border.all(color: Colors.amber.shade400),
//                         borderRadius: BorderRadius.circular(
//                             20), // Adjust the value for more rounded corners
//                       ),
//                       child: Center(
//                         child: ListTile(
//                           leading: Container(
//                             width: 70,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(255, 202, 40, 0.5),
//                               border: Border.all(color: Colors.amber.shade400),
//                               borderRadius: BorderRadius.circular(
//                                   20), // Adjust the value for more rounded corners
//                             ),
//                             child: Image.network(
//                               _allResults[index]['imageUrl'],
//                               height: 100,
//                             ),
//                           ),
//                           title: Text(
//                             _resultList[index]['productName'],
//                             style: GoogleFonts.domine(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w900),
//                           ),
//                           subtitle: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ProductDetails(
//                                           name: widget.name,
//                                           email: widget.email,
//                                           Userid: widget.Userid,
//                                           contact: widget.contact,
//                                           product: _resultList[index]
//                                               ['productName'],
//                                           image: _allResults[index]['imageUrl'],
//                                           description: _resultList[index]
//                                               ['description'],
//                                           price: _resultList[index]['price'],
//                                           id: _resultList[index]
//                                               ['productId'])));
//                             },
//                             child: Text(
//                               "View",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w900),
//                             ),
//                           ),
//                           minTileHeight: 100,
//                           trailing: Text(
//                             "Rs: ${_resultList[index]['price']}",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//       // Navigation Bar
//     );
//   }
// }
