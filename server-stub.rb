#!/usr/bin/env ruby

require 'socket'

vars = {
  :"battery.charge" => "96",
  :"battery.charge.low" => "20",
  :"battery.runtime" => "672",
  :"battery.type" => "PbAc",
  :"device.mfr" => "EATON",
  :"device.model" => "Eaton 3S 550",
  :"device.serial" => "000000000",
  :"device.type" => "ups",
  :"driver.name" => "usbhid-ups",
  :"driver.parameter.pollfreq" => "30",
  :"driver.parameter.pollinterval" => "2",
  :"driver.parameter.port" => "auto",
  :"driver.parameter.synchronous" => "no",
  :"driver.version" => "2.7.4",
  :"driver.version.data" => "MGE HID 1.39",
  :"driver.version.internal" => "0.41",
  :"input.transfer.high" => "264",
  :"input.transfer.low" => "184",
  :"outlet.1.desc" => "PowerShare Outlet 1",
  :"outlet.1.id" => "2",
  :"outlet.1.status" => "on",
  :"outlet.1.switchable" => "yes",
  :"outlet.2.desc" => "PowerShare Outlet 2",
  :"outlet.2.id" => "3",
  :"outlet.2.status" => "off",
  :"outlet.2.switchable" => "yes",
  :"outlet.desc" => "Main Outlet",
  :"outlet.id" => "1",
  :"outlet.switchable" => "no",
  :"output.frequency.nominal" => "50",
  :"output.voltage" => "230.0",
  :"output.voltage.nominal" => "230",
  :"ups.beeper.status" => "enabled",
  :"ups.delay.shutdown" => "20",
  :"ups.delay.start" => "30",
  :"ups.firmware" => "02",
  :"ups.load" => "30",
  :"ups.mfr" => "EATON",
  :"ups.model" => "Eaton 3S 550",
  :"ups.power.nominal" => "550",
  :"ups.productid" => "ffff",
  :"ups.serial" => "000000000",
  :"ups.status" => "OL",
  :"ups.timer.shutdown" => "0",
  :"ups.timer.start" => "0",
  :"ups.vendorid" => "0463",
}

server = TCPServer.new 3493
loop do
  Thread.start(server.accept) do |client|
    while line = client.gets
      puts line.chomp
      if line =~ /^(USERNAME|PASSWORD|LOGIN)/i
        client.puts "OK"
      elsif line =~ /^GET VAR ([a-zA-Z0-9]+) ([a-zA-Z0-9\.]+)/i
        client.puts "VAR #{$1} #{$2} \"#{vars[$2.to_sym]}\""
      else
        client.puts "ERR UNKNOWN-COMMAND"
      end
    end
    client.close
  end
end

