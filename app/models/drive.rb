class Drive < ActiveRecord::Base
  has_many :days, dependent: :destroy
  has_many :appointments, dependent: :destroy
  accepts_nested_attributes_for :days, allow_destroy: true, reject_if: proc {|attrs| attrs['start_time'].blank? && attrs['stop_time'].blank?}

  validates :name, :contact_email, presence: true

  scope :opened, -> {where('open_at IS NOT NULL AND open_at < ?', Time.now)}
  scope :closed, -> {where('close_at IS NOT NULL AND close_at < ?', Time.now)}
  scope :not_closed, -> {where('close_at IS NULL OR close_at > ?', Time.now)}
  scope :active, -> {opened.not_closed}

  rails_admin do
    edit do
      field :name
      field :location
      field :contact_email
      field :max_per_slot
      field :time_per_slot
      field :open_at
      field :close_at
    end
  end

  def opened?
    open_at && open_at < Time.now
  end

  def not_closed?
    close_at.nil? || close_at > Time.now
  end

  def active?
    opened? && not_closed?
  end
end
