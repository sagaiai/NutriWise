import 'package:google_generative_ai/google_generative_ai.dart' as gemini;

const String _temporaryApiKey = 'AIzaSyAfOEeG8L_cVugUAK0VzaZ6EZsuUgg90WI';

class Apigemini {
  final gemini.GenerativeModel? model;

  final String apiKey = _temporaryApiKey;

  Apigemini()
    : model = _temporaryApiKey.isNotEmpty
          ? gemini.GenerativeModel(
              model: 'gemini-2.5-flash',
              apiKey: _temporaryApiKey,
              systemInstruction: gemini.Content.system(
                "You are a specialized assistant for calculating calorie information. When the user provides any food or drink name — even if it contains spelling mistakes or is partially written — infer the most likely intended item and respond only with the approximate number of calories followed by the word 'Calories'. Example: '150 Calories'. Do not include any other text, symbols, or explanation. If the query is unrelated to food or beverages, reply exactly with: 'I am only specialized in calorie-related queries.'",
              ),
            )
          : null {
    if (model == null) {
      print(
        "Error: API Key is missing or invalid. Gemini model not initialized.",
      );
    }
  }

  Future<String?> sendpromtTogemnini(String prompt) async {
    if (model == null) {
      print("Error: Gemini model is not initialized. Cannot send prompt.");
      return null;
    }

    final content = [gemini.Content.text(prompt)];

    try {
      final response = await model!.generateContent(content);
      print(response.text);
      return response.text;
    } catch (e) {
      print('Error generating content: $e');
    }
  }
}
