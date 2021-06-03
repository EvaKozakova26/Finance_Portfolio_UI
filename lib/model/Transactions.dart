class RecentTransaction {
  final String? title, date, transactionValue, marketPrice, amount;

  RecentTransaction({this.marketPrice, this.amount, this.title, this.date, this.transactionValue});
}

List mockRecentTransactions = [
  RecentTransaction(
    marketPrice: "1183999 Kč / 55288",
    amount: "0.00168919",
    title: "Bitcoin",
    date: "01-03-2021",
    transactionValue: "2000 / 93",
  ),
  RecentTransaction(
    marketPrice: "1183999 Kč / 55288",
    amount: "0.00168919",
    title: "Bitcoin",
    date: "27-02-2021",
    transactionValue: "2000 / 93",
  ),
  RecentTransaction(
    marketPrice: "1183999 Kč / 55288",
    amount: "0.00168919",
    title: "Bitcoin",
    date: "23-02-2021",
    transactionValue: "2000 / 93",
  ),
  RecentTransaction(
    marketPrice: "1183999 Kč / 55288",
    amount: "0.00168919",
    title: "Bitcoin",
    date: "21-02-2021",
    transactionValue: "2000 / 93",
  ),
  RecentTransaction(
    marketPrice: "1183999 Kč / 55288",
    amount: "0.00168919",
    title: "Bitcoin",
    date: "23-02-2021",
    transactionValue: "2000 / 93",
  ),
];