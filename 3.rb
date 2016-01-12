require 'prime'

10000.downto(1).each do |i|
  if Prime.prime?(i) && i.to_s == i.to_s.reverse
  	puts i
  	break
  end
end