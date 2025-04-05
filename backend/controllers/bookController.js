const Book = require('../models/Book');

const getBooks = async (req, res) => {
  try {
    const books = await Book.find();
    res.json(books);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const addBook = async (req, res) => {
  const { title, author, price, category } = req.body;
  const newBook = new Book({
    title,
    author,
    price,
    category,
  });

  try {
    const book = await newBook.save();
    res.status(201).json(book);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = { getBooks, addBook };
