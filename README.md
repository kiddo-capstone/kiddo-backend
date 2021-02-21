# README


## API Contracts

#### Missions
##### Create
###### Request
```
{"name"=>"Weekly chores", "due_date"=>"2001-02-03", "user_id"=>515}
```

###### Successful Response
```
{ 'data' => { 'id' => '304',
              'type' => 'mission',
              'attributes' => { 'name' => 'Weekly chores',
                                'due_date' => '2001-02-03',
                                'user_id' => 487,
                                'created_at' => '2021-02-21T04:05:24.749Z',
                                'updated_at' => '2021-02-21T04:05:24.749Z' } } }
```
###### Unsuccessful Response
```
{"data"=>{"errors"=>"Name can't be blank", "status"=>"bad_request"}}
```



Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
