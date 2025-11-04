// config/db.js
const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log(`mongoose db connected: ${conn.connection.host}`);
  } catch (err) {
    console.error('error', err);
    process.exit(1);
  }
};

module.exports = connectDB;
