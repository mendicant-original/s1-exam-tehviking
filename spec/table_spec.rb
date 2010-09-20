require 'table'

describe Table do
  context "includes a file" do
    it "creates an array" do
      table = Table.new('/Users/bhays/Sites/s1-exam/data/s1-exam-data.yaml')
      table.md_array.should be_an_instance_of(Array)
      table.md_array[0][0].should == "PROCEDURE_DATE"
    end
  end
  
  context "doesn't include a file" do
    it "is initialized" do
      table = Table.new
      table.should_not be_nil
    end
  end
  
end