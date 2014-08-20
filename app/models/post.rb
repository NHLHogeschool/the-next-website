class Post < ActiveRecord::Base
  belongs_to :author
  default_scope -> { order('created_at desc') }

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
