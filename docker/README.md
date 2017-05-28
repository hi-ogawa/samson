```
$ ./docker.sh up -d
$ ./docker.sh exec ruby bash
$$ bundle install
$$ cp config/database.mysql.yml.example config/database.yml
$$ bin/rake db:create db:schema:load
$$ bin/rails s -b 0.0.0.0 -p 3000
```
