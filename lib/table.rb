require 'yaml'
require 'column'

class Table
  attr_accessor :cells, :column_names
  
  def initialize(source_data=nil)
    @cells = []
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
  
  def [](row, column=nil)
    if column
      cells[row][column]
    else
      cells[row]
    end
  end
  
  def []=(row, column, value)
    if column
      cells[row][column] = value
    else
      cells[row] = value
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
  
  def reduce_rows
    old_column_names = @column_names
    self.cells = cells.select { |e| yield(e) }
    cells.insert(0, old_column_names)
    generate_column_names
  end
  
  def reduce_columns
    rotated_table = cells.transpose
    reduced_cells = rotated_table.select { |e| yield(e) }
    self.cells = reduced_cells.transpose
  end
  
  def find_cell(row, column)
    if column.class == String
      ordinal = self.column_names.index(column)
      cells[row][ordinal]
    else  
      cells[row][column]      
    end
  end
  
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