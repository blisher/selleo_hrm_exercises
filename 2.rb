class Person
	attr_accessor :tasks

	def initialize
		@tasks = []
	end
end

person = Person.new
person.tasks << [ 'Wash the dishes', false ]
person.tasks << [ 'Cook dinner', false ]
person.tasks << [ 'Learn Angular', false ]
person.tasks << [ 'Walk the dog', true ]
person.tasks << [ 'Do homework', true ]
person.tasks << [ 'Learn Ruby', true ]

person.tasks.each do |task, completed|
	puts task if completed
end