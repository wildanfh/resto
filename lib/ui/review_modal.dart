import 'package:flutter/material.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/model/customer_reviews.dart';
import 'package:resto_app/provider/restaurant_provider.dart';

// ignore: must_be_immutable
class ReviewModal extends StatefulWidget {
  final RestoProvider provider;
  final String id;

  const ReviewModal({
    Key? key,
    required this.provider,
    required this.id,
  }) : super(key: key);

  @override
  State<ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  late TextEditingController nameText = TextEditingController();

  late TextEditingController reviewText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: const Text("Add Review"),
      content: Form(
        key: key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: nameText,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Name required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 12, top: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                maxLines: 4,
                controller: reviewText,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Review required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Review",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 12, top: 10),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Save"),
          onPressed: () {
            if (key.currentState!.validate()) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Send..")));
              CustomerReview review = CustomerReview(
                id: widget.id,
                name: nameText.text,
                review: reviewText.text,
              );
              widget.provider.postReview(review).then((value) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Success..")));
                Navigator.pop(context);
              });
            }
          },
        ),
      ],
    );
  }
}
