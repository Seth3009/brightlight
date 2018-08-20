class CommentsController < ApplicationController

  # POST /comments.js
  def create
    @comment = Comment.new(comment_params)
    authorize! :create, @comment

    respond_to do |format|
      if @comment.save
        format.js
      end
    end
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:title, :comment, :user_id, :commentable_type, :commentable_id, :role)
    end
end
