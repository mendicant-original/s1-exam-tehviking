require 'yaml'
require 'column'

class Table
  attr_accessor :md_array, :column_names
  
  def initialize(source_data=nil)
    @column_names = []
    import_data(source_data) if source_data
  end
  
  def import_data(source_data)
    if source_data.class == String
      data_file = File.open(source_data)
      self.md_array = YAML::load(data_file)
      generate_column_names
    elsif source_data.class == Array
      self.md_array = source_data
      generate_column_names
    else
      puts "invalid source data"
    end
  end
  
  def generate_column_names
    @column_names = self.md_array[0]
  end
  
  def return_row(ordinal)
    self.md_array[ordinal]
  end
  
  def append_row(row)
    self.md_array << row
  end
  
  def insert_row(row, ordinal)
    self.md_array.insert(ordinal, row)
  end
  
  def delete_row(ordinal)
    self.md_array.delete_at(ordinal)
  end
  
  def transform_row(ordinal)
    row = self.md_array[ordinal]
    yield(row)
  end
  
  def find_cell(row, column)
    if column.class == String
      ordinal = self.column_names.index(column)
      self.md_array[row][ordinal]
    else  
      self.md_array[row][column]      
    end
  end
  
  #TODO: Pair this with filtering
  def find_row_by_index(ordinal)
    self.md_array[ordinal]
  end
  
  def find_column_by_name(name)
    ordinal = self.column_names.index(name)
    Column.new(self, ordinal)
  end
  
  #TODO: Pair this with filtering
  def find_column_by_index(ordinal)
    Column.new(self, ordinal)
  end
end