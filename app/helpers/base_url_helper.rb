module BaseUrlHelper

  def base_url
    return 'https://sazon.id-arte.net' if Rails.env.production?
    'http://localhost:3000'
  end

  def build_url(ref, params = nil)
    "#{base_url}/#{ref}/#{params}"
  end

end
