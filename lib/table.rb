require 'yaml'

class Table
  attr_accessor :md_array, :column_names
  
  def initialize(source_data=nil, column_names=nil)
    import_data(source_data) if source_data
  end
  
  def import_data(source_data)
    if source_data.class == String
      data_file = File.open(source_data)
      self.md_array = YAML::load(data_file)
    elsif source_data.class == Array
      self.md_array = source_data
    else
      puts "invalid source data"
    end
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
  
  def set_column_name(column)
    @column[0]
  end
  
end