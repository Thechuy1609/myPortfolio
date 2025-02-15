require "test_helper"

class ProjectWorksControllerTest < ActionDispatch::IntegrationTest

  setup do
    login_user
    @project = projects(:one)
  end
  test "should get new" do
    get new_project_work_path(project_id: @project.id) # Correct route helper
    assert_response :success
    assert_not_nil assigns(:work)
    assert_instance_of Work, assigns(:work)
    assert_equal @project, assigns(:work).project # Very important!
    assert_not_nil assigns(:project)
    assert_equal @project, assigns(:project)
  end
end