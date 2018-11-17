class ShortUrl < ApplicationRecord

  UNIQUE_ID_LENGTH = 6
  validates :original_url, presence: true, on: :create
  validates_format_of :original_url,
    with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  before_create :generate_shorts_url
  before_create :sanitize

  def generate_shorts_url
    url = ([*('a'..'z'),*('0'..'9')].sample(UNIQUE_ID_LENGTH).join)
    old_url = ShortUrl.where(shorts_url: url).last

    if old_url.present?
      self.generate_shorts_url
    else
      self.shorts_url = url
    end
  end

  def find_duplicate
    ShortUrl.find_by_sanitize_url(self.sanitize_url)
  end

  def new_url
    find_duplicate.nil?
  end

  def sanitize
    self.original_url.strip!
    self.sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
    self.sanitize_url = "http://#{self.sanitize_url}"
  end
end
