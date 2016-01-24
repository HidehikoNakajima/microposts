class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.content = @micropost.content
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) 
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  def retweet
    micropost = Micropost.new
    user = User.find_by id: params[:baseuser_id]
    baseuser_name = user.name
    micropost.attributes = {user_id: current_user.id, 
                            content: params[:content], 
                            baseid: params[:id],
                            baseuser_id: params[:baseuser_id],
                            baseuser_name: baseuser_name}
    if micropost.save
      flash[:success] = "Retweet created!"
      redirect_to root_url
    else
      render 'static_pages/home'
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) 
    end    
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
    
end
