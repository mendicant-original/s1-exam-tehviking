require 'yaml'

class Table
  attr_accessor :md_array
  
  def initialize(source_data_path=nil)
    import_data(source_data_path) if source_data_path
  end
  
  def import_data(source_data_path)
    data_file = File.open(source_data_path)
    self.md_array = YAML::load(data_file)
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

  def return_column(ordinal)
    column = []
    self.md_array.each { |a| column << a[ordinal] }
    return column
  end
  
  def column_name(column)
    @column[0]
  end
  
end