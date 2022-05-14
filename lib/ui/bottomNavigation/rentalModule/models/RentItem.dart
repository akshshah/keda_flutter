class RentItem {
  final String id;
  final String status;
  final String productName;
  final String category;
  final String pickUpTime;
  final String dropOffTime;
  final String pickUpDate;
  final String dropOffDate;
  final String price;
  final String deliveryType;
  final int type;


  const RentItem({required this.id, required this.status, required this.productName, required this.category, required this.pickUpTime,
    required this.dropOffTime,required this.pickUpDate , required this.dropOffDate, required this.price, required this.deliveryType, required this.type});
}