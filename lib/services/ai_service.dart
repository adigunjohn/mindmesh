import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class AIService{
  final String? _geminiApiKey = dotenv.env['GOOGLE_API_KEY'];

  Future<String?> geminiGenerateWithText({required String prompt, String? modelName}) async {
    if (_geminiApiKey == null) {
      log('Error: GOOGLE_API_KEY not found in .env file.');
      return null;
    }
    final model = GenerativeModel(model: modelName ?? 'gemini-2.5-flash', apiKey: _geminiApiKey);
    final content = [Content.text(prompt)];
    try {
      final response = await model.generateContent(content);
      log('Gemini API Response: ${response.text}');
      return response.text;
    } on GenerativeAIException catch (e) {
      log('GenerativeAIException: $e');
      return 'Error from Gemini: ${e.message}';
    } catch (e) {
      log('Unknown error in Gemini API: $e');
      return 'An unknown error occurred.';
    }
  }

  Future<String?> geminiGenerateWithTextAndImage({required String prompt, required Uint8List imageBytes, required String imageMimeType, String? modelName,}) async {
    if (_geminiApiKey == null) {
      log('Error: GOOGLE_API_KEY not found in .env file.');
      return null;
    }
    final model = GenerativeModel(model: modelName ?? 'gemini-2.5-flash', apiKey: _geminiApiKey);
    final content = [Content.multi([TextPart(prompt), DataPart(imageMimeType, imageBytes),])];
    try {
      final response = await model.generateContent(content);
      log('Gemini API Response: ${response.text}');
      return response.text;
    } on GenerativeAIException catch (e) {
      log('GenerativeAIException: $e');
      return 'Error from Gemini: ${e.message}';
    } catch (e) {
      log('Unknown error in Gemini API: $e');
      return 'An unknown error occurred.';
    }
  }

  Future<String?> geminiGenerateFromTextAndMultimedia({required String prompt, required List<DataPart> multimediaParts, String? modelName,}) async {
    if (_geminiApiKey == null) {
      log('Error: GOOGLE_API_KEY not found in .env file.');
      return null;
    }
    final model = GenerativeModel(model: modelName ?? 'gemini-2.5-flash', apiKey: _geminiApiKey);
    final List<Part> parts = [TextPart(prompt)];
    parts.addAll(multimediaParts);
    final content = [Content.multi(parts)];
    try {
      final response = await model.generateContent(content);
      log('Gemini API Response (multimedia): ${response.text}');
      return response.text;
    } on GenerativeAIException catch (e) {
      log('GenerativeAIException: $e');
      return 'Error from Gemini: ${e.message}';
    } catch (e) {
      log('Unknown error in Gemini API: $e');
      return 'An unknown error occurred.';
    }
  }


  Future<DataPart?> convertImageToDataPart(XFile? imageFile) async {
    if (imageFile == null) {
      return null;
    }
    final Uint8List imageBytes = await imageFile.readAsBytes();
    final String? imageMimeType = lookupMimeType(imageFile.path, headerBytes: imageBytes.sublist(0, defaultMagicNumbersMaxLength));
    final String finalMimeType = imageMimeType ?? 'image/jpeg';
    return DataPart(finalMimeType, imageBytes);
  }

  Future<DataPart?> convertFileToDataPart(PlatformFile? file) async {
    if (file == null) {
      return null;
    }
    Uint8List fileBytes;
    String lookupPathOrName;
    if (file.bytes != null) {
      fileBytes = file.bytes!;
      lookupPathOrName = file.name;
    } else if (file.path != null) {
      fileBytes = await File(file.path!).readAsBytes();
      lookupPathOrName = file.path!;
    } else {
      log('Error: Could not get bytes for file ${file.name}');
      return null;
    }
    final String? fileMimeType = lookupMimeType(lookupPathOrName, headerBytes: fileBytes.sublist(0, defaultMagicNumbersMaxLength));
    final String finalMimeType = fileMimeType ?? 'application/octet-stream';
    log('File mime type: $finalMimeType');
    return DataPart(finalMimeType, fileBytes);
  }
}
