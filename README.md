[![Build Status](https://secure.travis-ci.org/cutalion/SetupMeetup.png)](http://travis-ci.org/cutalion/SetupMeetup)
[![Dependency Status](https://gemnasium.com/cutalion/SetupMeetup.png)](https://gemnasium.com/cutalion/SetupMeetup)

# SetupMeetup TODO/Thoughts/Planning

Everyone is welcome to append to this file.

## Use cases


### Sign up/in/out
* Guest can sign up with Google, Vkontakte, Github, Twitter, Facebook
* Registered user can sign in
* Signed in user can sign out


### Groups
* Signed in user can create a user group
* Signed in User can join user group
* Group user can leave his group
* Group owner cannot leave his group
* Group owner can delete user group


### Events
* Group user can create events
* Event owner can delete event


## Notifications
* Event participants and event possible participats receive the following notifications:
   * a week before the event
   * and a 1 day before the event
   * notification about changed date or time or place
   * notifications about deleted event
* All group users receive email notifications and invitation to the event, when new event is created


## Base entities

* User: name, email
* UserGroup: name, owner(User), users, events
* Event: name, date, time, place, owner(User), user_group, participants, possible_participants


## Nice to have

* Discussions through email like in Google Groups
* Syntax highlight
* Videos/images in posts
