# Retrieve synonymses using big huge Thesaurus api
# to be used in finding users' interested articles

class SynonymsFinder
  def initialize
    @url = 'http://words.bighugelabs.com'
    @KEY = 'd645560969a13ed43993da836eaedda6'
  end

  def getSynonyms word
    synonymses = []
    synonymses.push(word)


    uri = URI.parse(@url)
    http = Net::HTTP.new(uri.host, uri.port)
    request_url = '/api/2/' << @KEY << '/' << word << '/' <<'json'
    response = http.send_request('GET', request_url)

    if response.code == '200'
      puts 'response: 2000000000000000000000'
      @response_json = JSON.parse(response.body)

      synonymses = synonymses + parse
    end

    return synonymses

  end

  def parse
    synonymses = []

    if @response_json.has_key?('noun')
      synonymses = synonymses + @response_json['noun']['syn']
    end

    if @response_json.has_key?('verb')
       synonymses = synonymses + @response_json['verb']['syn']
    end

    if @response_json.has_key?('adjective')
       synonymses = synonymses + @response_json['adjective']['syn']
    end

    if @response_json.has_key?('adverb')
       synonymses = synonymses + @response_json['adverb']['syn']
    end

    return synonymses
  end
end