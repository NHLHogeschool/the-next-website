atom_feed language: 'nl-NL' do |feed|
  feed.title 'Minor The Next Web'
  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.url post_url(post)
      entry.title post.title
      entry.content markdown(post.body), type: :html
      entry.updated_at(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
      entry.author do |author|
        author.name 'Minor The Next Web'
      end
    end
  end
end
