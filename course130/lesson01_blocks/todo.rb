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

  def find_by_title(title)
    select {|todo| todo.title == title}.first
  end
  
  def all_done
    result = TodoList.new('all_done')
    each do |todo|
      result << todo if todo.done?
    end
    result
  end

  def all_not_done
    result = TodoList.new('all_not_done')
    each do |todo|
      result << todo unless todo.done?
    end
    result
  end

  def mark_done(title)
    find_by_title(title).done!
  end

  def mark_undone(title)
    find_by_title(title).undone!
  end

  def mark_all_done
    each do |todo|
      mark_done(todo.title)
    end
  end
  
  def mark_all_undone
    each do |todo|
      mark_undone(todo.title)
    end
  end

end # end TodoList class

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
todo4 = Todo.new("Buy cheese")

list = TodoList.new("Today's Todos")
list << todo1
list << todo2
list << todo3
list << todo4

list.mark_all_undone
puts list.all_not_done