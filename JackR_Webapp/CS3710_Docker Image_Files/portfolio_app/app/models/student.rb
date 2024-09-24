class Student < ApplicationRecord
    has_one_attached :profile_picture
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :school_email, presence: true, uniqueness: true
    validates :major, presence: true
    validates :expected_graduation_date, presence: true
    validate :school_email_must_end_with_student_email
    validate :correct_profile_picture_mime_type

    private

    def correct_profile_picture_mime_type
        if profile_picture.attached? && !profile_picture.content_type.in?(%('image/jpeg image/jpg image/png'))
            errors.add(:profile_picture, 'must be a JPEG or PNG image')
        end

        if profile_picture.attached? && profile_picture.byte_size > 1.megabyte
            errors.add(:profile_picture, 'must be less than 1MB')
        end
    end
  
    private
  
    def school_email_must_end_with_student_email
      if school_email.present? && !school_email.end_with?("@msudenver.edu")
        errors.add(:school_email, "must use an MSU Denver email.")
      end
    end
  end