class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    @post.user_id == @user.id
  end

  def delete?
    @post.user_id == @user.id
  end

  def update_tags?
    @post.user_id == @user.id
  end
end