json.array!(@articles) do |article|
  json.extract! article, :id, :source, :title, :publication_date, :summary, :author, :images, :link
  json.url article_url(article, format: :json)
end
