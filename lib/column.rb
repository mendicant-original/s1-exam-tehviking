require 'table'

class Column
  attr_accessor :data, :ordinal, :table
  
  def initialize(table, ordinal, data=[])
    
    @data = data
    @name = nil
    @ordinal = ordinal
    @table = table
    
    @table.cells.each { |a| @data << a[@ordinal] } if @ordinal
    
    return @data
  end
  
  def [](ordinal)
    data[ordinal]
  end
  
  def []=(ordinal, value)
    data[ordinal] = value
  end
  
  def name
    data[0]
  end
  
  def set_name(name)
    data[0] = name
    update!
    table.generate_column_names
  end
  
  def insert(ordinal)
    self.ordinal = ordinal
    @table.cells.each { |a| a.insert(ordinal, nil) }
    update!
  end
  
  def append
    self.ordinal = @table.cells[0].length
    update!
  end
  
  def delete!
    @table.cells.each { |a| a.delete_at(@ordinal) }
    @column = nil
  end
  
  def transform
    column = self.data
    column.map! { |e| yield(e) }
    update!
  end

  def update!
    reverse_data = @data.reverse
    @table.cells.each { |e| e[@ordinal] = reverse_data.pop }
  end
end