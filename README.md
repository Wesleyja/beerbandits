# Beer Bandits
A Rails web app built to help users find the cheapest places to buy beer near them.

## Install

### Clone the repository

```shell
git clone git@github.com:Wesleyja/beerbandits.git
cd beerbandits
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.6.5`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.6.5
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle

bundle install
```

### Add secret keys

Using [Cloudinary](https://cloudinary.com/) and [Mapbox](https://account.mapbox.com/):

```shell
touch .env
echo '.env*' >> .gitignore

Add secret keys for both:
CLOUDINARY_URL=cloudinary://.....
MAPBOX_API_KEY=pk....
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Launch server

```shell
rails s
```
