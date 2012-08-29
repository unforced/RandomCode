def testGrade(tests)
	puts "Please put 3 tests" if tests.length != 3
	tests.sort!
	grade = tests[0]*5.0 + tests[1]*8.0 + tests[2]*12.0
	puts "Test Grade: #{grade*4}, worth #{grade}"
	grade
end

def individualHomeworkGrade(hw)
	3.times {hw.shift}
	grade = 15.0*hw.inject(:+)/hw.length
	puts "Individual Homework Grade: #{grade*100.0/15.0}, worth #{grade}"
	grade
end

def groupHomeworkGrade(hw)
	3.times {hw.shift}
	grade = 10.0*hw.inject(:+)/hw.length
	puts "Group Homework Grade: #{grade*10}, worth #{grade}"
	grade
end

def labGrade(labGrade)
	grade = labGrade[0] * 25
	puts "Lab Grade: #{grade*4}, worth #{grade}"
	grade
end

def finalGrade(finalGrade)
	grade = finalGrade[0] * 25
	puts "Final Grade: #{grade*4}, worth #{grade}"
	grade
end

def totalGrade(tests, ihw, ghw, lab, final)
	puts testGrade(tests) + individualHomeworkGrade(ihw) + groupHomeworkGrade(ghw) + labGrade(lab) + finalGrade(final)
end

puts "Input all your grades in decimal form or fraction, with spaces separated(Good: 0.92 92.0/100, Bad: .92 92 92/100"
list = ["test", "individual homework", "group homework", "lab", "final"]
grades = []
list.each do |section|
	puts "Input your #{section} grades"
	grades << gets.split.collect{|i| eval(i)}
end

totalGrade(grades[0],grades[1],grades[2],grades[3],grades[4])
