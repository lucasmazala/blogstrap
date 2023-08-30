class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :trackable , :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
