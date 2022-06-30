module GroupsHelper
  def image_validation(url)
    image_tag(url)
  rescue StandardError || OpenURI::HTTPError
    'no-image-icon.png'
  else
    url
  end
end
