versions used:

node -v

v22.12.0

npm -v

10.9.0

to start the server:

npm run dev

to fill the database with data:

node seed.js

endpoints implemented:

POST: http://localhost:3000/api/auth/register

POST: http://localhost:3000/api/auth/login

GET http://localhost:3000/api/memories/get_all?<user_id>

POST http://localhost:3000/api/memories/add_memory

DELETE http://localhost:3000/api/memories/delete_memory/<memory_id>
