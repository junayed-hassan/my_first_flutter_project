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
          title: const Text("Courses"),
          backgroundColor: Colors.deepPurple,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: _isHovered
              ? Border.all(color: Colors.deepPurple, width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Wrap(
                spacing: 6,
                children: [
                  InfoChip(text: "ব্যাচ ${widget.batch}"),
                  InfoChip(
                    text: "${widget.seats} সিট বাকি",
                    icon: Icons.event_seat,
                  ),
                  InfoChip(
                    text: "${widget.daysLeft} দিন বাকি",
                    icon: Icons.calendar_today,
                  ),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Button
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios, size: 14),
                  label: const Text("বিস্তারিত দেখি"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff2f4f7),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    textStyle: const TextStyle(fontWeight: FontWeight.w500),
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
