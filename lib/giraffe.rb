class Giraffe
    attr_accessor :name, :limbs, :height, :gender, :age, :id

    def initialize(name:, limbs:, height:, gender:, age:, id: nil)
      @name = name
      @limbs = limbs
      @height = height
      @gender = gender
      @age = age
      @id = id
    end

    # Deletes the specified table, and any data associated with it
    # the IF EXISTS clause allows the statement to succeed even if the specified table doesn't exist.
    # if the table doesn't exist, and you don't include the IF EXISTS clause, an error is raised
    def self.drop_table
      sql = <<-SQL
        DROP TABLE IF EXISTS giraffe
      SQL

      DB[:conn].execute(sql)
    end

    # create table
    def self.create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS giraffe (
          id INTEGER PRIMARY KEY,
          name TEXT,
          limbs INTEGER,
          height INTEGER,
          gender TEXT, 
          age INTEGER
        )
      SQL

      DB[:conn].execute(sql)
    end

    # insert data into table
    def save
      sql = <<-SQL
        INSERT INTO giraffe (name, limbs, height, gender, age)
        VALUES(?, ?, ?, ?, ?)
      SQL

      # insert the giraffe
      DB[:conn].execute(sql, self.name, self.limbs, self.height, self.gender, self.age)

      # get the giraffe id from the database and save it to the Ruby instance
      self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM giraffe")[0][0]

      # return the Ruby instance
      self
    end

    # here we use keyword arguments to pass the data into the .create method
    # the params instantiate a new giraffe instance
    # then the #save method is used to persist that new giraffe instance to the database
    def self.new_giraffe(name:, limbs:, height:, gender:, age:)
      giraffe = Giraffe.new(name: name, limbs: limbs, height: height, gender: gender, age: age)
      giraffe.save
    end

    # read data from SQLite and temporarily represent that data in Ruby
    def self.read_giraffe(row)
      # self.new is equivalent to Giraffe.new
      self.new(id: row[0], name: row[1], limbs: row[2], height: row[3], gender: row[4], age: row[5])
    end

    # returns an array of all giraffe in the database
    # iterate over each row to create a new Ruby object for each row.
    def self.all
      sql = <<-SQL
        SELECT * FROM giraffe
      SQL

      DB[:conn].execute(sql).map do |row|
        self.read_giraffe(row)
      end
    end

    # find the name of a giraffe in the database
    # use a question mark in the SQL WHERE query
    # the return value is an array and chaining the #first method
    # at the end of the #map method helps to grab the first element
    # from the returned array
    def self.find_by_name(name)
      sql = <<-SQL
        SELECT * FROM giraffe
        WHERE name = ?
        LIMIT 1
      SQL

      DB[:conn].execute(sql, name).map do |row|
        self.read_giraffe(row)
      end.first
    end





    
    # def self.new_giraffe(name, limbs, height, gender, age)
    #     # @@all << Giraffe.new(name, limbs, height, gender, age)
    #     @@all << {
    #         name: name,
    #         limbs: limbs,
    #         height: height,
    #         gender: gender,
    #         age: age
    #     }
    # end
    
    

    # def sounds=(sounds)
    #     sounds
    # end
end

