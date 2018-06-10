require 'rails_helper'

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

describe MediumOfPerformancesController do
  fixtures :all
  login_fixture_admin

  # This should return the minimal set of attributes required to create a valid
  # MediumOfPerformance. As you add validations to MediumOfPerformance, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryBot.attributes_for(:medium_of_performance)
  end

  describe 'GET index' do
    it 'assigns all medium_of_performances as @medium_of_performances' do
      medium_of_performance = MediumOfPerformance.create! valid_attributes
      get :index
      expect(assigns(:medium_of_performances)).to eq(MediumOfPerformance.order(:position))
    end
  end

  describe 'GET show' do
    it 'assigns the requested medium_of_performance as @medium_of_performance' do
      medium_of_performance = MediumOfPerformance.create! valid_attributes
      get :show, id: medium_of_performance.id
      expect(assigns(:medium_of_performance)).to eq(medium_of_performance)
    end
  end

  describe 'GET new' do
    it 'assigns a new medium_of_performance as @medium_of_performance' do
      get :new
      expect(assigns(:medium_of_performance)).to be_a_new(MediumOfPerformance)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested medium_of_performance as @medium_of_performance' do
      medium_of_performance = MediumOfPerformance.create! valid_attributes
      get :edit, id: medium_of_performance.id
      expect(assigns(:medium_of_performance)).to eq(medium_of_performance)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new MediumOfPerformance' do
        expect do
          post :create, medium_of_performance: valid_attributes
        end.to change(MediumOfPerformance, :count).by(1)
      end

      it 'assigns a newly created medium_of_performance as @medium_of_performance' do
        post :create, medium_of_performance: valid_attributes
        expect(assigns(:medium_of_performance)).to be_a(MediumOfPerformance)
        expect(assigns(:medium_of_performance)).to be_persisted
      end

      it 'redirects to the created medium_of_performance' do
        post :create, medium_of_performance: valid_attributes
        expect(response).to redirect_to(MediumOfPerformance.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved medium_of_performance as @medium_of_performance' do
        # Trigger the behavior that occurs when invalid params are submitted
        MediumOfPerformance.any_instance.stub(:save).and_return(false)
        post :create, medium_of_performance: { name: 'test' }
        expect(assigns(:medium_of_performance)).to be_a_new(MediumOfPerformance)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        MediumOfPerformance.any_instance.stub(:save).and_return(false)
        post :create, medium_of_performance: { name: 'test' }
        # expect(response).to render_template("new")
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested medium_of_performance' do
        medium_of_performance = MediumOfPerformance.create! valid_attributes
        # Assuming there are no other medium_of_performances in the database, this
        # specifies that the MediumOfPerformance created on the previous line
        # receives the :update message with whatever params are
        # submitted in the request.
        MediumOfPerformance.any_instance.should_receive(:update).with('name' => 'test')
        put :update, id: medium_of_performance.id, medium_of_performance: { 'name' => 'test' }
      end

      it 'assigns the requested medium_of_performance as @medium_of_performance' do
        medium_of_performance = MediumOfPerformance.create! valid_attributes
        put :update, id: medium_of_performance.id, medium_of_performance: valid_attributes
        expect(assigns(:medium_of_performance)).to eq(medium_of_performance)
      end

      it 'redirects to the medium_of_performance' do
        medium_of_performance = MediumOfPerformance.create! valid_attributes
        put :update, id: medium_of_performance.id, medium_of_performance: valid_attributes
        expect(response).to redirect_to(medium_of_performance)
      end

      it 'moves its position when specified' do
        medium_of_performance = MediumOfPerformance.create! valid_attributes
        position = medium_of_performance.position
        put :update, id: medium_of_performance.id, move: 'higher'
        expect(response).to redirect_to medium_of_performances_url
        assigns(:medium_of_performance).reload.position.should eq position - 1
      end
    end

    describe 'with invalid params' do
      it 'assigns the medium_of_performance as @medium_of_performance' do
        medium_of_performance = MediumOfPerformance.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MediumOfPerformance.any_instance.stub(:save).and_return(false)
        put :update, id: medium_of_performance.id, medium_of_performance: { name: 'test' }
        expect(assigns(:medium_of_performance)).to eq(medium_of_performance)
      end

      it "re-renders the 'edit' template" do
        medium_of_performance = MediumOfPerformance.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MediumOfPerformance.any_instance.stub(:save).and_return(false)
        put :update, id: medium_of_performance.id, medium_of_performance: { name: 'test' }
        # expect(response).to render_template("edit")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested medium_of_performance' do
      medium_of_performance = MediumOfPerformance.create! valid_attributes
      expect do
        delete :destroy, id: medium_of_performance.id
      end.to change(MediumOfPerformance, :count).by(-1)
    end

    it 'redirects to the medium_of_performances list' do
      medium_of_performance = MediumOfPerformance.create! valid_attributes
      delete :destroy, id: medium_of_performance.id
      expect(response).to redirect_to(medium_of_performances_url)
    end
  end
end
