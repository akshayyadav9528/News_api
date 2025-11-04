// models/newsmodel.js
const mongoose = require('mongoose');

const newsSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, 'title is required'],
    },
    description: {
      type: String,
      required: [true, 'description is required'],
    },
    content: {
      type: String,
    },
    imageURL: {
      type: String,
      required: [true, 'image is required'],
    },
    category: {
      type: String,
      enum: ['Technology', 'sports', 'Health', 'business'],
      required: [true, 'category is required'],
    },
    source: {
      type: String,
    },
  },
  { timestamps: true } // createdAt, updatedAt
);

const News = mongoose.model('News', newsSchema);
module.exports = News;
