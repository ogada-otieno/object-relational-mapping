require_relative '../lib/giraffe'
require 'sqlite3'

DB = { conn: SQLite3::Database.new('db/giraffes.db') }

# giraffe1 = Giraffe.new(name: 'Twiga', limbs: 4, height: 2, gender: 'F', age: 2)
# giraffe2 = Giraffe.new(name: 'Refu', limbs: 3, height: 3, gender: 'M', age: 2)

