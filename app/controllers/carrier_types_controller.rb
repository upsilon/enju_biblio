# == Schema Information
#
# Table name: carrier_types
#
#  id                      :integer          not null, primary key
#  name                    :string           not null
#  display_name            :text
#  note                    :text
#  position                :integer
#  created_at              :datetime
#  updated_at              :datetime
#  attachment_id           :string
#  attachment_filename     :string
#  attachment_size         :integer
#  attachment_content_type :string
#

class CarrierTypesController < ApplicationController
  before_action :set_carrier_type, only: [:show, :edit, :update, :destroy]
  before_action :check_policy, only: [:index, :new, :create]
  before_action :prepare_options, only: [:new, :edit]

  # GET /carrier_types
  # GET /carrier_types.json
  def index
    @carrier_types = CarrierType.order(:position).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carrier_types }
    end
  end

  # GET /carrier_types/1
  # GET /carrier_types/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @carrier_type }
    end
  end

  # GET /carrier_types/new
  # GET /carrier_types/new.json
  def new
    @carrier_type = CarrierType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carrier_type }
    end
  end

  # GET /carrier_types/1/edit
  def edit
  end

  # POST /carrier_types
  # POST /carrier_types.json
  def create
    @carrier_type = CarrierType.new(carrier_type_params)

    respond_to do |format|
      if @carrier_type.save
        format.html { redirect_to @carrier_type, notice: t('controller.successfully_created', model: t('activerecord.models.carrier_type')) }
        format.json { render json: @carrier_type, status: :created, location: @carrier_type }
      else
        prepare_options
        format.html { render action: "new" }
        format.json { render json: @carrier_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carrier_types/1
  # PUT /carrier_types/1.json
  def update
    if params[:move]
      move_position(@carrier_type, params[:move])
      return
    end

    respond_to do |format|
      if @carrier_type.update_attributes(carrier_type_params)
        format.html { redirect_to @carrier_type, notice: t('controller.successfully_updated', model: t('activerecord.models.carrier_type')) }
        format.json { head :no_content }
      else
        prepare_options
        format.html { render action: "edit" }
        format.json { render json: @carrier_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_types/1
  # DELETE /carrier_types/1.json
  def destroy
    @carrier_type.destroy

    respond_to do |format|
      format.html { redirect_to carrier_types_url, notice: t('controller.successfully_deleted', model: t('activerecord.models.carrier_type')) }
      format.json { head :no_content }
    end
  end

  private
  def set_carrier_type
    @carrier_type = CarrierType.find(params[:id])
    authorize @carrier_type
    access_denied unless LibraryGroup.site_config.network_access_allowed?(request.ip)
  end

  def check_policy
    authorize CarrierType
  end

  def carrier_type_params
    params.require(:carrier_type).permit(
      :name, :display_name, :note, :position, :attachment,
      # EnjuCirculation
      {
        :carrier_type_has_checkout_types_attributes => [
          :id, :checkout_type_id, :_destroy
        ]
      }
    )
  end

  def prepare_options
    if defined?(EnjuCirculation)
      @checkout_types = CheckoutType.select([:id, :display_name, :position])
    end
  end
end
