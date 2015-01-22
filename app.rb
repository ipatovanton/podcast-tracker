require 'json'

class PodcastDownload < Sinatra::Base
  register Sinatra::Async

  SITE_HOST = 'podcast.steer.me'
  GA_ID= ENV['GA_ID']

  aget '/' do
    redirect "#{request.scheme}://#{SITE_HOST}/"
  end

  aget '/episode.:format' do

    # Get params
    url, title = params[:url], params[:title]
    error('Bad Request') and return unless url && title

    # Send to Google Analytics
    Gabba::Gabba.new(GA_ID, SITE_HOST).event("Episodes", "Server Download", "Episode: #{title}", nil, true)

    # Redirect to the URL
    redirect url
  end

  aget '/ping' do
    content_type 'text/plain'
    ahalt 200, 'Pong!'
  end

  aget '*' do
    error('Not Found', 404)
  end

  private

  def error(message, status=400)
    content_type 'text/plain'
    ahalt status, message
  end

end