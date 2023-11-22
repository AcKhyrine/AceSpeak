import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../HOME/student_classroom.dart';


class UpdateAvatar extends StatefulWidget {
  final String userId;
  const UpdateAvatar({super.key, required this.userId});

  @override
  State<UpdateAvatar> createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  int currentPage = 1; 
  int selectedAvatar = 1;
  int avatar = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
              children: [
                Container(
                  width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/avatar/avatar screen.png'),
                    fit: BoxFit.cover, 
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(child: Text('Choose your Avatar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * .03, color: Color.fromARGB(255, 3, 101, 31)),)),
                      Padding(
              padding: EdgeInsets.only(left: screenWidth * .12, right: screenWidth * .12,),
              child: Column(
                children: [
                  Container(
                    height: screenWidth * .55,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: 3, 
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page + 1; 
                        });
                      },
                      itemBuilder: (context, index) {
                        return currentPage == 1 ?
                        Row(
                        children: [
                          Column(
                          children: [
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 1;
                                });
                              },
                              child: Container(
                                width: screenWidth * .26,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 1
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a1.png', width: screenWidth * .24,),
                              )
                              ),
                    
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 2;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 2
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a2.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 3;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 3
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a3.png', width: screenWidth * .24,),
                              )
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 4;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 4
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a4.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 5;
                                });
                              },
                              child: Container(
                               width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 5
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a5.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 6;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 6
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a6.png', width: screenWidth * .24,),
                              )
                              ),
                          ],
                        ),
                          ],
                        ) 
                        ] ) :  currentPage == 2 ? 
                         Row(
                        children: [
                          Column(
                          children: [
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 7;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 7
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a7.png', width: screenWidth * .24,),
                              )
                              ),
                    
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 8;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 8
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a8.png',width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 9;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 9
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a9.png', width: screenWidth * .24,),
                              )
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 10;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 10
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a10.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 11;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 11
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a11.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 12;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 12
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a12.png', width: screenWidth * .24,),
                              )
                              ),
                          ],
                        ),
                          ],
                        ) 
                        ] ) :  Row(
                        children: [
                          Column(
                          children: [
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 13;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 13
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a13.png', width: screenWidth * .24,),
                              )
                              ),
                    
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 14;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 14
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a14.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 15;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 15
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a15.png', width: screenWidth * .24,),
                              )
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 16;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 16
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a16.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 17;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 17
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a17.png', width: screenWidth * .24,),
                              )
                              ),
                              GestureDetector(
                              onTap: (){
                                setState(() {
                                  avatar = 18;
                                });
                              },
                              child: Container(
                                width: screenWidth * .24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: avatar == 18
                                      ? [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 3, 101, 31).withOpacity(0.3), 
                                            spreadRadius: 5,
                                            blurRadius: 7, 
                                            offset: Offset(0, 3), 
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Image.asset('assets/avatar/a18.png', width: screenWidth * .24,),
                              )
                              ),
                          ],
                        ),
                          ],
                        ) 
                        ] );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * .01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, color: currentPage == 1 ? Colors.green : Colors.grey, size:  currentPage == 1 ? 20 : 15,),
                        Icon(Icons.circle, color: currentPage == 2 ? Colors.green : Colors.grey, size: currentPage == 2 ? 20 : 15, ),
                        Icon(Icons.circle, color: currentPage == 3 ? Colors.green : Colors.grey, size: currentPage == 3 ? 20 : 15, )
                      ],
                    ),
                ],
              ),
            ), 
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * .15, right:screenWidth * .15,),
                        child: ElevatedButton(
                          onPressed: () async {
                            if(avatar ==0 ){
                              EasyLoading.showError('Please Choose your avatar');
                            }else{
                              await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.userId)
                              .update({
                                'avatar': avatar,
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                          return ClassRoomScreen(userId: widget.userId);
                          }));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Done'),
                        ),
                      ),
                      SizedBox(height: screenHeight * .08,)
                    ],
                  ),
                )
              ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                          return ClassRoomScreen(userId: widget.userId);
                          }));
                      },
                    ),
                  ),
              ],
            ),
    );
  }
}