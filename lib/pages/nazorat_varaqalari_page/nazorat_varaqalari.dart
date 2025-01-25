import 'package:e_hujjat/common/provider/change_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NazoratVaraqalari extends StatelessWidget {
  const NazoratVaraqalari({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .updatePageByRoute('nazoratVaraqasiQoshishPage');
              },
              child: Text('Nazorat varaqasi qo\'shish'),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Qidiring',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(
                        value: 'Barchasi', child: Text('Barchasi')),
                    DropdownMenuItem(value: 'Yangi', child: Text('Yangi')),
                    DropdownMenuItem(
                        value: 'Qabul qilingan', child: Text('Qabul qilingan')),
                  ],
                  onChanged: (value) {},
                  hint: const Text('Filtrlash'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Cards section
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: 9, // Example item count
                itemBuilder: (context, index) {
                  return _buildCard(index);
                },
              ),
            ),
            // Pagination section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                ...List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: Text('${index + 1}'),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${index + 25}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                // SvgPicture.asset(
                //   'assets/icons/high_priority.svg',
                //   width: 20,
                //   height: 20,
                // ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Ijro uchun mas’ul: A. Kadirov',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Hujjatning nomlanishi: Qomondonning buyruq #2025',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 5),
            const Text(
              'Ijro muddati: 01.04.2025',
              style: TextStyle(fontSize: 12),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Batafsil'),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Yangi',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
