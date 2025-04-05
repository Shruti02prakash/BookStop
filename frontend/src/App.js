import React, { useEffect, useState } from 'react';
import axios from 'axios';

function App() {
	  const [books, setBooks] = useState([]);

	  useEffect(() => {
		      axios.get('http://localhost:5000/api/books')
		        .then(response => setBooks(response.data))
		        .catch(err => console.log(err));
		    }, []);

	  return (
		      <div>
		        <h1>Book Stop - Buy & Sell Books</h1>
		        <ul>
		          {books.map((book) => (
				            <li key={book._id}>
				              {book.title} by {book.author} - ${book.price}
				            </li>
				          ))}
		        </ul>
		      </div>
		    );
}

export default App;

