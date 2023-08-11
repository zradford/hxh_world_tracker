class CharactersController < ApplicationController
  before_action :set_character, only: %i[ show edit update destroy level_up leveling_up ]

  # GET /characters or /characters.json
  def index
    characters = Character.all.includes(:abilities)

    @my_characters = characters.where(in_use_by_user_id: current_user.id)
    @team_characters = characters.where.not(in_use_by_user_id: [nil, current_user.id])
    @available = characters.where(in_use_by_user_id: nil)

    @is_available = params[:available]
  end

  # GET /characters/1 or /characters/1.json
  def show
  end

  # GET /characters/new
  def new
    @character = Character.new
    @character.name = "New Hunter"
  end

  # GET /characters/1/edit
  def edit
    @leveling_up = params[:leveling_up].present?
    @adding_abilities = params[:abilities].present?

    if @character.can_level_up? && @leveling_up
      @character.level = @character.level + 1
      @character.experience_points = 0
      @character.save(validate: false) 
    end
  end

  # POST /characters or /characters.json
  def create
    @character = Character.new(character_params)
    @character.created_by_user_id = current_user.id

    respond_to do |format|
      if @character.save
        format.html { redirect_to character_url(@character), notice: "Character was successfully created." }
        format.json { render json: @character }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1 or /characters/1.json
  def update

    if params[:ability_ids]
      Ability.where(id: character_params[:ability_ids]).each do |ability|
        ability.update(character_id: @character.id)
      end
    end

    @character.in_use_by_user_id = current_user.id unless current_user.admin?
    
    respond_to do |format|
      if @character.update(character_params.except(:ability_ids))
        format.html { redirect_to characters_path }
        format.js { render :index }
      else
        puts "uh oh: #{@character.errors.full_messages}"
      end
    end
  end

  # DELETE /characters/1 or /characters/1.json
  def destroy
    @character.destroy

    respond_to do |format|
      format.html { redirect_to characters_url, notice: "Character was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.require(:character).permit(:name, :level, :motivation, :specialty,
        :will, :move, :fight, :sense, :seek, :equipment,
        :plot_armor, :experience_points, :strength, :in_use_by_user_id, ability_ids: [])
    end
end
