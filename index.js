// index.js
const express = require('express');
const dotEnv = require('dotenv');
const connectDB = require('./config/db');
const newsRoutes = require('./Routes/NewsRoutes');
const cors = require('cors');

dotEnv.config();
connectDB();

const app = express();

// middlewares
app.use(cors()); // allow cross-origin requests (adjust origin in production)
app.use(express.json()); // built-in body parser

// routes
app.use('/api', newsRoutes);

const categories = [
  { name: 'All', icon: 'All' },
  { name: 'Technology', icon: 'computer' },
  { name: 'sports', icon: 'crickets' },
  { name: 'Health', icon: 'health_and_safety' },
  { name: 'business', icon: 'business' },
];

app.get("/api/categories", async (req, res) => {
  console.log("hsfhdwf");
  try {
    
    res.status(200).json(categories);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch categories", error });
  }
});


app.get('/welcome', (req, res) => {
  res.status(200).json({ success: true, message: 'welcome to page', data: categories });
});

const PORT = process.env.PORT || 4501;
app.listen(PORT, () => {
  console.log(`server is running at port : ${PORT}`);
});
