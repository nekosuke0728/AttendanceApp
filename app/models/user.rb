class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum gender: { 
    male: 0, 
    female: 1, 
    lgbt: 2 
  }
  enum employment_status: { 
    regular_employee: 0, 
    contract_employee: 1, 
    part_time_job: 2,
    other: 3
  }

  validates :name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :employment_status, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  
end
