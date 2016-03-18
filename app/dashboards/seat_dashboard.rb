require "administrate/base_dashboard"

class SeatDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    area: Field::BelongsTo,
    price: Field::BelongsTo,
    orders: Field::HasMany,
    id: Field::Number,
    locate_x: Field::Number,
    locate_y: Field::Number,
    sold: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :area,
    :orders,
    :id,
    :sold,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :area,
    :orders,
    :locate_x,
    :locate_y,
    :sold,
  ]

  # Overwrite this method to customize how seats are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(seat)
  #   "Seat ##{seat.id}"
  # end
end
