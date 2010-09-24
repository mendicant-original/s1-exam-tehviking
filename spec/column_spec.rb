require 'column'

describe Column do

  context "initialized from existing table" do
    before(:each) do
      @table = Table.new('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml') 
      @column = Column.new(@table, 1)
    end
    
    it "initializes with array" do    
      @column[0].should == "AMOUNT"
      @column[1].should == "0"
    end
    
    it "sets a column name" do
      @column.set_name("Awesome Test Name")
      
      @column[0].should == "Awesome Test Name"
      @table[0,1].should == "Awesome Test Name"
      @table.column_names[1].should == "Awesome Test Name"
    end
    
    it "updates the column" do
      @column[0] = "Awesome Test Name 2"
      @column.update!
      
      @table[0,1].should == "Awesome Test Name 2"
      @table[0,0].should == "PROCEDURE_DATE"
      @table[3,1].should == "0"
      @table.column_names[1].should == "Awesome Test Name 2"
    end
    
    it "transforms a column" do
      @column.transform { |e| "blocky: #{e}" }
            
      @column[0].should == "blocky: AMOUNT"
      @table[0,1].should == "blocky: AMOUNT"
    end
    
    it "deletes a column" do
      @column.delete!
      
      @table[0,0].should == "PROCEDURE_DATE"
      @table[0,1].should == "TARGET_AMOUNT"
    end
  end
  
  context "Initialized with array" do
    before(:each) do
      @table = Table.new('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml') 
      dummy_column = []
      @table.cells.each { |a| dummy_column << "#{a[3]}-dup" }
      @column = Column.new(@table, nil, dummy_column)
    end
    
    it "initializes with an array" do
      @column[0].should == "AMTPINSPAID-dup"
    end
    
    it "appends a column" do
      @table[0].length.should == 5
      @table[0,5].should be_nil
      
      @column.append
      
      @table[0].length.should == 6
      @table[0,5].should == "AMTPINSPAID-dup"      
    end
    
    it "inserts a column" do
      @table[0].length.should == 5
      @table[0,5].should be_nil

      @column.insert(1)

      @table[0].length.should == 6
      @table[0,1].should == "AMTPINSPAID-dup"      
    end      
  end
end