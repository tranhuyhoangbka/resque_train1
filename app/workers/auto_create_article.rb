class AutoCreateArticle
  @queue = :a_article

  def self.perform title, body
    Article.create title: title, body: body
  end
end
