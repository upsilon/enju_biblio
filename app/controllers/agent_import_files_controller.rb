# == Schema Information
#
# Table name: agent_import_files
#
#  id                        :integer          not null, primary key
#  parent_id                 :integer
#  content_type              :string
#  size                      :integer
#  user_id                   :integer
#  note                      :text
#  executed_at               :datetime
#  agent_import_filename     :string
#  agent_import_content_type :string
#  agent_import_size         :integer
#  agent_import_updated_at   :datetime
#  created_at                :datetime
#  updated_at                :datetime
#  agent_import_fingerprint  :string
#  error_message             :text
#  edit_mode                 :string
#  user_encoding             :string
#  agent_import_id           :string
#

class AgentImportFilesController < ApplicationController
  before_action :set_agent_import_file, only: [:show, :edit, :update, :destroy]
  before_action :check_policy, only: [:index, :new, :create]

  # GET /agent_import_files
  # GET /agent_import_files.json
  def index
    @agent_import_files = AgentImportFile.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agent_import_files }
    end
  end

  # GET /agent_import_files/1
  # GET /agent_import_files/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agent_import_file }
      format.download {
        send_file @agent_import_file.agent_import.download,
          filename: File.basename(@agent_import_file.agent_import_filename),
          type: 'application/octet-stream'
      }
    end
  end

  # GET /agent_import_files/new
  # GET /agent_import_files/new.json
  def new
    @agent_import_file = AgentImportFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agent_import_file }
    end
  end

  # GET /agent_import_files/1/edit
  def edit
  end

  # POST /agent_import_files
  # POST /agent_import_files.json
  def create
    @agent_import_file = AgentImportFile.new(agent_import_file_params)
    @agent_import_file.user = current_user

    respond_to do |format|
      if @agent_import_file.save
        if @agent_import_file.mode == 'import'
          AgentImportFileJob.perform_later(@agent_import_file)
        end
        format.html { redirect_to @agent_import_file, notice: t('controller.successfully_created', model: t('activerecord.models.agent_import_file')) }
        format.json { render json: @agent_import_file, status: :created, location: @agent_import_file }
      else
        format.html { render action: "new" }
        format.json { render json: @agent_import_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /agent_import_files/1
  # PUT /agent_import_files/1.json
  def update
    respond_to do |format|
      if @agent_import_file.update_attributes(agent_import_file_params)
        if @agent_import_file.mode == 'import'
          AgentImportFileJob.perform_later(@agent_import_file)
        end
        format.html { redirect_to @agent_import_file, notice: t('controller.successfully_updated', model: t('activerecord.models.agent_import_file')) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent_import_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agent_import_files/1
  # DELETE /agent_import_files/1.json
  def destroy
    @agent_import_file.destroy

    respond_to do |format|
      format.html { redirect_to agent_import_files_url, notice: t('controller.successfully_deleted', model: t('activerecord.models.agent_import_file')) }
      format.json { head :no_content }
    end
  end

  private
  def set_agent_import_file
    @agent_import_file = AgentImportFile.find(params[:id])
    authorize @agent_import_file
    access_denied unless LibraryGroup.site_config.network_access_allowed?(request.ip)
  end

  def check_policy
    authorize AgentImportFile
  end

  def agent_import_file_params
    params.require(:agent_import_file).permit(
      :attachment, :edit_mode, :user_encoding, :mode
    )
  end
end
