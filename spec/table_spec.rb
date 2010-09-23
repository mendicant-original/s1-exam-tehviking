require 'table'

describe Table do
  
  context "initialized without parameters" do
    it "is initialized" do
      table = Table.new
      table.should_not be_nil
    end
  end
  
  context "initialized with an array" do
    before(:each) do
      table_file = File.open('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml')
      table_data = YAML::load(table_file)
      @table = Table.new(table_data)
    end
    
    it "creates an array" do
      @table.cells.should be_an_instance_of(Array)
      @table.cells[0][0].should == "PROCEDURE_DATE"
    end
    
    it "generates column names" do
      @table.column_names[0].should == "PROCEDURE_DATE"
    end
  end
  
  context "initialized with a file path" do
    before(:each) do
      @table = Table.new('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml')      
    end
    
    it "creates an array" do
      @table.cells.should be_an_instance_of(Array)
      @table.cells[0][0].should == "PROCEDURE_DATE"
    end
    
    it "generates column names" do
      @table.column_names[0].should == "PROCEDURE_DATE"
    end
  
    it "returns a row" do
      @row = @table.return_row(0) 
    
      @row[0].should == "PROCEDURE_DATE"
    end
  
    it "appends a row" do
      new_row = ["05/31/06", "0", "7700", "0", "1888"]
      @table.append_row(new_row)
      
      @table.cells.last.should == ["05/31/06", "0", "7700", "0", "1888"]
    end
    
    it "inserts a row" do
      new_row = ["05/31/06", "0", "7700", "0", "1888"]
      @table.insert_row(new_row, 1)
      
      @table.cells[1].should == ["05/31/06", "0", "7700", "0", "1888"]
    end
    
    it "deletes a row" do
      @table.delete_row(0)
      
      @table.cells[0][0].should == "05/02/06"
    end
    
    it "transforms a row" do
      @table.transform_row(0) { |e| "blocky: #{e}" }
      @table.cells[0][0].should == "blocky: PROCEDURE_DATE"
    end
  
    it "returns a column" do
      @column = Column.new(@table, 0) 
    
      @column.data[0].should == "PROCEDURE_DATE"
    end
    
    it "finds a cell by index" do
      cell = @table.find_cell(14, 0)
      
      cell.should == "06/13/06"
    end
    
    it "finds a cell by column name" do
      cell = @table.find_cell(14, "PROCEDURE_DATE")
      
      cell.should == "06/13/06"
    end
    
    it "finds a row by index" do
      row = @table.find_row_by_index(14)
      
      row[0].should == "06/13/06"
    end
  end
end