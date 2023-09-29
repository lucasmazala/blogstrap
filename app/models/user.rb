class User < ApplicationRecord
  rolify
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :trackable , :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
