class Article < ActiveRecord::Base
  validates :url, :title, presence: true
  validates_format_of :url, with: %r{\Ahttps?://[[:alnum:]]+(\.[[:alnum:]]+)+}
end
