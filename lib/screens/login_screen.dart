import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible=false;
  bool isLoading = false;
  Future<void> _loginUser() async{
    setState(() {
      isLoading=true;
    });
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password
      );
      final data = response.user;
      
      if(data!=null){
        final existing =await Supabase.instance.client.from("profile").select().eq("id", data.id).single();
        print(existing["role"]);
        if(mounted){
          _showSuccessDialogbox();
          if(existing["role"]=="Student"){
            context.go('/student/home');
          }
          else{
            context.go('/admin/home');
          }
        }  
      }
    }on AuthException catch(e){
      _showErrorDialogbox(e.message);
    }
    catch(e){
      print("Error: $e");
    }
    finally{
      setState(() {
        isLoading=false;
      });
    } 
  }
  void _showSuccessDialogbox(){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Login Successful"),
        actions: [
          TextButton(
            onPressed: () async{
              final data = Supabase.instance.client.auth.currentUser?.id;
              if(data==null){
                print("User not logged in");
                return;
              }
              try{
                final existing = await Supabase.instance.client.from("profile").select().eq('id', data).single();
                final role = existing["role"];
              if (role == "admin") {
                context.go("/admin/home");
              } else if (role == "student") {
                context.go("/student/home");
              }
              }
              catch(e){
                print("Error: $e");
              }
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
  void _showErrorDialogbox(String message){
    showDialog(context: context, builder: (_)=>AlertDialog(
      title: Text("something went wrong $message"),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Ok"))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 45),
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [const Color.fromARGB(255, 84, 18, 197),Color.fromARGB(255, 144, 115, 224)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                    ),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Icon(Icons.calendar_month,size: 30.0,color: Colors.white,),
                ),
              ),
              SizedBox(height: 10,),
              Text("Eventify", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              SizedBox(height: 10,),
              Text("Campus Events Made Simple", style: TextStyle(color: Colors.grey[700]),),
              SizedBox(height: 40,),
              Align(alignment: Alignment.centerLeft,child: Text("Welcome Back 👋", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)),
              SizedBox(height: 5,),
              Align(alignment: Alignment.centerLeft,child: Text("Sign in to explore campus events", style: TextStyle(color: Colors.grey[700]),)),
              SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey)
                  ),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email Address",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey)
                  )
                ),  
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey)
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      isPasswordVisible= !isPasswordVisible;
                    });
                  },icon:isPasswordVisible? Icon(Icons.visibility):Icon(Icons.visibility_off)  ),
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color:  Colors.grey)
                  )
                ),  
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: [const Color.fromARGB(255, 84, 18, 197),Color.fromARGB(255, 144, 115, 224)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight
                  )
                ),
                child: ElevatedButton(
                  onPressed: (){
                    _loginUser();  
                  }, 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.transparent),
                  child: Text("Sign In",style: TextStyle(color: Colors.white),))
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: TextStyle(color: Colors.grey[800]),),
                  TextButton(
                    onPressed: (){
                      context.go('/register');
                    },
                    child: Text("Register Here",style: TextStyle(color: const Color.fromARGB(255, 94, 63, 197)),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}