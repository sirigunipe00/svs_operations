import 'package:flutter/material.dart';
import 'package:svs_operations/features/tube_cutting/presentation/qr_scanner_screen.dart';

class TubeCuttingWorkStationScreen extends StatefulWidget {
  final String machineName;

  const TubeCuttingWorkStationScreen({
    super.key,
    this.machineName = 'Machine 01',
  });

  @override
  State<TubeCuttingWorkStationScreen> createState() =>
      _TubeCuttingWorkStationScreenState();
}

class _TubeCuttingWorkStationScreenState
    extends State<TubeCuttingWorkStationScreen> {
  String? selectedItem;
  String? startImage;
  String? endImage;
  String? binQrCode;

  final TextEditingController itemCountController = TextEditingController();

  int selectedBottomIndex = 0;

  @override
  void dispose() {
    itemCountController.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // SUBMIT
  // ----------------------------------------------------------

  void _submitOperation() {
    final itemCount = itemCountController.text.trim();

    if (selectedItem == null) {
      _showMessage('Please select an item');
      return;
    }

    if (itemCount.isEmpty) {
      _showMessage('Please enter item count');
      return;
    }

    if (startImage == null) {
      _showMessage('Please capture start image');
      return;
    }

    if (endImage == null) {
      _showMessage('Please capture end image');
      return;
    }

    if (binQrCode == null) {
      _showMessage('Please scan Bin QR Code');
      return;
    }

    // TODO: Call your Cubit/API here.

    debugPrint('Machine: ${widget.machineName}');
    debugPrint('Item: $selectedItem');
    debugPrint('Item Count: $itemCount');
    debugPrint('Start Image: $startImage');
    debugPrint('End Image: $endImage');
    debugPrint('Bin QR: $binQrCode');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tube Cutting Work Station',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // _buildAppBar(),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        17,
                        12,
                        17,
                        10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildWorkStationTitle(),
                          const SizedBox(height: 20),
                          _buildSelectionSection(),
                          const SizedBox(height: 20),
                          _buildMachineCounterSection(),
                          const SizedBox(height: 20),
                          _buildItemCount(),
                          const SizedBox(height: 20),
                          _buildVerificationSection(),
                          const SizedBox(height: 20),
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // APP BAR
  // ----------------------------------------------------------

  Widget _buildAppBar() {
    return Container(
      height: 86,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 28,
              color: Color(0xFF63748E),
            ),
          ),
          const SizedBox(width: 18),
          const Text(
            'Tube Cutting Work Station',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Color(0xFF63748E),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // WORK STATION TITLE
  // ----------------------------------------------------------

  Widget _buildWorkStationTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'WORK STATION',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF85888D),
          ),
        ),
        SizedBox(height: 1),
        Text(
          'Tube Cutting Work Station',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.15,
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // SELECTION DETAILS
  // ----------------------------------------------------------

  Widget _buildSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECTION DETAILS',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF85888D),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: const Color(0xFFD5D5D5),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              // Machine
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Row(
                    children: [
                      const Text(
                        'Machine',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.machineName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF087EFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFDADADA),
              ),

              // Item List
              InkWell(
                onTap: _selectItem,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(17),
                  bottomRight: Radius.circular(17),
                ),
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 23,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Item List',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          selectedItem ?? 'Select Item',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: selectedItem == null
                                ? const Color(0xFF929297)
                                : const Color(0xFF087EFF),
                          ),
                        ),
                        const SizedBox(width: 7),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 29,
                          color: Color(0xFF929297),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // ITEM SELECTION
  // ----------------------------------------------------------

  void _selectItem() {
    final items = [
      'Item 001',
      'Item 002',
      'Item 003',
      'Item 004',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              const Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              ...items.map(
                (item) {
                  return ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    trailing: selectedItem == item
                        ? const Icon(
                            Icons.check,
                            color: Color(0xFF087EFF),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                      });

                      Navigator.pop(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ----------------------------------------------------------
  // MACHINE COUNTER PHOTO
  // ----------------------------------------------------------

  Widget _buildMachineCounterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MACHINE COUNTER PHOTO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF85888D),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: _buildPhotoCard(
                title: 'Start Image',
                imagePath: startImage,
                onTap: () => _captureImage(isStart: true),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _buildPhotoCard(
                title: 'End Image',
                imagePath: endImage,
                onTap: () => _captureImage(isStart: false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhotoCard({
    required String title,
    required String? imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: const Color(0xFFD5D5D5),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath == null)
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF1F2F7),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                  color: Color(0xFF087EFF),
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imagePath,
                  width: 26,
                  height: 26,
                  fit: BoxFit.cover,
                ),
              ),

            // const SizedBox(height: 17),

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF087EFF),
              ),
            ),

            const SizedBox(height: 3),

            const Text(
              'Tap to capture',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF929297),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // CAPTURE IMAGE
  // ----------------------------------------------------------

  Future<void> _captureImage({
    required bool isStart,
  }) async {
    // TODO:
    //
    // Use image_picker here:
    //
    // final picker = ImagePicker();
    // final image = await picker.pickImage(
    //   source: ImageSource.camera,
    // );
    //
    // if (image != null) {
    //   setState(() {
    //     if (isStart) {
    //       startImage = image.path;
    //     } else {
    //       endImage = image.path;
    //     }
    //   });
    // }

    _showMessage(
      isStart ? 'Open camera for Start Image' : 'Open camera for End Image',
    );
  }

  // ----------------------------------------------------------
  // ITEM COUNT
  // ----------------------------------------------------------

  Widget _buildItemCount() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 0.5,
        ),
      ),
      child: TextField(
        controller: itemCountController,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF168FD2),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
          ),
          hintText: 'Item Count',
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF168FD2),
          ),
          suffixText: 'Pcs.',
          suffixStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF168FD2),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // VERIFICATION
  // ----------------------------------------------------------

  Widget _buildVerificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'VERIFICATION',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF85888D),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _scanBinQr,
          borderRadius: BorderRadius.circular(17),
          child: Container(
            height: 113,
            padding: const EdgeInsets.symmetric(horizontal: 23),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: const Color(0xFFD5D5D5),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    size: 38,
                    color: Color(0xFF087EFF),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        binQrCode ?? 'Scan Bin QR Code',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Complete scan to verify and submit',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF929297),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                  color: Color(0xFF929297),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _scanBinQr() async {
    // Navigate to your QR scanner here.
    //
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const QrScannerScreen(),
      ),
    );
    //
    // if (result != null) {
    //   setState(() {
    //     binQrCode = result;
    //   });
    // }

    setState(() {
      binQrCode = 'BIN-001';
    });
  }

  // ----------------------------------------------------------
  // SUBMIT BUTTON
  // ----------------------------------------------------------

  Widget _buildSubmitButton() {
    final bool enabled = selectedItem != null &&
        itemCountController.text.isNotEmpty &&
        startImage != null &&
        endImage != null &&
        binQrCode != null;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _submitOperation,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? const Color(0xFF687A96) : const Color(0xFF687A96),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Submit Operation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // BOTTOM NAVIGATION
  // ----------------------------------------------------------

  Widget _buildBottomNavigation() {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE1E5EB),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildBottomItem(
              icon: Icons.home_rounded,
              label: 'Home',
              index: 0,
            ),
          ),
          Expanded(
            child: _buildBottomItem(
              icon: Icons.dashboard_rounded,
              label: 'Dashboard',
              index: 1,
            ),
          ),
          Expanded(
            child: _buildBottomItem(
              icon: Icons.account_circle_rounded,
              label: 'Profile',
              index: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = selectedBottomIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedBottomIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: selected ? const Color(0xFF168FD2) : const Color(0xFF91A0B8),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              color:
                  selected ? const Color(0xFF168FD2) : const Color(0xFF687A96),
            ),
          ),
        ],
      ),
    );
  }
}
