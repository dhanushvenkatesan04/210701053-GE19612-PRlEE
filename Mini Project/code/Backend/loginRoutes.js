// routes/loginRoutes.js

const express = require('express');
const router = express.Router();
const Login = require('../models/login');

router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {

    const user = await Login.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    if (user.password !== password) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    res.status(200).json({ user });

  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

module.exports = router;
