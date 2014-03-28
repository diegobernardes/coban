module Coban
  module TK103B
    def self.parse(content)
      result = nil

      if content.start_with? '##'
        result = self.message_logon(content) 
      elsif content.include? ','
        result = self.message(content)
      else
        result = self.message_heartbeat(content)
      end

      return result
    rescue
      InvalidMessage.new "Error parsing message"
    end

    def self.message(content)
      message_headers = [
        :imei, :type, :date, :phone, :gps_status, :time,
        :gps_signal, :latitude, :north_south, :longitude,
        :east_west, :speed, :direction, :elevation, :acc,
        :door, :fuel, :oil, :temperatura
      ]

      splited_content = content.gsub('imei:','').gsub(';','').split(',', -1)

      result = {
        imei: splited_content[message_headers.index(:imei)],
        type: splited_content[message_headers.index(:type)],
        phone: splited_content[message_headers.index(:phone)],
        gps_status: splited_content[message_headers.index(:gps_status)],
        gps_signal: splited_content[message_headers.index(:gps_signal)],
        speed: splited_content[message_headers.index(:speed)],
        direction: splited_content[message_headers.index(:direction)]
      }

      if splited_content.count > 13
        result[:elevation] = splited_content[message_headers.index(:elevation)]
        result[:acc] = splited_content[message_headers.index(:acc)]
        result[:door] = splited_content[message_headers.index(:door)]
        result[:fuel] = splited_content[message_headers.index(:fuel)]
        result[:oil] = splited_content[message_headers.index(:oil)]
        result[:temperatura] = splited_content[message_headers.index(:temperatura)]
      end

      pre_latitude = splited_content[message_headers.index(:latitude)]
      latitude = pre_latitude[0...2].to_i(10) + ( pre_latitude[2...pre_latitude.size].to_f / 60 )
      latitude *= -1 if splited_content[message_headers.index(:north_south)] == 'S'

      pre_longitude = splited_content[message_headers.index(:longitude)]
      longitude = pre_longitude[0...3].to_i(10) + ( pre_longitude[3...pre_longitude.size].to_f / 60 )
      longitude *= -1 if splited_content[message_headers.index(:east_west)] == 'W'

      result[:latitude] = latitude
      result[:longitude] = longitude

      date = splited_content[message_headers.index(:date)]
      time = splited_content[message_headers.index(:time)]
      unless date.size == date.count('0')
        time = splited_content[message_headers.index(:time)]
        result[:date] = DateTime.strptime('20' + date[0...6] + time.split('.').first,'%Y%m%d%H%M%S')
      end

      return result
    end

    def self.message_logon(content)
      result = /##,imei:(?<imei>\d*).*;/.match(content)
      return { imei: result[:imei], type: :logon, response: 'LOAD' } if result
    end

    def self.message_heartbeat(content)
      result = /(?<imei>\d*)/.match(content)
      return { imei: result[:imei], type: :heartbeat, response: 'ON' } if result
    end
  end
end 
