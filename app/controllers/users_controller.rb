class UsersController < ApplicationController

   def show
     @user = User.find(params[:id])
   end

   def followers
     @user = User.find(params[:id])
     @followers = @user.followers
   end

   def following
     @user = User.find(params[:id])
     @following = @user.followings
   end

   def friend
     @user= User.find(params[:id])
     if !current_user.friends_with? @user
       current_user.follow @user
       flash[:notice] = "#{@user.email} is now being followed"
     else
       flash[:error] = "Already following"
     end
     redirect_to :back
   end

   def unfriend
     @user= User.find(params[:id])
     if current_user.friends_with? @user
       current_user.unfriend @user
       flash[:notice] = "You unfollowed #{@user.email}"
     else
       flash[:error] = "Already following"
     end
     redirect_to :back
   end

end
