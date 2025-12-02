import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:penverse/core/store/app_state.dart';
import 'package:penverse/features/home/services/home/payment_viewmodel.dart';
import '../../../../core/constants/app_colors.dart';

class PaymentPage extends StatefulWidget {
  final String bookId;

  const PaymentPage({
    super.key,
    required this.bookId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = 'Card';
  final TextEditingController _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PaymentViewModel>(
      converter: (store) => PaymentViewModel.fromStore(store),
      builder: (context, vm) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            title: const Text('Payment Gateway'),
            centerTitle: true,
            backgroundColor: AppColors.scaffoldBackground,
            foregroundColor: const Color.fromARGB(255, 220, 220, 234),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal'),
                              Text('₹1,200'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax'),
                              Text('₹60'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₹1,260',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 203, 204, 210),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Payment Method',
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentMethodOption('Card', Icons.credit_card),
                  _buildPaymentMethodOption('UPI', Icons.qr_code),
                  _buildPaymentMethodOption('Wallet', Icons.account_balance_wallet),

                  const SizedBox(height: 20),

                  TextField(
                    controller: _promoController,
                    decoration: InputDecoration(
                      labelText: 'Promo Code',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.check_circle_outline),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.scaffoldBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        vm.payment(widget.bookId);
                      },
                      child: const Text(
                        'Pay Now ₹1,260',
                        style: TextStyle(
                          fontSize: 18, 
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: 18, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        'Secure Payment • 256-bit SSL',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethodOption(String label, IconData icon) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(icon, color: Colors.indigo),
      title: Text(label),
      trailing: Radio<String>(
        value: label,
        groupValue: _selectedMethod,
        activeColor: const Color.fromARGB(255, 223, 223, 229),
        onChanged: (value) {
          setState(() {
            _selectedMethod = value!;
          });
        },
      ),
      tileColor: 
        _selectedMethod == label ? AppColors.scaffoldBackground : null,
      onTap: () {
        setState(() {
          _selectedMethod = label;
        });
      },
    );
  }
}
