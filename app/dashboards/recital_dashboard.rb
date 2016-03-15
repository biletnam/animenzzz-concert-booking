require "administrate/base_dashboard"

class RecitalDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    areas: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    city: Field::String,
    musician: Field::String,
    capacity: Field::Number,
    music_hall: Field::String,
    address: Field::String,
    lat: Field::String,
    lng: Field::String,
    start_time: Field::DateTime,
    end_time: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :areas,
    :id,
    :name,
    :city,
    :music_hall,
    :address,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :areas,
    :name,
    :city,
    :musician,
    :capacity,
    :music_hall,
    :address,
    :lat,
    :lng,
    :start_time,
    :end_time,
  ]

  # Overwrite this method to customize how recitals are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(recital)
  #   "Recital ##{recital.id}"
  # end
end
