class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create, :edit, :update, :destroy]

  def index
    @grams = Gram.all
  end

  def new
    @gram= Gram.new
  end

  def create
    @gram= current_user.grams.create(gramparams)
    if @gram.valid?   
      redirect_to root_path  
    else
      return render :new, status: :unprocessable_entity
    end
    
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    if @gram.blank?
      return render_not_found 
    end
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    if @gram.blank?
      return render_not_found
    end
    if @gram.user != current_user 
      render plain: "Forbidden :(", status: :forbidden
    end
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    
    if @gram.user != current_user 
      return render plain: "Forbidden :(", status: :forbidden
    end

    @gram.update_attributes(gramparams)
    if @gram.valid?
      return redirect_to root_path
    else
      return render :edit ,status: :unprocessable_entity
    end
      
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?

    if @gram.user != current_user 
      return render plain: "Forbidden :(", status: :forbidden
    end

    @gram.destroy
    redirect_to root_path
  end

  private

  def gramparams
    params.require(:gram).permit(:message, :picture)
  end

end