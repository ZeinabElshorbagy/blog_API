class CommentPolicy < ApplicationPolicy
    attr_reader :user, :comment
  
    def initialize(user, comment)
      @user = user
      @comment = comment
    end
  
    def update?
      @comment.user_id == @user.id
    end
  
    def delete?
      @comment.user_id == @user.id
    end
  end