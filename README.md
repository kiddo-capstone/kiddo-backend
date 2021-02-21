# README
# kiddo-backend

## Table of Contents:

- [Overview](#overview)
- [Techstack](#techstack)
- [API Contracts](#api-contracts)
- [Schema](#schema)
- [Contributors](#contributors)

## Overview


## Techstack

- Ruby on Rails
- Simplecov
- RSpec
- PostgresQL


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
#### Tasks
##### Create (`POST /api/v1/tasks`)

###### Request Structure
```
headers: 'CONTENT_TYPE' => 'application/json'
body: {"name"=>"EQ Level up", "description"=>"Say something kind", "category"=>"EQ", "points"=>100}
```

###### Successful Response
```
{ 'data' => { 'id' => '13',
              'type' => 'task',
              'attributes' => { 'name' => 'EQ Level up',
                                'description' => 'Say something kind',
                                'category' => 'EQ',
                                'points' => '100' } } }
```
###### Unsuccessful Response
```
{"data"=>{"errors"=>"Name can't be blank", "status"=>"bad_request"}}
```
##### Index (`GET /api/v1/tasks`)

###### Successful Response
```
{ 'data' =>
  [{ 'id' => '13',
     'type' => 'task',
     'attributes' => { 'name' => 'EQ Level up',
                       'description' => 'Say something kind',
                       'category' => 'EQ',
                       'points' => '100' } } },
   { 'id' => '27',
     'type' => 'task',
     'attributes' => { 'name' => 'IQ Level up',
                       'description' => 'Conquer homework',
                       'category' => 'IQ',
                       'points' => '75'} } }] }
```

## Schema


## Contributors

- Lola Dolinsky - [![LinkedIn][linkedin-shield]]() - [![GitHub][github-shield]](https://github.com/lo-la-do-li)

- Bailey Dunning - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/baileydunning/) - [![GitHub][github-shield]](https://github.com/baileydunning)

- Scott Brabson - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/scott-brabson/) - [![GitHub][github-shield]](https://github.com/brabbuss)

- Will Dunlap - [![LinkedIn][linkedin-shield]]() - [![GitHub][github-shield]](https://github.com/dunlapww)

- Brett Sherman - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/brettshermanll/) - [![GitHub][github-shield]](https://github.com/BJSherman80)

- Shaun James - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/shaun-james-2707a61bb/) - [![GitHub][github-shield]](https://github.com/ShaunDaneJames)

- Connor Ferguson - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/connor-p-ferguson/) - [![GitHub][github-shield]](https://github.com/cpfergus1)


<!-- MARKDOWN LINKS & IMAGES -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[github-shield]: https://img.shields.io/badge/-GitHub-black.svg?style=flat-square&logo=github&colorB=555
