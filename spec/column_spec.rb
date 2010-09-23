require 'column'

describe Column do

  context "initialized from existing table" do
    before(:each) do
      @table = Table.new('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml') 
      @column = Column.new(@table, 1)
    end
    
    it "initializes with array" do    
      @column.data[0].should == "AMOUNT"
      @column.data[1].should == "0"
    end
    
    it "sets a column name" do
      @column.set_name("Awesome Test Name")
      
      @column.data[0].should == "Awesome Test Name"
      @table.cells[0][1].should == "Awesome Test Name"
      @table.column_names[1].should == "Awesome Test Name"
    end
    
    it "updates the column" do
      @column.data[0] = "Awesome Test Name 2"
      @column.update!
      
      @table.cells[0][1].should == "Awesome Test Name 2"
      @table.cells[0][0].should == "PROCEDURE_DATE"
      @table.cells[3][1].should == "0"
      @table.column_names[1].should == "Awesome Test Name 2"
    end
    
    it "transforms a column" do
      @column.transform { |e| "blocky: #{e}" }
            
      @column.data[0].should == "blocky: AMOUNT"
      @table.cells[0][1].should == "blocky: AMOUNT"
    end
    
    it "deletes a column" do
      @column.delete!
      
      @table.cells[0][0].should == "PROCEDURE_DATE"
      @table.cells[0][1].should == "TARGET_AMOUNT"
    end
  end
end