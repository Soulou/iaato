class Ship
  include Mongoid::Document

  field :name
  field :position, type: Array
  field :email, type: String
  field :phone, type: String
  field :call_sign, type: String

  belongs_to :operator
  belongs_to :ship_class

  validates :name, uniqueness: true, presence: true

  attr_accessible :name, :position, :email, :phone
end
