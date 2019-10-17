class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @gram = Gram.find_by_id(params[:gram_id])

    if @gram.blank?
      return render_not_found
    else
      @gram.comments.create(comments_params.merge(user: current_user))
      redirect_to root_path      
    end

  end


  private

  def comments_params
    params.require(:comment).permit(:message)
  end 



end
