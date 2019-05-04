class ComediansController < ApplicationController
  def index
    age = params[:age]
    # binding.pry
    if age.nil?
      @comedians = Comedian.all
      @specials = Special.all
      @unique_cities = Comedian.unique_cities
      @average_age = Comedian.average_age
    else
      @comedians = Comedian.comedian_age(age)
      @specials = Special.all
      @unique_cities = @comedians.unique_cities
      @average_age = @comedians.average_age
    end
  end

  def show
    @comedian = Comedian.find(params[:id])
  end

  def new
    comedian = Comedian.new
  end

  def create
    comedian = Comedian.create!(comedian_params)
    comedian.save
    redirect_to "/comedians"
  end

  private

  def comedian_params
    params.require(:comedian).permit(:name, :age, :city)
  end



end
