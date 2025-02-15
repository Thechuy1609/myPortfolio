require "test_helper"

class InvoiceControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user
    @project = projects(:one)
    @invoice = invoices(:one)
  end
  
  test "index" do
    get project_invoices_path(@project)
    assert_response :success
  end

  test "show" do
  get project_invoice_path(@project, @invoice.id)
  assert_response :success
  end

  test "create" do
    assert_difference('Invoice.count') do
      post project_invoices_path(@project), params: { invoice: {
        name: "Test Invoice",
        client: "Test Client",
        total: "100.00",
        date: 2024-04-01,
        due_date: 2024-04-15,
        line_items_attributes: [{
          description: "Test Line Item",
          quantity: "2",
          rate: "50.00",
          subtotal: "100.00"
        }]
      } }
      @invoice = assigns(:invoice)
    end

    assert_redirected_to project_invoice_path(@project, @invoice)
  end

  test "creation fails by validations" do
    assert_no_difference('Invoice.count') do
        post project_invoices_path(@project), params: { invoice: { name: nil } } # Example: Invalid data
        assert_redirected_to new_project_invoice_path
        assert_not flash[:error].empty?  # Check if flash[:error] is present
      end
  end


  test "destroy" do
    assert_difference('Invoice.count', -1) do
    delete project_invoice_path(@project, @invoice)
     end
  end

  test "should permit invoices with commits filling the first row" do
    
    assert_difference('Work.count') do
    work1 = @project.works.create!(salary: 100, time: "2:00", profit:"218", hours:"2.30", project: @project)
    work1.commits.create!(description: "Commit 1")
    work1.commits.create!(description: "Commit 2")
    get new_project_invoice_url(@project)
    assert_response :success
  end

    invoice = assigns(:invoice)
    assert_equal 1, invoice.line_items.size
    line_item = invoice.line_items.first
    expected_description = "Commit 1\nCommit 2"
    assert_equal expected_description, line_item.description
    assert_equal line_item.subtotal, invoice.total
  end

end
