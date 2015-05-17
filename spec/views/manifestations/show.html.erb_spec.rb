require 'spec_helper'

describe "manifestations/show" do
  fixtures :all

  before(:each) do
    assign(:manifestation, FactoryGirl.create(:manifestation))
    view.stub(:current_user).and_return(User.find('enjuadmin'))
  end

  it "renders attributes in <p>" do
    allow(view).to receive(:policy).and_return double(show?: true, create?: true, destroy?: true)
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end

  describe "identifier_link" do
    it "renders a link to CiNii Books" do
      allow(view).to receive(:policy).and_return double(show?: true, create?: true, destroy?: true)
      assign(:manifestation, manifestations(:manifestation_00217))
      render
      rendered.should include '<a href="http://ci.nii.ac.jp/ncid/BN15603730">BN15603730</a>'
    end
  end
end
