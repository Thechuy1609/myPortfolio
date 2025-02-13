require "test_helper"

class WorkTest < ActiveSupport::TestCase
  def setup
    @work = Work.new profit: 20, hours: 10, time: "02:21:45", salary: 10
  end

  test "works by default" do
    assert @work.valid?
  end

  test "calculated_time"  do
    assert_equal 2.35, @work.calculated_time
  end
end
