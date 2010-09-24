require 'table'
require 'column'
require 'yaml'
require 'date'

# Start and open the file
table_file = File.open('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml')
table_data = YAML::load(table_file)
@table = Table.new(table_data)

# Restrict the data to June 2006
@table.reduce_rows { |e| e[0] =~ /(06)\/([0-9][0-9])\/(06)/ }

# Find the AMOUNT, TARGET_AMOUNT, and AMTPINSPAID columns, convert to money
def get_money_get_paid(column)
  column.transform { |e| 
    if e.include?("AMOUNT")
      e
    elsif e.include?("AMT")
      e
    elsif e.to_i < 10
      e.insert(-1, ".00")
      e.insert(0, "$")
    else 
      e.insert(-3, ".")
      e.insert(0, "$")       
    end 
  }
end

col1 = @table.find_column_by_name("AMOUNT")
get_money_get_paid(col1)

col2 = @table.find_column_by_name("TARGET_AMOUNT")
get_money_get_paid(col2)

col3 = @table.find_column_by_name("AMTPINSPAID")
get_money_get_paid(col3)

# Remove the Count column
@count_column = @table.find_column_by_name("Count")
@count_column.delete!

# Convert the date to YYYY-MM-DD
dates = @table.find_column_by_name("PROCEDURE_DATE")
dates.data.delete_at(0)
dates.transform { |e| Date.strptime(e.to_s, '%m/%d/%y').strftime }
dates.data.insert(0, "PROCEDURE_DATE")
dates.update!

# Convert to YAML & save to a new file
f = File.new("s1-exam-data-transformed.yaml",  "w+") 

File.open("s1-exam-data-transformed.yaml",  "w+") do |output|
  YAML.dump(@table.cells, output)
end