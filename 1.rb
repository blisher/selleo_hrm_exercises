class PinValidator
  def self.validate(card, pin)
    card.valid_pin?(pin)
  end
end

class AtmMachine
  def initialize(start_cash, validator)
    @validator = validator
    @cash = start_cash
  end

  def has_card_inside?
    !!@current_card
  end

  def insert_card(card, token)
    if card.is_disabled?
      puts 'Card is disabled!'
      false
    elsif @validator.validate(card, token)
      @current_card = card
      puts 'Access granted!'
      true
    else
      puts 'WRONG PIN NUMBER'
      card.disable!
      false
    end
  end

  def display_cash_inside
    puts "ATM has $#{@cash} inside."
  end

  def eject_card
    if @current_card.nil?
      puts "Error: no card inside"
      false
    else
      @current_card = nil
      puts "Card ejected"
      true
    end
  end

  def display_card_balance
    puts "Card balance: $#{@current_card.balance}"
  end

  def withdraw(amount)
    if amount > @cash
      puts "ATM machine does not have enough cash"
      return false
    end

    if @current_card.can_withdraw?(amount)
      money_left = @current_card.withdraw!(amount)
      @cash -= amount
      puts "Withdrew $#{amount}. Money left: $#{money_left}."
      true
    elsif
      puts "You cannot withdraw $#{amount}. You have only $#{@current_card.balance}"
      false
    end
  end

  def deposit(amount)
    new_balance = @current_card.deposit!(amount)
    @cash += amount
    puts "Deposited $#{amount}. New balance: $#{new_balance}."
    true
  end
end

class CreditCard
  attr_reader :balance

  def initialize(pin, start_balance = 0)
    @pin = pin
    @disabled = false
    @balance = start_balance
  end

  def valid_pin?(pin)
    @pin == pin
  end

  def enable!
    disabled = false
    puts 'Card is enabled.'
  end

  def disable!
    @disabled = true
    puts 'CARD IS DISABLED!!!'
  end

  def can_withdraw?(amount)
    amount <= @balance
  end

  def withdraw!(amount)
    @balance -= amount
    @balance
  end

  def deposit!(amount)
    @balance += amount
    @balance
  end

  def is_disabled?
    @disabled
  end
end

# check all features below

# checking "disabled feature"
def disabled_feature
	atm = AtmMachine.new(100, PinValidator)
	card = CreditCard.new(1234, 30)
	atm.insert_card(card, 666)
	atm.insert_card(card, 1234)
end

# correct money withdraw
def correct_withdraw
	atm = AtmMachine.new(100, PinValidator)
	card = CreditCard.new(1234, 30)
	atm.insert_card(card, 1234)
  atm.display_cash_inside
	atm.withdraw(10)
	atm.display_card_balance
  atm.display_cash_inside
end

# cannot withdraw more than card balance
def poor_card
	atm = AtmMachine.new(100, PinValidator)
	card = CreditCard.new(1234, 30)
	atm.insert_card(card, 1234)
	atm.withdraw(50)
	atm.display_card_balance
end

# cannot withdraw more than atm cash
def poor_atm
	card = CreditCard.new(1234, 30)
	poor_atm = AtmMachine.new(10, PinValidator)
	poor_atm.insert_card(card, 1234)
	poor_atm.withdraw(20)
end

def depositing
  atm = AtmMachine.new(100, PinValidator)
  card = CreditCard.new(1234, 30)
  atm.insert_card(card, 1234)
  atm.display_cash_inside
  atm.display_card_balance
  atm.deposit(15)
  atm.display_cash_inside
  atm.display_card_balance
end

def insert_and_eject_card
  atm = AtmMachine.new(100, PinValidator)
  card = CreditCard.new(1234, 30)
  puts "ATM has card inside: #{atm.has_card_inside?}"
  atm.insert_card(card, 1234)
  puts "ATM has card inside: #{atm.has_card_inside?}"
  atm.eject_card
  puts "ATM has card inside: #{atm.has_card_inside?}"
end

# correct_withdraw
# disabled_feature
# poor_card
# poor_atm
# depositing
# insert_and_eject_card