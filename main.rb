require "net/http"
require "json"

# Set environment variables
CSE_API_KEY = ENV["CSE_API_KEY"]
CSE_ENGINE_ID = ENV["CSE_ENGINE_ID"]

class Engine
  # Prompts user for query and invokes CSE API
  def initialize
    print "Input search query > "
    @@query = gets.to_s
    google(@@query)
    initialize
  end

  # Sends HTTP request and receives data based on user input
  def google(query)
    # API key, engine id, and uri to make API call
    key = CSE_API_KEY
    # "AIzaSyDpp4azZVRsBYgmjAqSI-Z-PIZG8FI-hfw"
    engine_id = CSE_ENGINE_ID
    # "011724650152002634172:r-e9bq2ubda"
    uri = URI("https://www.googleapis.com/customsearch/v1?cx=#{engine_id}&q=#{query}&key=#{key}")

    # GET request
    request = Net::HTTP::Get.new(uri)

    # Receive response
    res = Net::HTTP.get_response(uri)

    # Parse JSON file and converts to hash
    json = JSON.parse(res.body)
    items = json['items']

    # Iterate through JSON/items array and print each index
    i = 0
    loop do
      puts (i+1).to_s + " -- " + items[i]['title']
      # puts items[i]['link'] # url
      # puts items[i]['snippet'] # snippet of article
      i += 1
      if i == items.length
        break
      end
    end
  end
end

Engine.new
