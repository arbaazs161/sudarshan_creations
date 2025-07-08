library transparent_image;

import 'dart:typed_data';

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

const double mobileMinSize = 768;
const double desktopMinSize = 1024;
const mobileMinSize2 = mobileMinSize - 200;
const mobileMinSize3 = mobileMinSize + 200;
const desktopMinSize2 = desktopMinSize - 200;

class PriceTypeModel {
  static const fixedPrice = 'Fixed Price';
  static const priceRange = 'Price Range';
  static const inquiry = 'Inquiry';
}

class VariantTypeModel {
  static const inquiry = 'Inquiry';
  static const order = 'Order';
}

List<String> priceTypes = [
  PriceTypeModel.fixedPrice,
  PriceTypeModel.priceRange,
  PriceTypeModel.inquiry
];

// const splitViewMinSize = 700;
// const breakPointLarge = 1124;
// const breakPointMid = 850;
// const fontFamily2 = 'AbrilFatface';

// const imageAspectRatio = 800 / 1200;

// enum SORTBY { lowToHigh, highToLow }

// const firstOrderDiscountPercent = 10;
// const instaUrl = "https://www.instagram.com/frenyzcouture/";
// const chatLink = "https://wa.me/6352426394";
// const phoneNo = "+916352426394";
// const emailAddress = "frenyzcouture@gmail.com";

// const address =
//     "Rudraksh Complex, 102, 66, Urmi Cross Rd, Urmi Society, Nr. Haveli, Vadodara, Gujarat 390005";

// //// TEXTS
// const aboutUsText =
//     '''Frenzy is a luxury menswear brand based out of Baroda, Gujarat. Frenzy collections are minimalistic-yet-fun with a strong focus on locally sourced natural textiles. The Frenzy brand is a tribute to the modern Indian man, who refuses to take anything for granted and appreciates sustainable fashion as the new normal.\nFrenzy was born in Baroda and studied fashion from Melbourne, Australia. After over a decade of work experience in Bangalore and Mumbai, he shifted to Baroda to launch his eponymous label. His work is inspired by ‘Pura Vida’ meaning ‘pure life’ in Spanish, a Costa Rican philosophy that encourages the appreciation of life’s simple treasures''';

// const returnAndExchange = '''
// At Frenzy, each item is made only after the order has been placed online. Accordingly, we do not accept returns once the product is sold. Please Note: If the garment doesn’t fit you as per your requirement, we will be happy to exchange it to a different size. Please ensure that the garment is in perfect condition with labels intact, before you send it to us. We will send a courier to pick up your package at the address of your choice within 24-48 hours. In case of any exchanges with regards to your order, please contact us within 24 hours upon receipt of the product.
// Contact Details
// Phone: +91 98256 51258
// Email: frenyzcouture@gmail.com
// ''';
// const refundPolicy = '''
// At Frenzy, each item is made only after the order has been placed online. Accordingly, the refund option is not available for online purchases. Please Note: If there is a manufacturing defect in the product, we will be happy to refund your order. Please ensure that the garment is in perfect condition with labels intact, before you send it to us. We will send a courier to pick up your package at the address of your choice within 24-48 hours. In case of any refunds with regards to your order, please contact us within 24 hours upon receipt of the product.
// Contact Details
// Phone: +91 98256 51258
// Email: frenyzcouture@gmail.com
// ''';
// const shippingOrDeivery =
//     '''We usually take 8-10 working days to process an order. If your item is in stock, we will ship it on the next working day. Shipping within India is free. The estimated delivery time will be between 2 to 8 working days depending on the delivery address. After placing an order, you may track the status of your order in the My Account section.
// Contact Details
// Phone: +91 98256 51258
// Email: frenyzcouture@gmail.com
// ''';
