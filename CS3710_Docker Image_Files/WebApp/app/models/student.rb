class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one_attached :profile_picture, dependent: :purge_later
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :school_email, presence: true, uniqueness: true
    validates :major, presence: true
    validates :graduation_date, presence: true
    validate :school_email_must_end_with_student_email
    validate :acceptable_image


    private

    def acceptable_image
        return unless profile_picture.attached?
 
        unless profile_picture.blob.byte_size <= 1.megabyte
            errors.add(:profile_picture, "is too big")
        end
 
        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(profile_picture.content_type)
            errors.add(:profile_picture, "must be a JPEG or PNG")
        end
 
    end
 
  
    private
  
    def school_email_must_end_with_student_email
      if school_email.present? && !school_email.end_with?("@msudenver.edu")
        errors.add(:school_email, "must use an MSU Denver email.")
      end
    end
    
    VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS",
       "Computer Science BS", "Cybersecurity Major", "Data Science and Machine Learning Major"]

    validates :major, inclusion: { in: VALID_MAJORS, message: "%{value} is not a valid major" }

end
