import 'package:flutter/material.dart';

void main() {
  runApp(const CourseCardApp());
}

class CourseCardApp extends StatelessWidget {
  const CourseCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            "Assignment for Module 10",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: const CourseGrid(),
      ),
    );
  }
}

class CourseGrid extends StatelessWidget {
  const CourseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      {
        "title": "Full Stack Web Development with JavaScript (MERN)",
        "image": "assets/images/mern.jpg",
        "batch": "২৬",
        "seats": "৯৬",
        "daysLeft": "৩৬",
      },
      {
        "title": "Full Stack Web Development with Python, Django & React",
        "image": "assets/images/python_django.jpg",
        "batch": "১৮",
        "seats": "৪০",
        "daysLeft": "২৫",
      },
      {
        "title": "Full Stack Web Development with ASP.Net Core",
        "image": "assets/images/aspnet.jpg",
        "batch": "১২",
        "seats": "৭৫",
        "daysLeft": "১৯",
      },
      {
        "title": "SQA: Manual & Automated Testing",
        "image": "assets/images/sqa.jpg",
        "batch": "১৫",
        "seats": "৫০",
        "daysLeft": "২৮",
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCard(
            title: course["title"]!,
            imageUrl: course["image"]!,
            batch: course["batch"]!,
            seats: course["seats"]!,
            daysLeft: course["daysLeft"]!,
          );
        },
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String batch;
  final String seats;
  final String daysLeft;

  const CourseCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.batch,
    required this.seats,
    required this.daysLeft,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: const Color.fromARGB(
            221,
            255,
            255,
            255,
          ), // ডার্ক নেভি ব্যাকগ্রাউন্ড
          borderRadius: BorderRadius.circular(12),
          border: _isHovered
              ? Border.all(color: const Color.fromARGB(0, 24, 24, 23), width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                widget.imageUrl,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Info chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoChip(
                    text: "ব্যাচ ${widget.batch}",
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(width: 4),
                  InfoChip(text: "${widget.seats} সিট বাকি"),
                  const SizedBox(width: 4),
                  InfoChip(text: "${widget.daysLeft} দিন বাকি"),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
            ),

            // Button
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(
                      color: Color(0xFF3a3d52),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "বিস্তারিত দেখি",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  final String text;
  final IconData? icon;

  const InfoChip({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: Colors.black54),
            const SizedBox(width: 3),
          ],
          Text(
            text,
            style: const TextStyle(fontSize: 11, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
