var mongoose = require('mongoose');

var RecipeSchema = new mongoose.Schema({
  label: String,
  theme: String,
  number: Number,
  updated_at: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Recipe', RecipeSchema);