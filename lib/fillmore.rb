require 'httparty'
require 'uri'

class Fillmore
  API_URL = 'http://api.openweathermap.org/data/2.5/weather'
  
  def fetch(location)
    response = HTTParty.get "#{API_URL}?q=#{URI.escape(location)}"
    
    binding.pry
    o = JSON.parse response.body
    o
  end

  def format(obj)
    outcome = "#{obj['name']}"
    
    country = obj['sys']['country']

    if !country.nil?
      outcome += " (#{country})"


      outcome += "\n #{obj['weather'].first['main']}"

      description = obj['weather'].first['description']

      if !description.nil?
        outcome += " - #{description}"
      end

      temp = obj['main']['temp']
      celsius = temp.to_f - 273.15
      fahrenheit = celsius * 1.8 + 32

      outcome += "\n #{celsius.to_i} C / #{fahrenheit.to_i} F"
    end



  end

  def run location
    puts format(fetch(location))
  end
end