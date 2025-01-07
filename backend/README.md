# 📚 **Backend API Documentation**

## 🚀 **Project Overview**

This backend powers the **HCI App Project**, built using **Node.js v22.12.0**, **npm v10.9.0**, **Express**, and **SQLite**. It provides API endpoints for managing:
- **User Authentication**  
- **Memories (User-created content with location data)**  
- **Clues (Unlockable hints or objectives)**  
- **User Settings**  

---

## 🛠️ **1. Setup Instructions**

### ✅ **1.1 Prerequisites**
Ensure the following tools are installed:
- **Node.js v22.12.0**  
- **npm v10.9.0**  
- **SQLite**  
- **Postman** (for API testing)  

### ✅ **1.2 Clone the Repository**
```bash
git clone <repository-url>
cd backend
```

### ✅ **1.3 Install Dependencies**
```bash
npm install
```

### ✅ **1.4 Start the Server**
- **Development Mode:**  
```bash
npm run dev
```
- **Production Mode:**  
```bash
npm start
```

The server will start on **`http://localhost:3000`** by default.

### ✅ **1.5 Database Setup**
- The database schema is automatically created on the first run.  
- To seed initial data:
```bash
node seed.js
```

---

## 📂 **2. Project Structure**

```
backend/
├── config/          # Database and app configuration
├── controllers/     # Route logic for endpoints
├── routes/          # API route definitions
├── models/          # Database schema definitions
├── uploads/         # Folder for uploaded images
├── seed.js          # Database seeding script
├── server.js        # Main server file
├── .env             # Environment variables
└── package.json
```

---

## 📊 **3. API Endpoints**

### 🧑‍💻 **3.1 Authentication Endpoints**
| **Method** | **Endpoint**       | **Description**        |
|------------|---------------------|-------------------------|
| `POST`     | `/api/auth/register` | Register a new user    |
| `POST`     | `/api/auth/login`    | Login an existing user |

### 📸 **3.2 Memories Endpoints**
| **Method** | **Endpoint**                | **Description**            |
|------------|------------------------------|-----------------------------|
| `GET`      | `/api/memories/get_all`      | Get all user memories       |
| `POST`     | `/api/memories/add_memory`   | Add a new memory            |
| `DELETE`   | `/api/memories/delete_memory/:id` | Delete a memory and its image |

### 🗺️ **3.3 Clues Endpoints**
| **Method** | **Endpoint**            | **Description**             |
|------------|--------------------------|------------------------------|
| `GET`      | `/api/clues/get_unlocked` | Get all unlocked clues      |
| `GET`      | `/api/clues/get_locked`   | Get all locked clues        |
| `POST`     | `/api/clues/add_unlocked` | Unlock a clue for a user    |

### ⚙️ **3.4 Settings Endpoints**
| **Method** | **Endpoint**          | **Description**          |
|------------|------------------------|---------------------------|
| `PUT`      | `/api/settings/update`        | Update notifications setting |
| `GET`      | `/api/settings/get_settings`  | Get all settings for a user  |

---

## 🧪 **4. Testing the API**

- Use **Postman** or any API client.  
- Example Request:
```http
GET http://localhost:3000/api/memories/get_all?user_id=1
```

- Example Body for Adding a Memory:
```json
{
  "user_id": 1,
  "title": "A Day at the Beach",
  "content": "Enjoyed a sunny day!",
  "image": <upload_file>
}
```

---

## 🐞 **6. Troubleshooting**

- **Port Already in Use:** Change the `PORT` in `.env`.  
- **Database Issues:** Clear database cache:
```bash
rm -rf data/database.db
node seed.js
```

- **Uploads Not Accessible:** Ensure static serving in `server.js`:
```javascript
app.use('/uploads', express.static('uploads'));
```

---

## 🤝 **7. Contributing**

1. Fork the repository.  
2. Create a new branch: `git checkout -b feature-branch`  
3. Commit changes: `git commit -m "Add feature X"`  
4. Push to branch: `git push origin feature-branch`  
5. Create a Pull Request.

---

## 📜 **8. License**

This project is licensed under the **MIT License**.

---
