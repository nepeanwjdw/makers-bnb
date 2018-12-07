require 'database_helpers'
require 'Booking'

describe Booking do
  describe 'booking' do
    it 'request can be raised' do
      test_user = create_test_user
      name = 'Makers BNB'
      description = 'Lovely space to stay'
      price = 99
      user_id = test_user['user_id']
      image = 'duck.jpg'

      space = Space.create(
        name: name,
        description: description,
        price: price,
        user_id: user_id,
        image: 'duck.jpg'
      )

      booking_start_date = "2018-12-12"
      booking_end_date = "2018-12-13"

      booking = Booking.create_booking_request(booker_user_id: user_id, space_id: space.space_id, booking_start_date: booking_start_date, booking_end_date: booking_end_date)

      expect(booking).to be_a Booking
      expect(booking.booker_user_id).to eq user_id
      expect(booking.space_id.to_i).to eq space.space_id
      expect(booking.booking_start_date).to eq booking_start_date
      expect(booking.booking_end_date).to eq booking_end_date
      expect(booking.booking_confirmed).to eq "f"
    end

    it 'if end date is not specified then it should use the start date' do
      test_user = create_test_user
      name = 'Makers BNB'
      description = 'Lovely space to stay'
      price = 99
      user_id = test_user['user_id']
      image = 'duck.jpg'

      space = Space.create(
        name: name,
        description: description,
        price: price,
        user_id: user_id,
        image: image
      )

      booking_start_date = "2018-12-12"

      booking = Booking.create_booking_request(booker_user_id: user_id, space_id: space.space_id, booking_start_date: booking_start_date)

      expect(booking.booking_start_date).to eq booking_start_date
      expect(booking.booking_end_date).to eq booking_start_date
    end

  end
end
