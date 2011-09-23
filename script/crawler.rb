
class Crawler < Object

  require 'rubygems'
  require 'net/http'
  require 'json'
  require 'sequel'

  @@urls = { :temperture => { :domain => 'pipes.yahoo.com', :path => '/pipes/pipe.run?_id=e17fd4aaa45a95149728fe73e476b24e&_render=json' }}

  

  public
  
  def initialize()
    @db = Sequel.connect('mysql://root:root@127.0.0.1/tenki')  
  end

  def run()
    values      = getTempertures
    observedAt = values['value']['pubDate']
    
    values['value']['items'].each{|value|

      pointId = value['tenkiJP:amedas']['id']
      lat     = value['tenkiJP:amedas']['latitude']
      lng     = value['tenkiJP:amedas']['longitude']
      name    = value['tenkiJP:amedas']['name']

      @db[:point].insert(:point_id => pointId, :lat => lat, :lng => lng, :area_id => 1, :point_code => 'code')

    }
  end

  private

  def getTempertures()
    Net::HTTP.start(@@urls[:temperture][:domain], 80) {|http|
      json = JSON.parse(http.get(@@urls[:temperture][:path]).body)
      return json
    }
  end

  
end

crawler = Crawler.new
crawler.run
