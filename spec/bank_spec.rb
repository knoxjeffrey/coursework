require 'spec_helper'
require 'bank'

describe Bank do
  
  describe :initialize do
    
    it "should accept a numerical value and set the #bank attribute" do
      expect(Bank.new(100).bank).to eql(100)
    end
    
    
  end

end