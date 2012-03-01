require 'test_helper'

class OpenMicTest < ActiveSupport::TestCase
  
  test "should not save open mic without name" do
    o = OpenMic.new
    o.dow = 2
    assert !o.save, "Open Mic saved without a name"
  end
  
  test "should not save open mic without day of week" do
    o = OpenMic.new
    assert !o.save, "Open Mic saved with a day of week"
  end
  
end
