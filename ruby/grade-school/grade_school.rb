require 'set'

module BookKeeping
  VERSION = 3
end

class SchoolGrade
  def initialize(grade_number:)
    @grade_number = grade_number
    @students = SortedSet.new
  end

  def enroll_student(student_name)
    students.add(student_name)
  end

  def roster
    students.to_a
  end

  def grade
    grade_number
  end

  def to_h
    { grade: grade, students: roster }
  end

  private

  attr_reader :grade_number, :students
end

class School
  def initialize
    @school_grades = Hash.new { |h, key| h[key] = SchoolGrade.new(grade_number: key) }
  end

  def students(grade)
    school_grades[grade].roster
  end

  def add(student, grade)
    school_grades[grade].enroll_student(student)
  end

  def students_by_grade
    school_grades.sort.map { |_, school_grade| school_grade.to_h }
  end

  private

  attr_reader :school_grades
end
