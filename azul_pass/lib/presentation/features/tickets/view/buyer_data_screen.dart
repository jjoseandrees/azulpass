import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../../domain/entities/buyer_entity.dart';

class BuyerDataScreen extends StatefulWidget {
  final String matchId;
  const BuyerDataScreen({super.key, required this.matchId});

  @override
  State<BuyerDataScreen> createState() => _BuyerDataScreenState();
}

class _BuyerDataScreenState extends State<BuyerDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _rutController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _hasHinchasRegistry = false;
  bool _acceptsTerms = false;

  @override
  void dispose() {
    _rutController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus datos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Resumen de la compra
            _buildPurchaseSummary(),
            const SizedBox(height: 24),
            
            const Text(
              'Datos del comprador',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Campo RUT
            TextFormField(
              controller: _rutController,
              decoration: const InputDecoration(
                labelText: 'RUT',
                hintText: '12.345.678-9',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _RutInputFormatter(),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu RUT';
                }
                if (value.length < 9) {
                  return 'RUT inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Campo Nombre
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Campo Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'tu@email.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu email';
                }
                if (!value.contains('@')) {
                  return 'Email inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Campo Teléfono
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                hintText: '+56 9 1234 5678',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu teléfono';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // Checkbox Registro de Hinchas
            CheckboxListTile(
              title: const Text('Tengo Registro Nacional de Hinchas'),
              subtitle: const Text('Requisito obligatorio para ingresar al estadio'),
              value: _hasHinchasRegistry,
              activeColor: AppColors.primaryBlue,
              onChanged: (value) {
                setState(() {
                  _hasHinchasRegistry = value ?? false;
                });
              },
            ),
            const SizedBox(height: 8),
            
            // Checkbox Términos
            CheckboxListTile(
              title: const Text('Acepto términos y condiciones'),
              subtitle: const Text('Políticas de compra y devolución'),
              value: _acceptsTerms,
              activeColor: AppColors.primaryBlue,
              onChanged: (value) {
                setState(() {
                  _acceptsTerms = value ?? false;
                });
              },
            ),
            const SizedBox(height: 32),
            
            // Botón de continuar al pago
            PrimaryButton(
              label: 'Continuar al pago',
              icon: Icons.payment,
              onPressed: _formKey.currentState?.validate() == true && 
                         _hasHinchasRegistry && 
                         _acceptsTerms
                ? () => _proceedToPayment()
                : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen de compra',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 8),
          // Aquí podrías mostrar el sector y cantidad seleccionados
          // Por ahora lo dejamos simple
          Text('Partido: U vs Everton'),
          Text('Sector: Galería Andes'),
          Text('Cantidad: 2 entradas'),
          Text('Total: \$30.000', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _proceedToPayment() {
    final buyer = BuyerEntity(
      rut: _rutController.text,
      fullName: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      hasHinchasRegistry: _hasHinchasRegistry,
    );

    context.push('/partidos/${widget.matchId}/pago', extra: buyer);
  }
}

/// Formatter personalizado para el RUT (XX.XXX.XXX-X)
class _RutInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;
    
    // Eliminar puntos y guión previos
    text = text.replaceAll('.', '').replaceAll('-', '');
    
    // Agregar puntos y guión
    if (text.length > 1) {
      String rut = '';
      for (int i = 0; i < text.length - 1; i++) {
        if (i > 0 && (text.length - 1 - i) % 3 == 0) {
          rut = '.$rut';
        }
        rut = '$rut${text[i]}';
      }
      rut = '$rut-${text[text.length - 1]}';
      text = rut;
    }
    
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}