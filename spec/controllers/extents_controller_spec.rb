require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ExtentsController do
  login_admin

  # This should return the minimal set of attributes required to create a valid
  # Extent. As you add validations to Extent, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryGirl.attributes_for(:extent)
  end

  describe "GET index" do
    it "assigns all extents as @extents" do
      extent = Extent.create! valid_attributes
      get :index
      assigns(:extents).should eq(Extent.page(1))
    end
  end

  describe "GET show" do
    it "assigns the requested extent as @extent" do
      extent = Extent.create! valid_attributes
      get :show, :id => extent.id
      assigns(:extent).should eq(extent)
    end
  end

  describe "GET new" do
    it "assigns a new extent as @extent" do
      get :new
      assigns(:extent).should be_a_new(Extent)
    end
  end

  describe "GET edit" do
    it "assigns the requested extent as @extent" do
      extent = Extent.create! valid_attributes
      get :edit, :id => extent.id
      assigns(:extent).should eq(extent)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Extent" do
        expect {
          post :create, :extent => valid_attributes
        }.to change(Extent, :count).by(1)
      end

      it "assigns a newly created extent as @extent" do
        post :create, :extent => valid_attributes
        assigns(:extent).should be_a(Extent)
        assigns(:extent).should be_persisted
      end

      it "redirects to the created extent" do
        post :create, :extent => valid_attributes
        response.should redirect_to(Extent.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved extent as @extent" do
        # Trigger the behavior that occurs when invalid params are submitted
        Extent.any_instance.stub(:save).and_return(false)
        post :create, :extent => {}
        assigns(:extent).should be_a_new(Extent)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Extent.any_instance.stub(:save).and_return(false)
        post :create, :extent => {}
        #response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested extent" do
        extent = Extent.create! valid_attributes
        # Assuming there are no other extents in the database, this
        # specifies that the Extent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Extent.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => extent.id, :extent => {'these' => 'params'}
      end

      it "assigns the requested extent as @extent" do
        extent = Extent.create! valid_attributes
        put :update, :id => extent.id, :extent => valid_attributes
        assigns(:extent).should eq(extent)
      end

      it "redirects to the extent" do
        extent = Extent.create! valid_attributes
        put :update, :id => extent.id, :extent => valid_attributes
        response.should redirect_to(extent)
      end

      it "moves its position when specified" do
        extent = Extent.create! valid_attributes
        position = extent.position
        put :update, :id => extent.id, :move => 'higher'
        response.should redirect_to extents_url
        assigns(:extent).position.should eq position - 1
      end
    end

    describe "with invalid params" do
      it "assigns the extent as @extent" do
        extent = Extent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Extent.any_instance.stub(:save).and_return(false)
        put :update, :id => extent.id, :extent => {}
        assigns(:extent).should eq(extent)
      end

      it "re-renders the 'edit' template" do
        extent = Extent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Extent.any_instance.stub(:save).and_return(false)
        put :update, :id => extent.id, :extent => {}
        #response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested extent" do
      extent = Extent.create! valid_attributes
      expect {
        delete :destroy, :id => extent.id
      }.to change(Extent, :count).by(-1)
    end

    it "redirects to the extents list" do
      extent = Extent.create! valid_attributes
      delete :destroy, :id => extent.id
      response.should redirect_to(extents_url)
    end
  end

end
