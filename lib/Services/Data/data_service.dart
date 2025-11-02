import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logos_messenger/Models/account.dart';
import 'package:logos_messenger/Models/chat.dart';
import 'package:logos_messenger/Models/conversation.dart';
import 'package:logos_messenger/Services/Data/api_helper.dart';

/// A service class for accessing the Logos Messenger REST API.
class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;

  late final String _baseUrl;
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  DataService._internal() {
    final envBaseUrl = dotenv.env['API_BASE_URL'];
    if (envBaseUrl == null || envBaseUrl.isEmpty) {
      throw Exception('API_BASE_URL not found in .env file');
    }

    // Ensure trailing slash is removed to avoid double slashes in URLs
    _baseUrl = envBaseUrl.endsWith('/') ? envBaseUrl.substring(0, envBaseUrl.length - 1) : envBaseUrl;
  }

  // --- helper getter
  String get baseUrl => _baseUrl;

  // ---------------------------------------------------------------------------
  // ACCOUNTS
  // ---------------------------------------------------------------------------

  Future<Account> createAccount(Account account) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/accounts'),
      headers: _defaultHeaders,
      body: jsonEncode(account.toJson()),
    );
    return handleResponse<Account, Account>(res, fromJson: Account.fromJson);
  }

  Future<Account> updateAccount(Account account) async {
    final res = await http.put(
      Uri.parse('$_baseUrl/accounts'),
      headers: _defaultHeaders,
      body: jsonEncode(account.toJson()),
    );
    return handleResponse<Account, Account>(res, fromJson: Account.fromJson);
  }

  Future<Account> getAccountByUserName(String username) async {
    final res = await http.get(Uri.parse('$_baseUrl/accounts/$username'), headers: _defaultHeaders);
    return handleResponse<Account, Account>(res, fromJson: Account.fromJson);
  }

  Future<Account> getAccountByEmail(String email) async {
    final res = await http.get(Uri.parse('$_baseUrl/accounts/byEmail/$email'), headers: _defaultHeaders);
    return handleResponse<Account, Account>(res, fromJson: Account.fromJson);
  }

  Future<Account> getAccountByPhone(String phone) async {
    final res = await http.get(Uri.parse('$_baseUrl/accounts/byPhone/$phone'), headers: _defaultHeaders);
    return handleResponse<Account, Account>(res, fromJson: Account.fromJson);
  }

  Future<List<Account>> getAllAccounts() async {
    final res = await http.get(Uri.parse('$_baseUrl/accounts'), headers: _defaultHeaders);
    return handleResponse<List<Account>, Account>(res, fromJson: Account.fromJson);
  }

  Future<void> deleteAccount(String id, String username) async {
    final res = await http.delete(Uri.parse('$_baseUrl/accounts/$id/$username'), headers: _defaultHeaders);
    handleResponse<void, void>(res);
  }

  // ---------------------------------------------------------------------------
  // CONVERSATIONS
  // ---------------------------------------------------------------------------

  Future<Conversation> createConversation(Conversation conversation) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/conversations'),
      headers: _defaultHeaders,
      body: jsonEncode(conversation.toJson()),
    );
    return handleResponse<Conversation, Conversation>(res, fromJson: Conversation.fromJson);
  }

  Future<Conversation> updateConversation(Conversation conversation) async {
    final res = await http.put(
      Uri.parse('$_baseUrl/conversations'),
      headers: _defaultHeaders,
      body: jsonEncode(conversation.toJson()),
    );
    return handleResponse<Conversation, Conversation>(res, fromJson: Conversation.fromJson);
  }

  Future<Conversation> getConversation(String id, String conversationId) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/conversations/$id/$conversationId'),
      headers: _defaultHeaders,
    );
    return handleResponse<Conversation, Conversation>(res, fromJson: Conversation.fromJson);
  }

  Future<List<Conversation>> getAllConversations() async {
    final res = await http.get(Uri.parse('$_baseUrl/conversations'), headers: _defaultHeaders);
    return handleResponse<List<Conversation>, Conversation>(res, fromJson: Conversation.fromJson);
  }

  Future<List<Conversation>> getConversationsByParticipant(String participantId) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/conversations/participant/$participantId'),
      headers: _defaultHeaders,
    );
    return handleResponse<List<Conversation>, Conversation>(res, fromJson: Conversation.fromJson);
  }

  Future<void> deleteConversation(String id, String conversationId) async {
    final res = await http.delete(
      Uri.parse('$_baseUrl/conversations/$id/$conversationId'),
      headers: _defaultHeaders,
    );
    handleResponse<void, void>(res);
  }

  // ---------------------------------------------------------------------------
  // CHATS
  // ---------------------------------------------------------------------------

  Future<Chat> createChat(Chat chat) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/chats'),
      headers: _defaultHeaders,
      body: jsonEncode(chat.toJson()),
    );
    return handleResponse<Chat, Chat>(res, fromJson: Chat.fromJson);
  }

  Future<Chat> updateChat(Chat chat) async {
    final res = await http.put(
      Uri.parse('$_baseUrl/chats'),
      headers: _defaultHeaders,
      body: jsonEncode(chat.toJson()),
    );
    return handleResponse<Chat, Chat>(res, fromJson: Chat.fromJson);
  }

  Future<Chat> getChat(String id, String conversationId) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/chats/$id/$conversationId'),
      headers: _defaultHeaders,
    );
    return handleResponse<Chat, Chat>(res, fromJson: Chat.fromJson);
  }

  Future<List<Chat>> getMessagesForConversation(String conversationId) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/chats/conversation/$conversationId'),
      headers: _defaultHeaders,
    );
    return handleResponse<List<Chat>, Chat>(res, fromJson: Chat.fromJson);
  }

  Future<List<Chat>> getMessagesBySender(String senderId) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/chats/sender/$senderId'),
      headers: _defaultHeaders,
    );
    return handleResponse<List<Chat>, Chat>(res, fromJson: Chat.fromJson);
  }

  Future<void> deleteChat(String id, String conversationId) async {
    final res = await http.delete(
      Uri.parse('$_baseUrl/chats/$id/$conversationId'),
      headers: _defaultHeaders,
    );
    handleResponse<void, void>(res);
  }
}
