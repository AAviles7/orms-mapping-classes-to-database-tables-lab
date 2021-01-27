class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?)
      SQL
    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create
    new_student = Student.new("name", 5)
    new_student.save
    return new_student
  end

end
