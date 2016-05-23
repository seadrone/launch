class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '
  
  attr_accessor :title, :description, :done
  
  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end
  
  def done!
    self.done = true
  end
  
  def done?
    done
  end
  
  def undone!
    self.done = false
  end
  
  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title
  
  def initialize(title)
    @title = title
    @todos = []
  end
  
  def size
    @todos.size
  end
  
  def first
    @todos.first
  end
  
  def last
    @todos.last
  end
  
  def item_at(num)
    @todos[num]
  end
  
  def mark_done_at(num)
    @todos[num].done!
  end
  
  def mark_undone_at(num)
    @todos[num].undone!
  end
  
  def shift
    @todos.shift
  end
  
  def pop
    @todos.pop
  end
  
  def remove_at(num)
    @todos.delete_at(num)
  end
  
  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo
    @todos << todo
  end
  alias_method :add, :<<
  
  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end
  
  def select
    result = TodoList.new('select')
    each do |todo|
      result << todo if yield(todo)
    end
    result
  end

end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list << todo1
list << todo2
list << todo3

# results = list.select { |todo| todo.done? }
# puts results.inspect

list.each do |todo|
  puts todo
end
