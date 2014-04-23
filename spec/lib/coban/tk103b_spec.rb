require 'spec_helper'

describe Coban::TK103B do
  it "it should raise a InvalidMessage error" do
    begin
      Coban::TK103B.parse('adasdasdasd')
    rescue Exception => e
      e.class == Coban::InvalidMessage
    end
  end

  it "it should parse logon message" do
    message = '##,imei:359710041775538,A;'
    expected = { imei: '359710041775538', type: :logon, response: 'LOAD' }
    Coban::TK103B.parse(message).should == expected
  end

  it "it should parse hearbeat message" do
    message = '359710041775538'
    expected = { imei: '359710041775538', type: :heartbeat, response: 'ON' }
    Coban::TK103B.parse(message).should == expected
  end

  it "it should parse message" do
    message = 'imei:359710041775538,tracker,1403230739,,F,233944.000,A,2256.6289,S,04301.8645,W,0.81,152.26,,1,0,0.30%,,;'
    expected = { imei: "359710041775538", 
     type: "message", 
     sub_type: "tracker",
     phone: "", 
     gps_status: "F", 
     gps_signal: "A", 
     speed: "0.81", 
     direction: "152.26", 
     elevation: "", 
     acc: "1", 
     door: "0", 
     fuel: "0.30%", 
     oil: "", 
     temperatura: "", 
     latitude: -22.943815, 
     longitude: -43.031075, 
     date: DateTime.new(2014, 03, 23, 23, 39, 44),
     response: nil
   }
   Coban::TK103B.parse(message).should == expected
 end
end
