# README


## API Contracts

#### Missions
##### Create (`POST /api/v1/missions`)

###### Request Structure
```
headers: 'CONTENT_TYPE' => 'application/json'
body: {"name"=>"Weekly chores", "due_date"=>"2001-02-03", "user_id"=>515}
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
##### Index (`GET /api/v1/missions`)
###### Successful Response
```
{ 'data' =>
  [{ 'id' => '320',
     'type' => 'mission',
     'attributes' => { 'name' => 'Weekly otter chores',
                       'due_date' => '2021-02-26', 
                       'user_id' => 513,
                       'created_at' => '2021-02-21T00:00:00.000Z',
                       'updated_at' => '2021-02-21T00:00:00.000Z' } },
   { 'id' => '321',
     'type' => 'mission',
     'attributes' => { 'name' => 'Weekly grasshopper chores',
                       'due_date' => '2021-02-26',
                       'user_id' => 514,
                       'created_at' => '2021-02-21T00:00:00.000Z',
                       'updated_at' => '2021-02-21T00:00:00.000Z' } }] }
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
