class Address < ApplicationRecord
  belongs_to :owner, polymorphic: true

  enum state: %i[AL AK AS AZ AR CA CO CT DE DC FL GA GU HI ID IL IN IA KS KY LA ME MD MH MA MI FM MN MS MO MT NE NV NH NJ NM NY NC ND MP OH OK OR PW PA PR RI SC SD TN TX UT VT VA VI WA WV WI WY]

  validates_presence_of %i[line_1 city state zip]
  validates :zip, format: /\A\d{5}\z/

  def self.make_default(id, owner)
    find_by(owner: owner, default: true).toggle!(:default)
    find(id).toggle!(:default)
  end
end
