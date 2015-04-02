class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { minimum: 2, maximum: 15 }
  validates :last_name,  presence: true, length: { minimum: 2, maximum: 25 }

  def name
    [first_name, last_name].compact.join(' ')
  end

end
