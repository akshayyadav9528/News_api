// Routes/NewsRoutes.js
const express = require('express');
const route = express.Router();
const News = require('../models/newsmodel');

route.get('/news', async (req, res) => {
  console.log("heelloooo");
  // page & limit come as strings — parse them
  let { page = 1, limit = 10, category, keyword } = req.query;
  page = parseInt(page, 10) || 1;
  limit = parseInt(limit, 10) || 10;

  const query = {};
  if (category) query.category = category;
  if (keyword) query.title = { $regex: keyword, $options: 'i' };

  try {
    const news = await News.find(query)
      .sort({ createdAt: -1 }) // use createdAt (timestamps)
      .skip((page - 1) * limit)
      .limit(limit);

    const total = await News.countDocuments(query);

    res.json({
      success: true,
      data: news,
      currentPage: page,
      totalPage: Math.ceil(total / limit),
      totalArticles: total,
    });
  } catch (err) {
    console.error('error', err);
    res.status(500).json({ success: false, message: err.message });
  }
});

route.post('/create', async (req, res) => {
  // use req.body (not res.body)
  const { title, description, content, imageURL, category, source } = req.body;

  if (!title || !description || !imageURL || !category) {
    return res.status(400).json({ success: false, message: 'Missing required fields' });
  }

  try {
    const news = await News.create({
      title,
      description,
      content,
      imageURL,
      category,
      source,
    });
    res.status(201).json({ success: true, data: news });
  } catch (error) {
    console.error('create news error', error);
    res.status(500).json({ success: false, message: error.message });
  }
});

module.exports = route;
