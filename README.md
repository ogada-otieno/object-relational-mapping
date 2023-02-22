# object-relational-mapping

## Todos and Notes:
- Connect Ruby to an SQLite database
- Create database, insert data into it
- Write code that maps a Ruby class to a database table
- Write code that inserts data regarding an instance of a class into a database table row
- Build methods that read from a database table
- Build a Giraffe.all class method that returns all giraffes from the database
- Build a Giraffe.find_by_name class method that accepts one argument, a name, searches the database for a giraffe with that name and returns the matching giraffe entry if one is found
- Convert what the database gives you into a Ruby object
- Update the database to correct for wrong information using Giraffe#update.
- The #save method should not allow for duplication of the same data. In the event that an object has already been persisted in the database, the #save method should raise an exception. The #save method should check if the object has already been persisted. If so, don't INSERT a new into the database, simply update an existing one. 
- How do we know if an object has already been persisted? If it has an *id* that is not *nil*. Remember that an object's id attribute gets set only once it has been INSERT-ed into the database.
