# MakersBnB

This weeks challenge is to create a clone of Air BnB. It should allow logged in users to list their space(s), describing their spaces as available and the dates they are available to book.

```
As an unregistered user,
So I can rent out a property,
I would like to sign up.
```
```
As a registered user,
So I can rent out a property,
I would like to sign in.
```
```
As a registered user,
So other people can't rent out a property as me,
I would like to sign out.
```
```
As a signed-up user,
So I can rent out a property,
I would like to list a space.
```
```
As a property tycoon,
So I can rent out multiple properties,
I would like to list multiple spaces.
```

# MakersBnB specification

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

### Headline specifications

- ~~Any signed-up user can list a new space.~~
- ~~Users can list multiple spaces.~~
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

### Nice-to-haves

- Users should receive an email whenever one of the following happens:
 - They sign up
 - They create a space
 - They update a space
 - A user requests to book their space
 - They confirm a request
 - They request to book a space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- Users should receive a text message to a provided number whenever one of the following happens:
 - A user requests to book their space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- Basic payment implementation though Stripe.

### Mockups

Mockups for MakersBnB are available [here](https://github.com/makersacademy/course/blob/master/makersbnb/makers_bnb_images/MakersBnB_mockups.pdf).


![Tracking pixel](https://githubanalytics.herokuapp.com/course/makersbnb/specification_and_mockups.md)
