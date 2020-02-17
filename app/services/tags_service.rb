class TagsService
  def self.create_post_tags(tags, post_id)
    tags.each do |tag| 
      Tag.new(content: tag, post_id: post_id).save!
    end
  end

  def self.update(tags, post_id)
    Tag.where("post_id = ?", post_id).delete_all
    create_post_tags(tags, post_id)
  end
end