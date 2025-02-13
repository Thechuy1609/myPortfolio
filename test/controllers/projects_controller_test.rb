require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user
    @project = projects(:one)
  end
  
  test "index" do
    get projects_url
    assert_response :success
  end

  test "show" do
    get project_url(@project)
    assert_response :success
  end

  test "create" do
    assert_difference('Project.count') do
      post projects_url,  params: { project: { name:"Evan", client: "Johny", description: "abcdefg"} }
    end
  assert_redirected_to projects_path(@project.id)
  assert_equal "Project successfully created",flash[:success]
  end
  test "creation fails" do
    assert_no_difference('Project.count') do
      post projects_url,  params: { project: { name: nil, client: nil, description: "abcdefg"} }
    end
    assert_redirected_to root_path
    assert_equal ["Name can't be blank", "Client can't be blank"], flash[:error]
    assert_includes flash[:error], "Name can't be blank"
    assert_includes flash[:error], "Client can't be blank"
  end

  test "destroy" do
      assert_difference('Project.count', -1) do
        delete project_url(@project)
      end
    end


end
