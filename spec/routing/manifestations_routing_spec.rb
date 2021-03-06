# == Schema Information
#
# Table name: manifestations
#
#  id                              :integer          not null, primary key
#  original_title                  :text             not null
#  title_alternative               :text
#  title_transcription             :text
#  classification_number           :string
#  manifestation_identifier        :string
#  date_of_publication             :datetime
#  date_copyrighted                :datetime
#  created_at                      :datetime
#  updated_at                      :datetime
#  deleted_at                      :datetime
#  access_address                  :string
#  language_id                     :integer          default(1), not null
#  carrier_type_id                 :integer          default(1), not null
#  start_page                      :integer
#  end_page                        :integer
#  height                          :integer
#  width                           :integer
#  depth                           :integer
#  price                           :integer
#  fulltext                        :text
#  volume_number_string            :string
#  issue_number_string             :string
#  serial_number_string            :string
#  edition                         :integer
#  note                            :text
#  repository_content              :boolean          default(FALSE), not null
#  lock_version                    :integer          default(0), not null
#  required_role_id                :integer          default(1), not null
#  required_score                  :integer          default(0), not null
#  frequency_id                    :integer          default(1), not null
#  subscription_master             :boolean          default(FALSE), not null
#  attachment_filename             :string
#  attachment_content_type         :string
#  attachment_size                 :integer
#  attachment_updated_at           :datetime
#  nii_type_id                     :integer
#  title_alternative_transcription :text
#  description                     :text
#  abstract                        :text
#  available_at                    :datetime
#  valid_until                     :datetime
#  date_submitted                  :datetime
#  date_accepted                   :datetime
#  date_caputured                  :datetime
#  pub_date                        :string
#  edition_string                  :string
#  volume_number                   :integer
#  issue_number                    :integer
#  serial_number                   :integer
#  content_type_id                 :integer          default(1)
#  year_of_publication             :integer
#  attachment_meta                 :text
#  month_of_publication            :integer
#  fulltext_content                :boolean
#  serial                          :boolean
#  statement_of_responsibility     :text
#  publication_place               :text
#  extent                          :text
#  dimensions                      :text
#  attachment_id                   :string
#  attachment_fingerprint          :string
#

require "spec_helper"

describe ManifestationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/manifestations" }.should route_to(:controller => "manifestations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/manifestations/new" }.should route_to(:controller => "manifestations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/manifestations/1" }.should route_to(:controller => "manifestations", :action => "show", :id => "1")
    end

    it "recognizes ISBN" do
      { :get => "/isbn/4798002062" }.should route_to(:controller => "manifestations", :action => "index", :isbn_id => "4798002062")
    end

    it "recognizes and generates #edit" do
      { :get => "/manifestations/1/edit" }.should route_to(:controller => "manifestations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/manifestations" }.should route_to(:controller => "manifestations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/manifestations/1" }.should route_to(:controller => "manifestations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/manifestations/1" }.should route_to(:controller => "manifestations", :action => "destroy", :id => "1")
    end

  end
end
