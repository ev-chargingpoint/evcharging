import 'package:flutter/material.dart';

class TentangAplikasi extends StatefulWidget {
  const TentangAplikasi({super.key});

  @override
  State<TentangAplikasi> createState() => _TentangAplikasiState();
}

class _TentangAplikasiState extends State<TentangAplikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://github.com/intern-monitoring/intern-monitoring.github.io/assets/94734096/dd65f326-7b56-4ba2-ada4-258d5c1d2b8d',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  const Center(
                    child: Text(
                      'Deskripsi Aplikasi',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 15.0),
                          Text(
                            'Aplikasi "EV Charging Point" menyediakan informasi lengkap mengenai titik pengecasan atau charging point untuk mobil listrik. Dengan menggunakan aplikasi ini, pengguna dapat dengan mudah menemukan lokasi titik pengecasan yang terdekat, sehingga memudahkan perjalanan dan penggunaan mobil listrik.',
                            style: TextStyle(fontSize: 17.0),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            " Selain itu, aplikasi ini juga menyediakan fitur untuk memulai proses pengecasan langsung melalui platform, serta informasi terkait tarif dan waktu operasional charging point.",
                            style: TextStyle(fontSize: 17.0),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            ' "EV Charging Point" juga memudahkan pengguna dalam melakukan transaksi pembayaran secara digital melalui integrasi dengan layanan keuangan, memberikan pengalaman yang efisien dan nyaman dalam menjalankan proses pengecasan mobil listrik.',
                            style: TextStyle(fontSize: 17.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Center(
                    child: Text(
                      'Developer',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 80.0,
                            backgroundImage: NetworkImage(
                              'https://github.com/intern-monitoring/intern-monitoring.github.io/assets/94734096/f618905d-8045-4bad-96b3-d9eef24de99b',
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Dimas Ardianto',
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '1214054',
                            style: TextStyle(
                                fontSize: 23.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'D4 Teknik Informatika',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Center(
                            child: Text(
                              'Universitas Logistik dan Bisnis Internasional',
                              style: TextStyle(fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 80.0,
                            backgroundImage: NetworkImage(
                              'https://github.com/ev-chargingpoint/backend-evchargingpoint/assets/94734096/8d46a912-9950-42d0-8dd0-fe1b43e30946',
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Auliana Fahrian',
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '1214049',
                            style: TextStyle(
                                fontSize: 23.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'D4 Teknik Informatika',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Center(
                            child: Text(
                              'Universitas Logistik dan Bisnis Internasional',
                              style: TextStyle(fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: SizedBox(
                width: 36.0,
                height: 70.0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.grey,
                  elevation: 0.0,
                  child: const Icon(
                    Icons.arrow_back,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
