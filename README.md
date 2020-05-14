# CDDMA-DTask-BookList
In the BookList App, users can create their own book list, view details of each book in the list, search book from the list, add new book to the list and rate a book after they finished a book.

1.	Screen
This app will have five screens, including:
	Home: A table view of book list, will display book cover, book name, author, pages in each row
	AddBook: A form to fill in details and add book to list. Users must upload a book image, fill in book name, author name, published year, page number and give a short description of the book.
	SearchBook: A table view to display matched books bases on search keyword
	BookDetail: When user tap each book in list, they will be navigated to a book detail screen to get more information of the book
	RateBook: User can rate a book after they finish the book, then the rating will be displayed on the BookDetail screen

2.	UI components and controllers
	Table view controller: display book list
	Navigation controller: navigate to different screen
	Search Bar and UISearchController: user can search a book from list

3.	Data Storage
	CoreDate will be implemented to save data persistently in local storage.

4.	Error Handling
	The AddBook screen will handle bad input from users. User cannot submit if any field is empty.

