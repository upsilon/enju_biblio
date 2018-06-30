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

describe FrequenciesController do
  fixtures :all
  login_fixture_admin

  # This should return the minimal set of attributes required to create a valid
  # Frequency. As you add validations to Frequency, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryBot.attributes_for(:frequency)
  end

  describe 'GET index' do
    it 'assigns all frequencies as @frequencies' do
      frequency = Frequency.create! valid_attributes
      get :index
      assigns(:frequencies).should eq(Frequency.order(:position))
    end
  end

  describe 'GET show' do
    it 'assigns the requested frequency as @frequency' do
      frequency = Frequency.create! valid_attributes
      get :show, params: { id: frequency.id }
      assigns(:frequency).should eq(frequency)
    end
  end

  describe 'GET new' do
    it 'assigns a new frequency as @frequency' do
      get :new
      assigns(:frequency).should be_a_new(Frequency)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested frequency as @frequency' do
      frequency = Frequency.create! valid_attributes
      get :edit, params: { id: frequency.id }
      assigns(:frequency).should eq(frequency)
    end
    it 'assigns the frequency even if it associates manifestation(s)' do
      frequency = FactoryBot.create(:frequency)
      manifestation = FactoryBot.create(:manifestation, frequency_id: frequency.id)
      get :edit, params: { id: frequency.id }
      expect(assigns(:frequency)).to eq frequency
      expect(response).to be_success
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Frequency' do
        expect do
          post :create, params: { frequency: valid_attributes }
        end.to change(Frequency, :count).by(1)
      end

      it 'assigns a newly created frequency as @frequency' do
        post :create, params: { frequency: valid_attributes }
        assigns(:frequency).should be_a(Frequency)
        assigns(:frequency).should be_persisted
      end

      it 'redirects to the created frequency' do
        post :create, params: { frequency: valid_attributes }
        expect(response).to redirect_to(Frequency.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved frequency as @frequency' do
        # Trigger the behavior that occurs when invalid params are submitted
        Frequency.any_instance.stub(:save).and_return(false)
        post :create, params: { frequency: { name: 'test' } }
        assigns(:frequency).should be_a_new(Frequency)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Frequency.any_instance.stub(:save).and_return(false)
        post :create, params: { frequency: { name: 'test' } }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested frequency' do
        frequency = Frequency.create! valid_attributes
        # Assuming there are no other frequencies in the database, this
        # specifies that the Frequency created on the previous line
        # receives the :update message with whatever params are
        # submitted in the request.
        Frequency.any_instance.should_receive(:update).with('name' => 'test')
        put :update, params: { id: frequency.id, frequency: { 'name' => 'test' } }
      end

      it 'assigns the requested frequency as @frequency' do
        frequency = Frequency.create! valid_attributes
        put :update, params: { id: frequency.id, frequency: valid_attributes }
        assigns(:frequency).should eq(frequency)
      end

      it 'redirects to the frequency' do
        frequency = Frequency.create! valid_attributes
        put :update, params: { id: frequency.id, frequency: valid_attributes }
        expect(response).to redirect_to(frequency)
      end

      it 'moves its position when specified' do
        frequency = Frequency.create! valid_attributes
        position = frequency.position
        put :update, params: { id: frequency.id, move: 'higher' }
        expect(response).to redirect_to frequencies_url
        assigns(:frequency).reload.position.should eq position - 1
      end
    end

    describe 'with invalid params' do
      it 'assigns the frequency as @frequency' do
        frequency = Frequency.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Frequency.any_instance.stub(:save).and_return(false)
        put :update, params: { id: frequency.id, frequency: { name: 'test' } }
        assigns(:frequency).should eq(frequency)
      end

      it "re-renders the 'edit' template" do
        frequency = Frequency.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Frequency.any_instance.stub(:save).and_return(false)
        put :update, params: { id: frequency.id, frequency: { name: 'test' } }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested frequency' do
      frequency = Frequency.create! valid_attributes
      expect do
        delete :destroy, params: { id: frequency.id }
      end.to change(Frequency, :count).by(-1)
    end

    it 'redirects to the frequencies list' do
      frequency = Frequency.create! valid_attributes
      delete :destroy, params: { id: frequency.id }
      expect(response).to redirect_to(frequencies_url)
    end
  end
end
