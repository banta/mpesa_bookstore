require 'test_helper'

class BooksCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create books_category" do
    assert_difference('BooksCategory.count') do
      post :create, :books_category => { }
    end

    assert_redirected_to books_category_path(assigns(:books_category))
  end

  test "should show books_category" do
    get :show, :id => books_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => books_categories(:one).to_param
    assert_response :success
  end

  test "should update books_category" do
    put :update, :id => books_categories(:one).to_param, :books_category => { }
    assert_redirected_to books_category_path(assigns(:books_category))
  end

  test "should destroy books_category" do
    assert_difference('BooksCategory.count', -1) do
      delete :destroy, :id => books_categories(:one).to_param
    end

    assert_redirected_to books_categories_path
  end
end
