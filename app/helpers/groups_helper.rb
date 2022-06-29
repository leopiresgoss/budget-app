module GroupsHelper
  def image_validation(url)
    image_tag(url)
  rescue StandardError
    'no-image-icon.png'
  else
    url
  end
end
