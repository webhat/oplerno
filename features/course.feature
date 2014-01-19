Feature: Course
  Create a course

  Scenario: Simple Course
    * I have a Course
    * I entered my name: 'Course Test'
    * I entered my price: '1000'
    * I press save
    * It succeeds

  Scenario: Course without a Name
    * I have a Course
    * I don't enter a name
    * I press save
    * I get an error
