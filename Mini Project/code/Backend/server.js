const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const loginRoutes = require('./routes/loginRoutes');
const http = require('http');
const donorRoutes = require('./routes/donorRoutes');
const foodRoutes = require('./routes/foodRoutes');
const multer = require('multer');
const fs = require('fs');
const sizeOf = require('image-size');


const admin = require('firebase-admin');
const serviceAccount = require("./eat-and-share-4f0a0-firebase-adminsdk-lmpvd-c108aed18a.json");

const app = express();

const path = require('path');

//////////////////////////////////////////////

mongoose.connect('mongodb+srv://dhanushvenkatesan4:12345@cluster0.nenjft4.mongodb.net/Sample?retryWrites=true&w=majority&appName=Cluster0');

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));
db.once('open', () => {
  console.log('Connected to MongoDB');
});
//////////////////////////////////////////////

app.use(bodyParser.json());


app.use('/api', loginRoutes);
app.use('/api', donorRoutes);
app.use('/api', foodRoutes);









// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
//   storageBucket: "gs://eat-and-share-4f0a0.appspot.com",
// });
   
// const bucket = admin.storage().bucket();

// const storage = multer.memoryStorage();
// const upload = multer({ storage: storage });

// const imagesDir = path.join(__dirname, 'images');
// if (!fs.existsSync(imagesDir)) {
//   fs.mkdirSync(imagesDir);
// }

// app.post('/upload', upload.single('image'), async (req, res) => {
//   if (!req.file) {
//     return res.status(400).send('No file uploaded.');
//   }

//   const fileName = new Date().getTime().toString();
//   const filePath = path.join(imagesDir, `${fileName}.jpg`);
//   fs.writeFileSync(filePath, req.file.buffer);

//   // Assuming you have a Firebase Storage upload function here
//   const downloadURL1 = await uploadToFirebaseStorage(filePath);

//   // For demonstration purposes, just sending back the local file path
//   const downloadURL = `http://localhost:3000/images/${fileName}.jpg`;

//   res.send(downloadURL1);
// });

// // Upload endpoint
// app.post('/upload', upload.single('image'), async (req, res) => {
//   if (!req.file) {
//     return res.status(400).send('No file uploaded.');
//   }

//   // Save the file to Firebase Storage or any other cloud storage
//   // In this example, we're just saving it to the local filesystem
//   const fileName = new Date().getTime().toString();
//   const filePath = `images/${fileName}.jpg`;
//   fs.writeFileSync(filePath, req.file.buffer);

//   // Assuming you have a Firebase Storage upload function here
//   // const downloadURL = await uploadToFirebaseStorage(filePath);

//   // For demonstration purposes, just sending back the local file path
//   const downloadURL = `http://localhost:3000/${filePath}`;

//   res.send(downloadURL);
// });






const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
