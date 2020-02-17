class PostJob
  include Sidekiq::Worker

  def perform
    posts_ids = Post.all.where('created_at <= ?', 1.day.ago).pluck(:id)
    posts_ids.each do |id|
      Tag.where("post_id = ?",id).delete_all
      Comment.where("post_id = ?", id).delete_all
    end 
    Post.all.where('created_at <= ?', 1.day.ago).delete_all
  end
end
