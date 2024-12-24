import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai/data/model/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'theme_notifier.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final List<Message> messages = [
    // Message('Hello', true),
    // Message('Hi', false),
    // Message('How are you', true),
    // Message('I am fine', false),
  ];
 bool isLoading=false;
  final editingController = TextEditingController();
  var apiKey=dotenv.env['API_KEY'];
   var scrollController = ScrollController();
   @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  
callGeminiAI() async {
  try {
    if (editingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a question'),
        ),
      );
    } else {
      messages.add(Message(editingController.text.trim(), true));
      scroolDown();
      setState(() {
        isLoading = true;
      });
      final model = GenerativeModel(model: "gemini-1.5-flash-latest", apiKey: apiKey!);
      var prompt = editingController.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      var text = response.text;
      setState(() {
        isLoading = false;
        messages.add(Message(text!, false));
        editingController.clear();
      });
      scroolDown();
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

void scroolDown() {
  if (scrollController.hasClients) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

  
  
  @override
  Widget build(BuildContext context) {
  final  currentTheme = ref.watch(themeProvider);
    final isDarkMode = currentTheme == ThemeMode.dark;
 
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: false,
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/gpt-robot.png', width: 50, height: 50),
                Text(
                  'GPT-3',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                ref.read(themeProvider.notifier).toggleTheme();  // Tema değişimi
                isDarkMode ? debugPrint('Dark Mode') : debugPrint('Light Mode');
              
              },
              child: Image.asset(
                isDarkMode ? 'assets/moon-light.png' : 'assets/moon-dark.png', // İkon durumu
                width: 30,
                height: 30,
               
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message.isUser;
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft: Radius.circular(isUser ? 10 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 10),
                      ),
                    ),
                    child: Text(
                      message.text,
                      textAlign: isUser ? TextAlign.right : TextAlign.left,
                      style: isUser
                          ? Theme.of(context).textTheme.titleSmall
                          : Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 32, top: 16),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ]),
              child: Row(
                children: [
                  InputWidget(editingController: editingController),
                  SizedBox.square(
                    dimension: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: callGeminiAI,
                      child:isLoading? SizedBox
                        (width: 30,
                        height: 30,
                          child: CircularProgressIndicator(color: Colors.blue,)):  Image.asset('assets/send.png', width: 50, height: 50),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.editingController,
  });

  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
       style: Theme.of(context).textTheme.titleSmall,
        controller: editingController,
        decoration: const InputDecoration(
          hintText: 'Enter your message',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }
}
