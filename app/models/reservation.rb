class ReservationUniquenessValidator < ActiveModel::Validator
  def validate(record)
    if(record.ship_id == nil or record.location_id == nil)
      record.errors[:base] << "The ship or the location does not exist"
    elsif Reservation.where(date: record.date.beginning_of_day, slice: record.slice, ship_id: record.ship_id, location_id: record.location_id).first != nil
      record.errors[:base] << "This ship has already booked the place at that time"
    end
  end
end

class ShipPresenceValidator < ActiveModel::Validator
  def validate(record)
    if(record.ship_id == nil or record.location_id == nil)
      record.errors[:base] << "The ship or the location does not exist"
    elsif(Record.where(ship_id: record.ship_id, location_id: record.location_id))
      record.errors[:base] << "There is already a boat at this place"
    end
  end
end

class Reservation
  include Mongoid::Document

  before_save { |res| res.date = res.date.beginning_of_day }

  field :date, type: Time
  # slice of the day 1 < slice < 5
  field :slice, type: Integer

  validates :slice, inclusion: 1..5

  validates :date, :slice, :ship_id, :location_id, presence: true

  index([[:date], [:ship], [:location]],
    unique: true
  )

  has_one :ship
  has_one :location

  validates_with ReservationUniquenessValidator 
  validates_with ShipPresenceValidator
end

