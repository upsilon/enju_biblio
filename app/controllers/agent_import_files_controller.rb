class AgentImportFilesController < ApplicationController
  load_and_authorize_resource

  # GET /agent_import_files
  # GET /agent_import_files.json
  def index
    @agent_import_files = AgentImportFile.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @agent_import_files }
    end
  end

  # GET /agent_import_files/1
  # GET /agent_import_files/1.json
  def show
    if @agent_import_file.agent_import.path
      unless Setting.uploaded_file.storage == :s3
        file = @agent_import_file.agent_import.path
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @agent_import_file }
      format.download {
        if Setting.uploaded_file.storage == :s3
          redirect_to @agent_import_file.agent_import.expiring_url(10)
        else
          send_file file, :filename => @agent_import_file.agent_import_file_name, :type => 'application/octet-stream'
        end
      }
    end
  end

  # GET /agent_import_files/new
  # GET /agent_import_files/new.json
  def new
    @agent_import_file = AgentImportFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @agent_import_file }
    end
  end

  # GET /agent_import_files/1/edit
  def edit
  end

  # POST /agent_import_files
  # POST /agent_import_files.json
  def create
    @agent_import_file = AgentImportFile.new(params[:agent_import_file])
    @agent_import_file.user = current_user

    respond_to do |format|
      if @agent_import_file.save
        format.html { redirect_to @agent_import_file, :notice => t('controller.successfully_created', :model => t('activerecord.models.agent_import_file')) }
        format.json { render :json => @agent_import_file, :status => :created, :location => @agent_import_file }
      else
        format.html { render :action => "new" }
        format.json { render :json => @agent_import_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agent_import_files/1
  # PUT /agent_import_files/1.json
  def update
    respond_to do |format|
      if @agent_import_file.update_attributes(params[:agent_import_file])
        format.html { redirect_to @agent_import_file, :notice => t('controller.successfully_updated', :model => t('activerecord.models.agent_import_file')) }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @agent_import_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agent_import_files/1
  # DELETE /agent_import_files/1.json
  def destroy
    @agent_import_file.destroy

    respond_to do |format|
      format.html { redirect_to(agent_import_files_url) }
      format.json { head :no_content }
    end
  end
end