# ProlificInteractiveBooks
Code Test

Day 1- 

Decided to stick with a tableview to list the books. Thought a collectionView would not display the title and author of the books as well as a table view. Was able to layout with constraints the main page of the app and get the data displayed on the tableView from the API. App was crashing when I was running it but it was due to a faulty label outlet. 

Added a search bar feature that will update the book list based on what you are typing in. This is seaching against the title.

Bugs to go back and fix:
    Keyboard wont toggle off on seach feature - resignFirstResponder? FIXED - decided to a touched began override function.

Things to improve:
    Need to create graphics and impove the overall look of the app (waiting until all coding is done)

    When typing in the search bar can I have it search by title and author? FIXED- added a function with multiple filters.

Day 2-

Built out the Add Book page and the Details Page. Decided to give the user the ability to checkout out a book from the Details page as well as edit the books information. Most of the logic is built out with the exception of the API calls which I will tackle tomorrow. Only ran into some minor issues but they where quickly sorted out when I realized my mistakes with my logic. 

Bugs to go back and fix:
  All the coding seems to work as it should (for now).

Things to improve:
  Would like to add feature where the user can also return a book but I think that would require changes to the API. - DONE! After emailing Max and him emailing me back that it could be done another way I quickly realized how.


Day 3-

Built out all the API calls built in its own class. Added functionality where you can now return the book as well as check it out. Also added a feature that lets the user only see the available books. This lead to a road block because I have to figure out how that would work with the seach feature but sorted it out by adding more filtered arrays. The search is now capable of searching author, publisher, and tags. 




