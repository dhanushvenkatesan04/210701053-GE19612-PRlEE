app.post('/upload', upload.single('image'), async (req, res) => {
    console.log("**");
  const file = req.file;
  if (!file) {
    return res.status(400).send('No file uploaded.');
  }

  try {
    const bucket = admin.storage().bucket();
    const timestamp = new Date().getTime();
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    const blob = bucket.file(`images/${timestamp}-${uniqueSuffix}`);
    const blobStream = blob.createWriteStream();

    blobStream.on('error', (err) => {
      res.status(500).send('Failed to upload image.');
    });

    blobStream.on('finish', async () => {
      const imageUrl = `https://firebasestorage.googleapis.com/v0/b/${bucket.name}/o/${encodeURI(blob.name)}?alt=media`;
      res.status(200).send(imageUrl);
    });

    blobStream.end(file.buffer);
  } catch (err) {
    res.status(500).send('Failed to upload image.');
  }
});


