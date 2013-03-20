require 'test_helper'

class FreeBooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:free_books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create free_book" do
    assert_difference('FreeBook.count') do
      post :create, :free_book => { }
    end

    assert_redirected_to free_book_path(assigns(:free_book))
  end

  test "should show free_book" do
    get :show, :id => free_books(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => free_books(:one).to_param
    assert_response :success
  end

  test "should update free_book" do
    put :update, :id => free_books(:one).to_param, :free_book => { }
    assert_redirected_to free_book_path(assigns(:free_book))
  end

  test "should destroy free_book" do
    assert_difference('FreeBook.count', -1) do
      delete :destroy, :id => free_books(:one).to_param
    end

    assert_redirected_to free_books_path
  end
end
