# ezpoisk.com.

__Ezpoisk__ (**ez** - *easy*, **poisk** - *search* (from Russian "поиск")) is an
online platform for Russian-speaking people in the US.
Here they can find help within Russian community, look for related information,
submit public listings, look for the representatives of various services who
is available in their native language.
They can share news and provide useful information to other members of community.

One of the reasons I wanted to build this application is a chance to work with
various parts of the stack. Here's a short summary:

1. User authentication is done with [**Devise**](https://github.com/plataformatec/devise)
2. [**Paperclip**](https://github.com/thoughtbot/paperclip)
  is used for image uploading.
  [**Paperclip-optimizer**](https://github.com/janfoeh/paperclip-optimizer)
  and [**Image_optim**](https://github.com/toy/image_optim)
  are used to optimize images, [**S3**](https://github.com/marcel/aws-s3) for storage.

3. [**Pgwslider**](http://pgwjs.com/pgwslider/) and
  [**TouchTouch**](http://tutorialzine.com/2012/04/mobile-touch-gallery/)
  were used to display images nicely on desktop, as well as mobile devices.

4. Question searching is implemented using **AJAX**. I’ve also provided
  **custom middleware** to improve response time.
  User can also save or hide listings, this is also done via **AJAX** for better **UX**.

5. [**Sidekiq**](https://github.com/mperham/sidekiq) is used for background jobs.
  * Mailing users
  * Importing news
  * Geolocation
  * Data aggregation
  * Sitemap generation and uploading
  * And a few more

  are all done in background.

6. OmniAuth was added for better UX
    * [**omniauth-facebook**](https://github.com/mkdynamic/omniauth-facebook)
    * [**omniauth-google-oauth2**](https://github.com/zquestz/omniauth-google-oauth2)
    * [**omniauth-vkontakte**](https://github.com/mamantoha/omniauth-vkontakte)

7. News posts are created by parsing 3rd party’s RSS feed, using
   [**Nokogiri**](https://github.com/sparklemotion/nokogiri)

8. Users can post banner ads. Payments are accepted via
   [**Stripe**](https://stripe.com/). I used
   [**stripe-rails**](https://github.com/thefrontside/stripe-rails)

9. [**Rails Admin**](https://github.com/sferik/rails_admin) was used to
   provide administration panel.

10. Geolocation is done with [**Geokit**](https://github.com/geokit/geokit-rails).
    User can search for listings by state and city or by distance from
    specific place. GMap is used to show location on map.

11. [**Bootstrap (sass)**](https://github.com/anjlab/bootstrap-rails)
    to create responsive layouts.

12. ~~Web hooks are used to notify team via slack of important activity on site.~~
    [**slack-notifier**](https://github.com/stevenosloan/slack-notifier)

13. Analytics is done with Google developer tools.
    We used **Analytics and Console** to improve **SEO**.

14. Various gems were used to improve code quality and security.
    [**Gemfile**](https://github.com/AndreiMotinga/ezpoisk/blob/refactor/Gemfile#L87-L102)

15. Application runs on **Heroku** using **Puma** web-server,
    with Amazon CloudFront CDN for assets.

16. Application is heavily tested using [**Rspec**](https://github.com/rspec/rspec-rails)

### Model order
- module includes
- module settings
- belongs_to
- has_many
- validations
- callbacks
- scope
- instance methods


### To run app locally

```
git clone https://github.com/AndreiMotinga/ezpoisk.git
cd ezpoisk
bundle install
```

create `config/application.yml` and provide your keys,
otherwise various parts of app will fail

```
AWS_ACCESS_KEY_ID:
AWS_SECRET_ACCESS_KEY:
S3_BUCKET_NAME:
FACEBOOK_APP_ID:
FACEBOOK_APP_SECRET:
VK_APP_ID:
VK_SECRET_KEY:
GOOGLE_CLIENT_ID:
GOOGLE_SECRET_KEY:
GOOGLE_MAPS_API_KEY:
SLACK_URL: ""
STRIPE_PUBLISHABLE_KEY:
STRIPE_SECRET_KEY:
```
```
spring rake db:create
spring rake db:schema:load
spring rake db:seed_states_and_cities
```
