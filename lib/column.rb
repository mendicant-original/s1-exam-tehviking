require 'table'

class Column
  attr_accessor :col_array, :ordinal, :table
  
  def initialize(table, ordinal)
    @col_array = []
    @name = nil
    @ordinal = ordinal
    @table = table
    
    @table.md_array.each { |a| @col_array << a[@ordinal] }
    
    return @col_array
  end
  
  def name
    self.col_array[0]
  end
  
  def set_name(name)
    self.col_array[0] = name
    self.update!
    self.table.generate_column_names
  end
  
  def insert
    #TODO
  end
  
  def append
    #TODO
  end
  
  def delete
    #TODO
  end
  
  def transform
    column = self.col_array
    yield(column)
  end

# TODO: There's gotta be a more logical way to update the column
  def update!
    reverse_col_array = @col_array.reverse
    @table.md_array.each { |e| e[@ordinal] = reverse_col_array.pop }
  end
end