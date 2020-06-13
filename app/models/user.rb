class User < ApplicationRecord
  ROLES = [
    "ADMIN",
    "USER"
  ]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
  
  attr_accessor :login

  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true, inclusion: { in: ROLES }

  has_one :bank_accounts

  before_validation :load_defaults

  after_commit :create_bank_account, on: :create

  def create_bank_account
    BankAccount.create!(
                    id: User.last.id,
                    user_id: User.last.id,
                    balance: 0.00,
                    account_number: generate_account_number)
  end

  def generate_account_number
    numbers = "11 2020 "
    for i in 1..20
      numbers += SecureRandom.random_number(10).to_s
      if i%4 == 0 && i != 20
        numbers += " "
      end
    end
    numbers
  end

  def load_defaults
    if self.new_record?
      self.role = "USER" if self.role.nil?
    end

    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end

  def admin?
    role == "ADMIN"
  end

  def to_s
    email
  end

  def show_id
    id
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def account_number
    BankAccount.where(user_id: id).last.account_number
  end

  def full_details
    "#{last_name}, #{first_name} (#{username})"
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions.first)
      else
        where(username: conditions[:username]).first
      end
    end
  end
end
