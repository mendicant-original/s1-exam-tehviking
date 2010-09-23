require 'yaml'
require 'column'

class Table
  attr_accessor :cells, :column_names
  
  def initialize(source_data=nil)
    @column_names = []
    import_data(source_data) if source_data
  end
  
  def import_data(source_data)
    if source_data.class == String
      data_file = File.open(source_data)
      self.cells = YAML::load(data_file)
      generate_column_names
    elsif source_data.class == Array
      self.cells = source_data
      generate_column_names
    else
      puts "invalid source data"
    end
  end
  
  def generate_column_names
    @column_names = cells[0]
  end
  
  def return_row(ordinal)
    cells[ordinal]
  end
  
  def append_row(row)
    cells << row
  end
  
  def insert_row(row, ordinal)
    cells.insert(ordinal, row)
  end
  
  def delete_row(ordinal)
    cells.delete_at(ordinal)
  end
  
  def transform_row(ordinal)
    row = self.cells[ordinal]
    row.map! { |e| yield(e) }
  end
  
  def find_cell(row, column)
    if column.class == String
      ordinal = self.column_names.index(column)
      cells[row][ordinal]
    else  
      cells[row][column]      
    end
  end
  
  #TODO: Pair this with filtering
  def find_row_by_index(ordinal)
    cells[ordinal]
  end
  
  def find_column_by_name(name)
    ordinal = self.column_names.index(name)
    Column.new(self, ordinal)
  end
  
  def find_column_by_index(ordinal)
    Column.new(self, ordinal)
  end
end