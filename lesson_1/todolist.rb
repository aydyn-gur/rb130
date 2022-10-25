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

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo

    @todos << todo
  end
  alias_method :add, :<<
  
  def size
    todos.size
  end
  
  def first
    todos.first
  end
  
  def last
    todos.last
  end
  
  def to_a
    todos.clone
  end
  
  def done?
    todos.all? { |item| item.done? }
  end
  
  def item_at(idx)
    todos.fetch(idx)
  end
  
  def mark_done_at(idx)
    item_at(idx).done!
  end
  
  def mark_undone_at(idx)
    item_at(idx).undone!
  end
  
  def done!
    todos.each { |item| item.done! }
  end
  
  def shift
    todos.shift
  end
  
  def pop
    todos.pop
  end
  
  def remove_at(idx)
    item_at(idx)
    todos.delete_at(idx)
  end
  
  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end
  
  def each
    counter = 0
    
    while counter < todos.size
      yield(todos[counter])
      counter += 1
    end
    
    self
  end
  
  def select
    new_list = TodoList.new(title)
    todos.each { |task| new_list.add(task) if yield(task) }
    new_list
  end
  
  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end
  
  def all_done
    select { |task| task.done? }
  end
  
  def all_not_done
    select { |task| !task.done? }
  end
  
  def mark_done(string)
    task = find_by_title(string)
    nil == task ? nil : task.done!
  end
  
  def mark_all_done
    each { |task| task.done! }
  end
  
  def mark_all_undone
    each { |task| task.undone! }
  end
  
  protected
  
  attr_reader :todos
end
