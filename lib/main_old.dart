import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('expenseBox');

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Box box = Hive.box('expenseBox');

  double totalIncome = 0;
  double totalExpense = 0;
  double totalBalance = 0;

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController amountController =
      TextEditingController();

  bool isIncome = false;

  String selectedCategory = "Food";

  List<Map<String, dynamic>> transactions = [];

  final List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Salary",
    "Entertainment",
    "Education",
    "Health",
    "Bills",
  ];

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('expenseBox');

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Box box = Hive.box('expenseBox');

  double totalIncome = 0;
  double totalExpense = 0;
  double totalBalance = 0;

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController amountController =
      TextEditingController();

  bool isIncome = false;

  String selectedCategory = "Food";

  List<Map<String, dynamic>> transactions = [];

  final List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Salary",
    "Entertainment",
    "Education",
    "Health",
    "Bills",
  ];
  
void addTransaction() {
  if (titleController.text.isEmpty ||
      amountController.text.isEmpty) {
    return;
  }

  double amount =
      double.tryParse(amountController.text) ?? 0;

  setState(() {
    transactions.add({
      "title": titleController.text,
      "amount": amount,
      "isIncome": isIncome,
      "category": selectedCategory,
    });

    if (isIncome) {
      totalIncome += amount;
    } else {
      totalExpense += amount;
    }

    totalBalance = totalIncome - totalExpense;
  });

  setState(() {
  transactions.add({
    "title": titleController.text,
    "amount": amount,
    "isIncome": isIncome,
    "category": selectedCategory,
  });

  if (isIncome) {
    totalIncome += amount;
  } else {
    totalExpense += amount;
  }

  totalBalance = totalIncome - totalExpense;
});

box.put("transactions", transactions);

titleController.clear();
amountController.clear();

Navigator.pop(context);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Card(
              elevation: 5,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(

                  children: [

                    const Text(
                      "Total Balance",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "₹ ${totalBalance.toStringAsFixed(2)}",

                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(

              children: [

                Expanded(

                  child: Card(
                    color: Colors.green.shade100,

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(

                        children: [

                          const Text("Income"),

                          const SizedBox(height: 10),

                          Text(
                            "₹ ${totalIncome.toStringAsFixed(2)}",

                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(

                  child: Card(
                    color: Colors.red.shade100,

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(

                        children: [

                          const Text("Expense"),

                          const SizedBox(height: 10),

                          Text(
                            "₹ ${totalExpense.toStringAsFixed(2)}",

                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Expanded(
  child: transactions.isEmpty
      ? const Center(
          child: Text(
            "No Transactions Yet",
            style: TextStyle(fontSize: 18),
          ),
        )
      : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final item = transactions[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: item["isIncome"]
                      ? Colors.green
                      : Colors.red,
                  child: Icon(
                    item["isIncome"]
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
                title: Text(item["title"]),
                subtitle: Text(item["category"]),
                trailing: Text(
                  "₹ ${item["amount"]}",
                  style: TextStyle(
                    color: item["isIncome"]
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
),

          ],
        ),
      ),

     floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.deepPurple,
  child: const Icon(Icons.add, color: Colors.white),
  onPressed: () {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Transaction"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<bool>(
                title: const Text("Income"),
                value: true,
                groupValue: isIncome,
                onChanged: (value) {
                  setState(() {
                    isIncome = value!;
                  });
                },
              ),
              RadioListTile<bool>(
                title: const Text("Expense"),
                value: false,
                groupValue: isIncome,
                onChanged: (value) {
                  setState(() {
                    isIncome = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Category",
                ),
                items: categories.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: addTransaction,
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
},
),
void addTransaction() {
  if (titleController.text.isEmpty ||
      amountController.text.isEmpty) {
    return;
  }

  double amount =
      double.tryParse(amountController.text) ?? 0;

  setState(() {
    transactions.add({
      "title": titleController.text,
      "amount": amount,
      "isIncome": isIncome,
      "category": selectedCategory,
    });

    if (isIncome) {
      totalIncome += amount;
    } else {
      totalExpense += amount;
    }

    totalBalance = totalIncome - totalExpense;
  });

  box.put("transactions", transactions);

  titleController.clear();
  amountController.clear();

  Navigator.pop(context);
}
    );
  }
}
void addTransaction() {
  if (titleController.text.isEmpty ||
      amountController.text.isEmpty) {
    return;
  }

  double amount =
      double.tryParse(amountController.text) ?? 0;

  setState(() {
    transactions.add({
      "title": titleController.text,
      "amount": amount,
      "isIncome": isIncome,
      "category": selectedCategory,
    });

    if (isIncome) {
      totalIncome += amount;
    } else {
      totalExpense += amount;
    }

    totalBalance = totalIncome - totalExpense;
  });

  box.put("transactions", transactions);

  titleController.clear();
  amountController.clear();

  Navigator.pop(context);
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Card(
              elevation: 5,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(

                  children: [

                    const Text(
                      "Total Balance",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "₹ ${totalBalance.toStringAsFixed(2)}",

                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(

              children: [

                Expanded(

                  child: Card(
                    color: Colors.green.shade100,

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(

                        children: [

                          const Text("Income"),

                          const SizedBox(height: 10),

                          Text(
                            "₹ ${totalIncome.toStringAsFixed(2)}",

                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(

                  child: Card(
                    color: Colors.red.shade100,

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(

                        children: [

                          const Text("Expense"),

                          const SizedBox(height: 10),

                          Text(
                            "₹ ${totalExpense.toStringAsFixed(2)}",

                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Expanded(
  child: transactions.isEmpty
      ? const Center(
          child: Text(
            "No Transactions Yet",
            style: TextStyle(fontSize: 18),
          ),
        )
      : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final item = transactions[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: item["isIncome"]
                      ? Colors.green
                      : Colors.red,
                  child: Icon(
                    item["isIncome"]
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
                title: Text(item["title"]),
                subtitle: Text(item["category"]),
                trailing: Text(
                  "₹ ${item["amount"]}",
                  style: TextStyle(
                    color: item["isIncome"]
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
),

          ],
        ),
      ),

     floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.deepPurple,
  child: const Icon(Icons.add, color: Colors.white),
  onPressed: () {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Transaction"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<bool>(
                title: const Text("Income"),
                value: true,
                groupValue: isIncome,
                onChanged: (value) {
                  setState(() {
                    isIncome = value!;
                  });
                },
              ),
              RadioListTile<bool>(
                title: const Text("Expense"),
                value: false,
                groupValue: isIncome,
                onChanged: (value) {
                  setState(() {
                    isIncome = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Category",
                ),
                items: categories.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: addTransaction,
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
},
),

    );
  }
}
