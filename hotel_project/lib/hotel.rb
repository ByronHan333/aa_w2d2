require_relative "room"

class Hotel
  attr_reader :rooms

  def initialize(name, hash)
    @name = name
    @rooms = {}
    hash.each {|k,v| @rooms[k] = Room.new(v)}
  end

  def name
    @name.split.map(&:capitalize).join(' ')
  end

  def room_exists?(name)
    return true if @rooms.has_key?(name)
    false
  end

  def check_in(person, room)
    if !room_exists?(room)
      puts 'sorry, room does not exist'
    else
      if @rooms[room].add_occupant(person)
        puts 'check in successful'
      else
        puts 'sorry, room is full'
      end
    end
  end

  def has_vacancy?
    return true if @rooms.any?{|k,v| !v.full?}
    false
  end

  def list_rooms
    @rooms.each{|k,v| puts k + v.available_space.to_s }
    # puts "#{name}: #{room.available_space}"
  end
end
