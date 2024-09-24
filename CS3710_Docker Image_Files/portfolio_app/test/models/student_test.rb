require "test_helper"

class StudentTest < ActiveSupport::TestCase
    test "Should rise error when the email is not unique." do
      assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "TEST", last_name: "TEST", school_email: "jsmith33@msudenver.edu", major: "TEST", expected_graduation_date: "2024-09-17")
      end
    end
    test "Should rise error when the email is not ending in @msudenver.edu" do
      assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "TEST", last_name: "TEST", school_email: "jsmith@gmail.edu", major: "TEST", expected_graduation_date: "2024-09-17")
      end
    end
    test "Should rise error when any field is empty." do
      assert_raises ActiveRecord::RecordInvalid do
        Student.create!(first_name: "TEST", last_name: "TEST", school_email: "jsmith222@gmail.edu", major: "TEST", expected_graduation_date: "2024-09-17")
      end
    end
    
    
end
