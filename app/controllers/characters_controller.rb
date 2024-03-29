class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)

    @character.television_show_id = params[:television_show_id]

    if @character.save
      flash[:notice] = "Success!"
      redirect_to "/television_shows/#{params[:television_show_id]}/characters"
    else
      flash.now[:notice] = "Your character couldn't be saved."
      render :new
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    if @character.destroy
      flash[:notice] = "Deleted #{@character.name}."
      redirect_to characters_path
    else
      flash.now[:notice] = "Your character couldn't be deleted."
      render :show
    end

  end

  private

  def character_params
    params.require(:character).permit(:name, :actor, :description)
  end
end
