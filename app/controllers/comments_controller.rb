class CommentsController < ApplicationController
  before_action :user_logged_in?

  def new
  end

  def create
  	Comment.find_by_id(params[:parent_id]) if params[:parent_id]
  	comment = Comment.new(permit_params)
  	comment.user_id = current_user.id
  	if params[:game_id]
  	  comment.pcomment_type = 'Game'
  	  comment.pcomment_id = params[:game_id]
  	  comment.body = params[:comment][:body]
  	  comment.parent_id = params[:parent_id] if params[:parent_id]
  		if comment.save
  	  	flash[:notice] = "Comment was published in #{comment.pcomment_type}-#{comment.pcomment_id}"
  	  	redirect_to game_path(id: comment.pcomment_id)
  	 	end
  	elsif params[:blog_id]
  		if comment.save(body: params[:comment][:body], user_id: params[:user_id],
  	 		pcomment_id: params[:blog_id], pcomment_type: 'Blog')
  	    flash[:notice] = "Comment was published in #{comment.pcomment_type}-#{comment.pcomment_id}"
  		  redirect_to blog_path(id: comment.pcomment_id)
  	  end
  	end
  end

  def create_nested_comment
  end


  def index
  end

  def destroy
  	comment = Comment.find(params[:id])
  	if comment && !comment.deleted_at
  	  comment.destroy_body
  	  flash[:notice] = "comment deleted #{Time.zone.now}"
  	  id = comment.pcomment_id
  	  comment.pcomment_type = "Game" ? redirect_to(game_path(id)) : redirect_to(blog_path(id))
  	else
  	  flash[:alert] = "comment was deleted at #{comment.deleted_at}"
  	  redirect_to root_url
  	end
  end

  private

  def permit_params
  	params.require(:comment).permit(:body, :user_id, :pcomment_id, :pcomment_type, :parent_id, 
  		:number_nesting)
  end

  def user_logged_in?
    redirect_to login_path unless logged_in?

  end
end
