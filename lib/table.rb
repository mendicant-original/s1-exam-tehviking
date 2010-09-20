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
  
  def return_row
    @row = @md_array.each { |a| @rows << a[0] }
  end
  
end