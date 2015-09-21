require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin)
    FactoryGirl.create(:folder).save
    @document = FactoryGirl.create(:document)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post :create, document: { folder_id: @document.folder_id, name: @document.name }
    end

    assert_redirected_to document_path(assigns(:document))
  end

  test "should show document" do
    get :show, id: @document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document
    assert_response :success
  end

  test "should update document" do
    patch :update, id: @document, document: { folder_id: @document.folder_id, name: @document.name }
    assert_redirected_to document_path(assigns(:document))
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete :destroy, id: @document
    end

    assert_redirected_to documents_path
  end
end
