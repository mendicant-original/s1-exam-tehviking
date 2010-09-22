require 'column'

describe Column do

  context "initialized from existing table" do
    before(:each) do
      @table = Table.new('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml') 
      @column = Column.new(@table, 1)
    end
    
    it "initializes with array" do    
      @column.col_array[0].should == "AMOUNT"
      @column.col_array[1].should == "0"
    end
    
    it "sets a column name" do
      @column.set_name("Awesome Test Name")
      
      @column.col_array[0].should == "Awesome Test Name"
      @table.md_array[0][1].should == "Awesome Test Name"
      @table.column_names[1].should == "Awesome Test Name"
    end
    
    it "updates the column" do
      @column.col_array[0] = "Awesome Test Name 2"
      @column.update!
      
      @table.md_array[0][1].should == "Awesome Test Name 2"
      @table.md_array[0][0].should == "PROCEDURE_DATE"
      @table.md_array[3][1].should == "0"
      @table.column_names[1].should == "Awesome Test Name 2"
    end
    
# unpredictable result from this test. Best ask about it.
    it "transforms a column" do
      @column.transform { |a| a[0] = "blocky"}
      @column.update!
      
      @column.col_array[0].should == "blocky"
      @table.md_array[0][1].should == "blocky"
    end
  end
end