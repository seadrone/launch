class ToDo
  attr_reader :title, :due_date, :status
  def initialize(title, due_date)
    @title = title
    @due_date = due_date
    @status = :new
  end
  
  def mark_complete
    @finished_at = Time.new
    @status = :done
  end
end

my_todo = ToDo.new("Go to library", Time.new(2016,1,3))
puts my_todo.inspect

my_todo.mark_complete
puts my_todo.inspect