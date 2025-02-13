require "test_helper"

class WorksControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    user = users(:one)
    sign_in user
    get works_url
    assert_response :success
  end
  test "show" do
    user = users(:one)
    sign_in user
    @work = Work.create profit: 20, hours: 10, time: "02:21:45", salary: 10
    get work_url(@work)
    assert_response :success
  end
  test "create (signed in, no project)" do
    user = users(:one)
    sign_in user
    assert_difference('Work.count') do
      post works_url, params: { work: { profit: 20, hours: 10, time: "02:21:45", salary: 10 } }
    end

    assert_redirected_to jobs_path(users(:one))
    assert_equal "Session successfully saved", flash[:success]
  end
  test "create (not signed in)" do
    assert_difference('Work.count') do
     post works_url, params: { work: { profit: 20, hours: 10, time: "02:21:45", salary: 10 } }
    end

    assert_redirected_to work_path(Work.last.id)
  end

  test "creation fails by validations" do
    assert_no_difference('Work.count') do
      post works_url, params: { work: { profit: nil } }
    end
    assert_redirected_to root_path
    assert_not_empty flash[:error]
  end

    test "create (signed in, with project)" do
      user = users(:one)
    sign_in user
      project = projects(:one)
      assert_difference('Work.count') do
        post works_url, params: { work: { profit: 20, hours: 10, time: "02:21:45", salary: 10, project_id: project.id } }
      end
  
      assert_redirected_to projects_path(users(:one))
      assert_equal "Session successfully saved on project", flash[:success]
    end
  
  test "destroy without a project" do
    user = users(:one)
    sign_in user
    @work = Work.create profit: 20, hours: 10, time: "02:21:45", salary: 10
      assert_difference('Work.count', -1) do
        delete work_url(@work)
      end
  end 

  test "destroy with a project" do
    user = users(:one)
    sign_in user
      project = projects(:one)
      @work = Work.create profit: 20, hours: 10, time: "02:21:45", salary: 10, project_id: project.id 
      assert_difference('Work.count', -1) do
        delete work_url(@work)
      end
    end
end
