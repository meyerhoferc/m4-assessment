# URLockBox

## About

The [URLockbox](https://warm-plains-20041.herokuapp.com/) is a place where users can manage links they want to save. Links have a title and url and can be marked as read or unread. URLockBox also has a companion app [Hotreads](https://desolate-crag-20501.herokuapp.com/) that keeps track of the most popular urls across all users. If one of your links is on the top 10 list, `so hot right now` will appear next to your link. If you link is currently the most popular, `top link` will appear next to your link.

#### Setup

1. Clone this repo.
2. `bundle install`
2. `rake db:create db:migrate`
3. To run locally: `rails s` and navigate to `127.0.0.1:3000`


#### Running the Tests

You will need to download version 46 of Firefox [here](https://www.softexia.com/windows/web-browsers/firefox-46). If you do have it, make sure it is on version 46. Selenium does not work with all versions of Firefox, so make sure that you are using Firefox 46 or else it will potentially cause you problems.

If you already have Firefox and it's on a version more recent than 46, the easiest way to downgrade is to uninstall Firefox then install version 46.

`rspec`
