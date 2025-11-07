# 📬 Logos Messenger

**Secure Chat for Business Professionals**

Logos Messenger is a next-generation, end-to-end encrypted chat application sample. Inspired by the biblical concept of “Logos” — meaning *The Word* — the app delivers a trusted, secure, and modern communication experience built on Azure Cloud technologies.

---

## 🛡️ Vision

> “In the beginning was the Word (Logos)…” — John 1:1

Logos Messenger was created to embody the concept of trustworthy communication — bringing together **modern security**, **cloud scalability**, and **intuitive design** to create a platform that protects every conversation.

---

## 🚀 Features

- 🔒 **End-to-End Encryption** – All messages are encrypted client-side.
- 🔐 **Passwordless Login** – Secure 2-factor authentication via SMS or biometrics.
- 💬 **Real-Time Messaging** – Seamless chat experience using Cosmos DB change feed and REST API updates.
- 👤 **Persistent Session State** – Managed with Flutter Provider.
- 🌐 **Azure-Powered** – Built on Microsoft Azure App Services, Functions, and Cosmos DB.
- 📱 **Cross-Platform** – Built in Flutter for Android and iOS.
- 🖼️ **Modern UI** – Minimalist design with Royal Blue (#02066f) and Gold (#ffd700).

---

## 🧩 Architecture Overview

### **Mobile App (Flutter + Dart)**
- Handles all front-end logic, UI, and local session management.
- Communicates with REST API using `DataService` class.
- Uses `Provider` for state management across pages.
- Biometrics via `local_auth` for returning users.

### **REST API (.NET Core C#)**
- Hosted on Azure App Service for Containers.
- Implements endpoints for:
  - `AccountsController` – Account creation & verification.
  - `ConversationsController` – Chat room management.
  - `ChatsController` – Message persistence and retrieval.
- Uses `EndpointDescription` attributes for auto-generated API documentation.

## Azure Front Door & Azure API Management
- REST API resides within Azure API Management.
  - Additional Security - Azure API Management passes a special token, only it knows, to Azure App Service to ensure only requests coming from API Management are processed.
- Front Door provides central URI access to the Azure API Management resource.

### **Database (Azure Cosmos DB)**
- JSON document model with partition key on `UserName`.
- Containers:
  - `Accounts`
  - `Conversations`
  - `Chats`
- Each document includes:
  - `userName or conversationId` (Partition Key)
  - `_ttl` for optional time-to-live
  - `DateTimeOffset` timestamps for global consistency

---

## 🧠 Tech Stack

| Layer | Technology |
|-------|-------------|
| **Frontend** | Flutter (Dart) |
| **Backend** | .NET 8 (C#) REST API |
| **Database** | Azure Cosmos DB |
| **Hosting** | Azure App Service for Containers, Azure API Management, Azure Front Door |
| **Auth** | SMS + Biometrics (no passwords) |

---

## 🛠️ Setup Instructions

### **1. Clone the Repository**
```bash
git clone https://github.com/yourusername/logos-messenger.git
cd logos-messenger
