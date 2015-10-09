class ResidentialsController < ApplicationController
  before_action :set_residential, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]
  # GET /residentials
  # GET /residentials.json
  def search
    if params[:search].present?
      @residentials = Residential.search(params[:search])
    else
      @residentials = Residential.all
    end
  end
  def autocomplete
    render json: Residential.search(params[:query], fields:[{name: :text_start}], limit: 10).map(&:name)
  end

  def bedrooms
    if params[:bedrooms].present?
      @residentials = Residential.bedrooms(params[:bedrooms])
    else
      @residentials = Residential.all
    end
  end
  
  def index
    @residentials = Residential.all
     respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @residentials }

      # Example: Basic Usage
      #format.pdf {send_data render_to_string, filename: 'Ata_2005', type: 'application/pdf', disposition: 'attachment'}
      format.pdf { render_residential_list(@residentials) }
    end
  end
  #def index
  #@search = Residential.search(params[:q])
  #@residentials = @search.result
  #end

  # GET /residentials/1
  # GET /residentials/1.json
  def show
    
  end

  # GET /residentials/new
  def new
    if current_user.isRealtor?
      @residential = Residential.new
    else
      redirect_to root_url
    end

  end

  # GET /residentials/1/edit
  def edit
  end

  # POST /residentials
  # POST /residentials.json
  def create
    @residential = Residential.new(residential_params)
    @residential.user_id = current_user.id
    respond_to do |format|
      if @residential.save
        format.html { redirect_to @residential, notice: 'Residential was successfully created.' }
        format.json { render :show, status: :created, location: @residential }
      else
        format.html { render :new }
        format.json { render json: @residential.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /residentials/1
  # PATCH/PUT /residentials/1.json
  def update
    respond_to do |format|
      if @residential.update(residential_params)
        format.html { redirect_to @residential, notice: 'Residential was successfully updated.' }
        format.json { render :show, status: :ok, location: @residential }
      else
        format.html { render :edit }
        format.json { render json: @residential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /residentials/1
  # DELETE /residentials/1.json
  def destroy
    @residential.destroy
    respond_to do |format|
      format.html { redirect_to residentials_url, notice: 'Residential was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_residential
      @residential = Residential.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def residential_params
      params.require(:residential).permit(:bedrooms, :construction_type, :mls_number, :action, :green_certification, :half_bathrooms, :square_feet, :lot_size, :zip_code, :area_tennis, :wheelchair, :city, :address, :additionalfeatures, :energy_features, :keymap, :elevator, :realtoremail, :realtorname, :full_bathrooms, :realorlicense, :private_pool, :status, :property_type, :patio_deck, :image)
    end

    def check_user
      if current_user != @residential.user
        redirect_to root_url, alert: "Sorry, this listing belongs to someone else"
      end
    end

     def render_residential_list(residentials)
    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'residentials.tlf')
    

    report.start_new_page do |page|
       @residentials.each do |residential|

          page.item(:textcodigo).value residential.full_bathrooms
          page.item(:textprofesional).value residential.realtorname
          page.item(:textestablecimiento).value residential.realtoremail
          page.item(:textnombre).value residential.realorlicense
          page.item(:texttipoestable).value residential.private_pool
          page.item(:textdeparta).value residential.area_tennis
          page.item(:textfecha).value residential.status
          page.item(:textmunicipio).value residential.wheelchair
          page.item(:ce).value residential.property_type
          page.item(:e).value residential.property_type
          page.item(:f).value residential.property_type
          page.item(:textespe).value residential.patio_deck
         report.page.residential(:residential).add_row do |row|
          row.item(:texthc).value residential.bedrooms
          page.item(:textnombreapellido).value residential.construction_type
          page.item(:textidentidad).value residential.mls_number
          page.item(:textsexo).value residential.action
          page.item(:textfechanaci).value residential.green_certification
          page.item(:texta).value residential.half_bathrooms
          page.item(:textm).value residential.square_feet
          page.item(:textd).value residential.lot_size
          page.item(:textpaci).value residential.zip_code
          page.item(:textdeparta1).value residential.area_tennis
          page.item(:textmunicipio1).value residential.wheelchair
          page.item(:textlocalidad1).value residential.city
          page.item(:textcondi1).value residential.address
          page.item(:textcondi2).value residential.additionalfeatures
          page.item(:textcondi3).value residential.energy_features
          page.item(:textenviada).value residential.keymap
          page.item(:textrecibida).value residential.elevator
       end

      

          page.item(:texthc1).value residential.bedrooms
          page.item(:textnombreapellido2).value residential.construction_type
          page.item(:textidentidad1).value residential.mls_number
          page.item(:textsexo1).value residential.action
          page.item(:textfechanaci1).value residential.green_certification
          page.item(:texta1).value residential.half_bathrooms
          page.item(:textm1).value residential.square_feet
          page.item(:textd1).value residential.lot_size
          page.item(:textpaci1).value residential.zip_code
          page.item(:textdeparta2).value residential.area_tennis
          page.item(:textmunicipio2).value residential.wheelchair
          page.item(:textlocalidad2).value residential.city
          page.item(:textcondi12).value residential.address
          page.item(:textcondi21).value residential.additionalfeatures
          page.item(:textcondi32).value residential.energy_features
          page.item(:textenviada1).value residential.keymap
          page.item(:textrecibida1).value residential.elevator
       end
end

    send_data report.generate, filename: 'Ata_2005.pdf', 
                               type: 'application/pdf', 
                               disposition: 'attachment'
  
end
end 
