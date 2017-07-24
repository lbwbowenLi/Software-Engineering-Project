require 'test_helper'

class DiseaseTest < ActiveSupport::TestCase
  def setup
    @disease = diseases(:one)
  end

  test "should be valid" do
    assert @disease.valid?
  end

  test "disease id should be present" do
    @disease.id = nil
    assert_not @disease.valid?
  end

  test "disease name should be present" do
    @disease.disease = ""
    assert_not @disease.valid?
  end

  test "accession name should be present" do
    @disease.accession = ""
    assert_not @disease.valid?
  end

  test "related should be default 0" do
    assert @disease.related == 0
  end

  test "related should not be less than 0" do
    @disease.related = -1
    assert_not @disease.valid?
  end

  test "unrelated should be default 0" do
    assert @disease.unrelated == 0
  end

  test "unrelated should not be less than 0" do
    @disease.unrelated = -1
    assert_not @disease.valid?
  end

  test "closed should be default false" do
    assert @disease.closed == false
  end

end
