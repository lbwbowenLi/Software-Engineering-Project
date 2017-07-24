require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @user = users(:mashuo)
    @disease = diseases(:one)
    # This code is not idiomatically correct.
    @submission = Submission.new(disease_id:@disease.id, user_id:@user.id, is_related:true, reason:1)
  end

  test "should be valid" do
    assert @submission.valid?
  end

  test "user id should be present" do
    @submission.user_id = nil
    assert_not @submission.valid?
  end

  test "disease id should be present" do
    @submission.disease_id = nil
    assert_not @submission.valid?
  end

  test "reason should be present" do
    @submission.reason = nil
    assert_not @submission.valid?
  end

  test "is_related should be present" do
    @submission.is_related = nil
    assert_not @submission.valid?
  end
end
