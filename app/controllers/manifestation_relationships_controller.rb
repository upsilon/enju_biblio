class ManifestationRelationshipsController < ApplicationController
  load_and_authorize_resource
  before_filter :get_manifestation
  before_filter :prepare_options, only: [:new, :edit]
  after_filter :solr_commit, only: [:create, :update, :destroy]

  # GET /manifestation_relationships
  # GET /manifestation_relationships.json
  def index
    case
    when @manifestation
      @manifestation_relationships = @manifestation.manifestation_relationships.order('manifestation_relationships.position').page(params[:page])
    else
      @manifestation_relationships = ManifestationRelationship.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manifestation_relationships }
    end
  end

  # GET /manifestation_relationships/1
  # GET /manifestation_relationships/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manifestation_relationship }
    end
  end

  # GET /manifestation_relationships/new
  def new
    if @manifestation.blank?
      redirect_to manifestations_url
      return
    else
      @manifestation_relationship = ManifestationRelationship.new
      @manifestation_relationship.manifestation = @manifestation
    end
  end

  # GET /manifestation_relationships/1/edit
  def edit
  end

  # POST /manifestation_relationships
  # POST /manifestation_relationships.json
  def create
    @manifestation_relationship = ManifestationRelationship.new(params[:manifestation_relationship])

    respond_to do |format|
      if @manifestation_relationship.save
        format.html { redirect_to @manifestation_relationship, notice: t('controller.successfully_created', model: t('activerecord.models.manifestation_relationship')) }
        format.json { render json: @manifestation_relationship, status: :created, location: @manifestation_relationship }
      else
        prepare_options
        format.html { render action: "new" }
        format.json { render json: @manifestation_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /manifestation_relationships/1
  # PUT /manifestation_relationships/1.json
  def update
    # 並べ替え
    if @manifestation and params[:move]
      move_position(@manifestation_relationship, params[:move], false)
      redirect_to manifestation_relationships_url(manifestation_id: @manifestation_relationship.parent_id)
      return
    end

    respond_to do |format|
      if @manifestation_relationship.update_attributes(params[:manifestation_relationship])
        format.html { redirect_to @manifestation_relationship, notice: t('controller.successfully_updated', model: t('activerecord.models.manifestation_relationship')) }
        format.json { head :no_content }
      else
        prepare_options
        format.html { render action: "edit" }
        format.json { render json: @manifestation_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manifestation_relationships/1
  # DELETE /manifestation_relationships/1.json
  def destroy
    @manifestation_relationship.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = t('controller.successfully_deleted', model: t('activerecord.models.manifestation_relationship'))
        if @manifestation
          redirect_to manifestations_url(manifestation_id: @manifestation.id)
        else
          redirect_to manifestation_relationships_url
        end
      }
      format.json { head :no_content }
    end
  end

  private
  def prepare_options
    @manifestation_relationship_types = ManifestationRelationshipType.all
  end
end
