require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  	before_action :require_admin
  	
  	def setup
	  @category=Category.create(name: "sports")
	  @user=User.create(username:"john", email:"john@example.com", password: "password", admin:true)
	end
 
	test "should get categories index" do
	  get categories_path
	  assert_response :success
	end
  
  	test "should get new" do
	  sign_inas(@user,"password")
	end
  
  	test "should get show" do
	  get category_path(@category)
	  assert_response :success
	end
  
  	test "shout redirect create when admin not logged in" do
	  assert_do_difference 'Category.count' do
		post categories_path, params: {category: {name: "sports"}}
	  end
	  assert_redirected_to categories_path
	end
  
  	def require_admin
	  if !logged_in? || (logged_in? and !current_user.admin?)
		flash[:danger]="Only admins can perform that action"
		redirect_to categories_path
	  end
	end
end