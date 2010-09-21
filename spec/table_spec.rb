require 'table'

describe Table do
  
  context "initialized without parameters" do
    it "is initialized" do
      table = Table.new
      table.should_not be_nil
    end
  end
  
  context "initialized with an array" do
    it "creates an array" do
      table_file = File.open('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml')
      table_data = YAML::load(table_file)
      @table = Table.new(table_data)
      
      @table.md_array.should be_an_instance_of(Array)
      @table.md_array[0][0].should == "PROCEDURE_DATE"
    end
  end
  
  context "initialized with a file path" do
    before(:each) do
      @table = Table.new('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml')      
    end
    
    it "creates an array" do
      @table.md_array.should be_an_instance_of(Array)
      @table.md_array[0][0].should == "PROCEDURE_DATE"
    end
  
    it "returns a row" do
      @row = @table.return_row(0) 
    
      @row[0].should == "PROCEDURE_DATE"
    end
  
    it "appends a row" do
      new_row = ["05/31/06", "0", "7700", "0", "1888"]
      @table.append_row(new_row)
      
      @table.md_array.last.should == ["05/31/06", "0", "7700", "0", "1888"]
    end
    
    it "inserts a row" do
      new_row = ["05/31/06", "0", "7700", "0", "1888"]
      @table.insert_row(new_row, 1)
      
      @table.md_array[1].should == ["05/31/06", "0", "7700", "0", "1888"]
    end
  
    it "returns a column" do
      @column = @table.return_column(0) 
    
      @column[0].should == "PROCEDURE_DATE"
    end
  end
end