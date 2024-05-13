import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firstapp/api.dart';
import 'package:firstapp/createMember.dart';

final _storage = GetStorage();

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 160, 209, 250),
      appBar: AppBar(
        title: Text(
          'Member List',
          style: TextStyle(
            color: Color.fromARGB(255, 59, 166, 254),
            fontFamily: 'Pacifico',
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add,
              size: 34,
              color: const Color.fromARGB(255, 90, 90, 90),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/createMember');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '  Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Icon(Icons.search, size: 25),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getAnggota(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            int index = _storage.read('banyak_anggota');
            return Container(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: index,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 40,
                      ),
                      title: Text('${_storage.read('nama_${index + 1}')}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              getEditAnggotaDetail(
                                  context, _storage.read('id_${index + 1}'));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteMember(
                                  context, _storage.read('id_${index + 1}'));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                  title: Text(
                                    'Detail',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(20.0),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('Name'),
                                            subtitle: Text(
                                                '${_storage.read('nama_${index + 1}')}'),
                                          ),
                                        ),
                                        Card(
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('Registration Number'),
                                            subtitle: Text(
                                                '${_storage.read('nomor_induk_${index + 1}')}'),
                                          ),
                                        ),
                                        Card(
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('Telephone'),
                                            subtitle: Text(
                                                '${_storage.read('telepon_${index + 1}')}'),
                                          ),
                                        ),
                                        Card(
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('Status'),
                                            subtitle: Text(
                                                '${_storage.read('status_aktif_${index + 1}')}'),
                                          ),
                                        ),
                                        Card(
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('Address'),
                                            subtitle: Text(
                                                '${_storage.read('alamat_${index + 1}')}'),
                                          ),
                                        ),
                                        Card(
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('Date of Birth'),
                                            subtitle: Text(
                                                '${_storage.read('tgl_lahir_${index + 1}')}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
