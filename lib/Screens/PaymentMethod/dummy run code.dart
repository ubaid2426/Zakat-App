  // bool isZaakat = widget.iszakat == 'true' ? true : false;

  // Record Donation
  // Future<PaymentDetail?> recordDonation() async {
  //   print(widget.donationtitle);
  //   print(widget.placeholderText);
  //   print(widget.issadqah);
  //   print(widget.iszakat);
  //   bool isZaakat = (widget.iszakat! == 'true' ? true : false);
  //   bool isSaakat = (widget.iszakat == 'true' ? true : false);
  //   List<String> placeholderValues =
  //       widget.placeholderText!.split(','); // Split by comma

  //   List<double> convertedValues = placeholderValues
  //       .map((value) =>
  //           double.tryParse(value.trim()) ??
  //           0.0) // Trim spaces and parse each value
  //       .toList();

  //   print(convertedValues); // Prints the list of doubles [2.0, 4.0, 6.0]
  //   try {
  //     String? token = await storage.read(key: 'access_token');
  //     String? donorName = await storage.read(key: 'user_name');
  //     String? donorId = await storage.read(key: 'user_id');

  //     if ([token, donorName, donorId].contains(null)) {
  //       showMessage('Error: Missing user details.');
  //       return null;
  //     }

  //     final request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('http://127.0.0.1:8000/data/donor-history/'),
  //     )
  //       // request.headers["Content-Type"] = "multipart/form-data";
  //       ..headers['Authorization'] = 'JWT $token'
  //       ..headers['Content-Type'] =
  //           'multipart/form-data' // Ensure this header is correct
  //       ..fields['donor_name'] = donorName!
  //       ..fields['donor_id'] = donorId!
  //       ..fields['is_zakat'] = isZaakat.toString()
  //       ..fields['is_sadqah'] = isSaakat.toString()
  //       // ..fields['amount'] = convertedValues.toString()
  //       ..fields['amount'] = widget.placeholderText.toString()
  //       ..fields['donation_title'] = widget.donationtitle ?? '';

  //     if (imageFile != null) {
  //       request.files.add(await http.MultipartFile.fromPath(
  //         'payment_image',
  //         imageFile!.path,
  //       ));
  //     }

  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       showMessage('Donation recorded successfully');
  //       return PaymentDetail.fromJson(jsonDecode(responseBody));
  //     } else {
  //       showMessage('Failed to record donation. Code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     showMessage('Error: $e');
  //   }
  //   return null;
  // }