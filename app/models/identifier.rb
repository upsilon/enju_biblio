class Identifier < ActiveRecord::Base
  #attr_accessible :body, :identifier_type_id, :manifestation_id, :primary, :position
  belongs_to :identifier_type
  belongs_to :manifestation, touch: true

  validates_presence_of :body
  validates_uniqueness_of :body, scope: [:identifier_type_id, :manifestation_id]
  validate :check_identifier
  before_validation :normalize
  before_save :convert_isbn
  scope :identifier_type_scope, -> type {
    where(identifier_type: IdentifierType.where(name: type).first)
  }

  acts_as_list scope: :manifestation_id
  strip_attributes only: :body

  def check_identifier
    case identifier_type.try(:name)
    when 'isbn'
      unless StdNum::ISBN.valid?(body)
        errors.add(:body)
      end

    when 'issn'
      unless StdNum::ISSN.valid?(body)
        errors.add(:body)
      end

    when 'lccn'
      unless StdNum::LCCN.valid?(body)
        errors.add(:body)
      end

    when 'doi'
      begin
        if URI.parse(body).scheme
          errors.add(:body)
        end
      rescue URI::InvalidURIError
        nil
      end
    end
  end

  def convert_isbn
    if identifier_type.name == 'isbn'
      lisbn = Lisbn.new(body)
      if lisbn.isbn
        if lisbn.isbn.length == 10
          self.body = lisbn.isbn13
        end
      end
    end
  end

  def hyphenated_isbn
    if identifier_type.name == 'isbn'
      lisbn = Lisbn.new(body)
      lisbn.parts.join('-')
    end
  end

  def normalize
    case identifier_type.try(:name)
    when 'isbn'
      self.body = StdNum::ISBN.normalize(body)
    when 'issn'
      self.body = StdNum::ISSN.normalize(body)
    when 'lccn'
      self.body = StdNum::LCCN.normalize(body)
    when 'doi'
      normalize_doi
    end
  end

  def normalize_doi
    if body =~ /^http:\/\/dx\.doi\.org\//
      self.body = body.gsub(/^http:\/\/dx\.doi\.org\//, '')
    end
  end
end

# == Schema Information
#
# Table name: identifiers
#
#  id                 :integer          not null, primary key
#  body               :string           not null
#  identifier_type_id :integer          not null
#  manifestation_id   :integer
#  primary            :boolean
#  position           :integer
#  created_at         :datetime
#  updated_at         :datetime
#
