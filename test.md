# Posts API
####GET /posts/
- return list of all public posts

<details>
  <summary>Example Response (Click to expand -- not work on FF version < 49)</summary>
  <p>
```json
{
	"query": "posts",
	# GET to http://service/posts
	# number of posts
	"count": 1023,
	# Page size
	"size": 50,
	# Do not return next if last page
	"next": "http://service/author/posts?page=5",
	# Do not return previous if page is 0.
	"previous": "http://service/author/posts?page=3",
	# should be sorted newest(first) to oldest(last) 
	"posts":[
		{
			# title of a post
			"title":"A post title about a post about web dev",
			# where did you get this post from?
			"source":"http://lastplaceigotthisfrom.com/post/yyyyy",
			# where is it actually from
			"origin":"http://whereitcamefrom.com/post/zzzzz",
			# a brief description of the post
			"description":"This post discusses stuff -- brief",
			# The content type of the post
			# assume either
			# text/x-markdown
			# text/plain
			# for HTML you will want to strip tags before displaying
			"contentType":"text/plain",
			"content":"Þā wæs on burgum Bēowulf Scyldinga, lēof lēod-cyning, longe þrāge folcum gefrǣge (fæder ellor hwearf, aldor of earde), oð þæt him eft onwōc hēah Healfdene; hēold þenden lifde, gamol and gūð-rēow, glæde Scyldingas. Þǣm fēower bearn forð-gerīmed in worold wōcun, weoroda rǣswan, Heorogār and Hrōðgār and Hālga til; hȳrde ic, þat Elan cwēn Ongenþēowes wæs Heaðoscilfinges heals-gebedde. Þā wæs Hrōðgāre here-spēd gyfen, wīges weorð-mynd, þæt him his wine-māgas georne hȳrdon, oð þæt sēo geogoð gewēox, mago-driht micel. Him on mōd bearn, þæt heal-reced hātan wolde, medo-ærn micel men gewyrcean, þone yldo bearn ǣfre gefrūnon, and þǣr on innan eall gedǣlan geongum and ealdum, swylc him god sealde, būton folc-scare and feorum gumena. Þā ic wīde gefrægn weorc gebannan manigre mǣgðe geond þisne middan-geard, folc-stede frætwan. Him on fyrste gelomp ǣdre mid yldum, þæt hit wearð eal gearo, heal-ærna mǣst; scōp him Heort naman, sē þe his wordes geweald wīde hæfde. Hē bēot ne ālēh, bēagas dǣlde, sinc æt symle. Sele hlīfade hēah and horn-gēap: heaðo-wylma bād, lāðan līges; ne wæs hit lenge þā gēn þæt se ecg-hete āðum-swerian 85 æfter wæl-nīðe wæcnan scolde. Þā se ellen-gǣst earfoðlīce þrāge geþolode, sē þe in þȳstrum bād, þæt hē dōgora gehwām drēam gehȳrde hlūdne in healle; þǣr wæs hearpan swēg, swutol sang scopes. Sægde sē þe cūðe frum-sceaft fīra feorran reccan",
			# the author has an ID where by authors can be disambiguated 
			"author":{
				# ID of the Author (UUID) http://en.wikipedia.org/wiki/Universally_unique_identifier
				"id":"de305d54-75b4-431b-adb2-eb6b9e546013",
				# the home host of the author
				"host":"http://127.0.0.1:5454/",
				# the display name of the author
				"displayName":"Lara Croft",
				# url to the authors information
				"url":"http://127.0.0.1:5454/author/9de17f29c12e8f97bcbbd34cc908f1baba40658e",
				# HATEOS url for Github API
				"github": "http://github.com/laracroft"
			},
			# categories this post fits into (a list of strings
			"categories":["web","tutorial"],
			# comments about the post
			# return a maximum number of comments
			# total number of comments for this post
			"count": 1023,
			# page size
			"size": 50,
			# the first page of comments
			"next": "http://service/posts/{post_id}/comments",
			# You should return ~ 5 comments per post.
			# should be sorted newest(first) to oldest(last) 
			"comments":[
				{
					"author":{
					    # ID of the Author (UUID)
						"id":"de305d54-75b4-431b-adb2-eb6b9e546013",
						"host":"http://127.0.0.1:5454/",
						"displayName":"Greg Johnson",
						# url to the authors information
						"url":"http://127.0.0.1:5454/author/9de17f29c12e8f97bcbbd34cc908f1baba40658e",
						# HATEOS url for Github API
						"github": "http://github.com/gjohnson"
					},
					"comment":"Sick Olde English",
					"contentType":"text/x-markdown",
					# ISO 8601 TIMESTAMP
					"published":"2015-03-09T13:07:04+00:00",
					# ID of the Comment (UUID)
					"id":"de305d54-75b4-431b-adb2-eb6b9e546013"
				}
			]
			# ISO 8601 TIMESTAMP
			"published":"2015-03-09T13:07:04+00:00",
			# ID of the Post (UUID)
			"id":"de305d54-75b4-431b-adb2-eb6b9e546013",
			# visibility ["PUBLIC","FOAF","FRIENDS","PRIVATE","SERVERONLY"]
			"visibility":"PUBLIC"
			# for visibility PUBLIC means it is open to the wild web
			# FOAF means it is only visible to Friends of A Friend
			# If any of my friends are your friends I can see the post
			# FRIENDS means if we're direct friends I can see the post
			# PRIVATE means only you can see the post
			# SERVERONLY means only those on your server (your home server) can see the post                                              
		}
	]
}
```
  </p>
</details>

----

####GET /posts/\<postID\>
- return single post

<details>
  <summary>Example Response (Click to expand -- not work on FF version < 49)</summary>
  <p>
```json
{
    "posts": {
        "id": "4f9bb155-74ed-416d-8098-83d126cd8fdb",
        "title": "123213",
        "source": "http://localhost:8000/",
        "origin": "http://localhost:8000/posts/4f9bb155-74ed-416d-8098-83d126cd8fdb",
        "description": "123213",
        "content": "123213",
        "category": "123213",
        "author": {
            "id": "7ac13bbe-80c4-4956-b1ab-fdc2f715cf82",
            "displayName": "1",
            "first_name": "Alice",
            "last_name": "WU",
            "email": "alice@Gmail.com",
            "bio": "whxaxes",
            "host": "http://localhost:8000/",
            "github_username": "ulicenix"
        },
        "visibility": "PUBLIC",
        "publish_time": "2016-11-04T06:21:24.386838Z",
        "content_type": "text/markdown",
        "comments": []
    }
}
```
  </p>
</details>


----

####GET /posts/\<postID\>/comments?page=4&size=40
- return comments of specific post (**sorry, but comments are not supported by v1**)
- supports paging and size
- **Basic Auth** is required 

<details>
  <summary>Example Request</summary>
  <p>
```html
GET /posts/?page=1&size=3 HTTP/1.1

Authorization: Basic MTp0ZXN0MTIz
```
  </p>
 </details>

<details>
  <summary>Example Response</summary>
  <p>
```json
{
    "count": 18,
    "posts": [
        {
            "id": "f460d8c3-146b-4345-a445-feed98b0ac82",
            "title": "213123123 -- updated again",
            "source": "http://localhost:8000/",
            "origin": "http://localhost:8000/posts/f460d8c3-146b-4345-a445-feed98b0ac82",
            "description": "1",
            "content": "12312321",
            "category": "1",
            "author": {
                "id": "7ac13bbe-80c4-4956-b1ab-fdc2f715cf82",
                "displayName": "1",
                "first_name": "Alice",
                "last_name": "WU",
                "email": "alice@Gmail.com",
                "bio": "whxaxes",
                "host": "http://localhost:8000/",
                "github_username": "ulicenix"
            },
            "visibility": "PUBLIC",
            "publish_time": "2016-11-05T00:46:26.789607Z",
            "content_type": "text/plain",
            "comments": []
        },
        {
            "id": "4f9bb155-74ed-416d-8098-83d126cd8fdb",
            "title": "123213",
            "source": "http://localhost:8000/",
            "origin": "http://localhost:8000/posts/4f9bb155-74ed-416d-8098-83d126cd8fdb",
            "description": "123213",
            "content": "123213",
            "category": "123213",
            "author": {
                "id": "7ac13bbe-80c4-4956-b1ab-fdc2f715cf82",
                "displayName": "1",
                "first_name": "Alice",
                "last_name": "WU",
                "email": "alice@Gmail.com",
                "bio": "whxaxes",
                "host": "http://localhost:8000/",
                "github_username": "ulicenix"
            },
            "visibility": "PUBLIC",
            "publish_time": "2016-11-04T06:21:24.386838Z",
            "content_type": "text/markdown",
            "comments": []
        },
        {
            "id": "62f71360-9888-4dfa-851d-bb6386cdcaf5",
            "title": "12323123213",
            "source": "http://localhost:8000/",
            "origin": "http://localhost:8000/posts/62f71360-9888-4dfa-851d-bb6386cdcaf5",
            "description": "123213",
            "content": "123213213",
            "category": "123213",
            "author": {
                "id": "7ac13bbe-80c4-4956-b1ab-fdc2f715cf82",
                "displayName": "1",
                "first_name": "Alice",
                "last_name": "WU",
                "email": "alice@Gmail.com",
                "bio": "whxaxes",
                "host": "http://localhost:8000/",
                "github_username": "ulicenix"
            },
            "visibility": "PUBLIC",
            "publish_time": "2016-11-04T06:22:44.067883Z",
            "content_type": "text/markdown",
            "comments": []
        }
    ],
    "next": "http://localhost:8000/posts/?page=2&size=3",
    "query": "posts",
    "size": 10,
    "previous": null
}
```
  </p>
</details>

----

####DELETE /posts/<postID>
- delete specific post
- **Basic Auth** is required

<details>
  <summary>Example Request for DELELTE /posts/<\postID\></summary>
  <p>
```html
DELETE /posts/f460d8c3-146b-4345-a445-feed98b0ac82/ HTTP/1.1
Authorization: Basic MTp0ZXN0MTIz
```
  </p>
</details>
----

####POST /posts/
- send post data
- **Basic Auth** is required in the header (￣(エ)￣)ゞ

<details>
  <summary>Example Request for POST /posts/</summary>
  <p>
```json
// HEADERS: 

POST /posts/ HTTP/1.1

Authorization: Basic MTp0ZXN0MTIz 

{
    "title": "Title",  // maxLength === 50
    "source": "http://localhost:5000", // where your server is
    "description": "brief description of post content", // maxLength === 50
    "content": "content", // Required
    "category": "BS"  // maxLength === 50, string, not a list
    "visibility": "PUBLIC" // ["PUBLIC", "PRIVATE", "SERVERONLY", "FRIENDS", "FOAF"]
    "content_type": "text/plain" // or "text/markdown"
}
```
  </p>
</details>

----

####PUT /posts/\<postID\>
- updating a specific post
- **Basic Auth** is required

<details>
  <summary>Example Request for POST /posts/\<postID\></summary>
  <p>
```json
// HEADERS: 

PUT /posts/6f6959ab-96dc-4c7d-8169-3ae6cc090513 HTTP/1.1

Authorization: Basic MTp0ZXN0MTIz // 

{
    "title": "Title -- update",  // maxLength === 50
    "source": "http://localhost:5000", // where your server is
    "description": "brief description of post content", // maxLength === 50
    "content": "content", // Required
    "category": "BS"  // maxLength === 50, string, not a list
    "visibility": "PUBLIC" // ["PUBLIC", "PRIVATE", "SERVERONLY", "FRIENDS", "FOAF"]
    "content_type": "text/markdown" // or "text/plain"
}
```
  </p>
</details>


----
# Author API

####POST /author/
- create user

<details>
  <summary>Example Request</summary>
  <p>
```json
POST /author/ HTTP/1.1

{
  displayName: "Alice", //**required**
  password: "test123" //**required**
  first_name: "",
  last_name: "",
  email: "",
  bio: "",
  host: "http://localhost:8080" //**required**
  github_username: "ulicenix"
}
```
  </p>
</details>

----

####PUT /author/\<authorID\>
- edit author profile

<details>
  <summary>Example Request</summary>
  <p>
```json
PUT /author/7ac13bbe-80c4-4956-b1ab-fdc2f715cf82/ HTTP/1.1

{
  displayName: "Alice", //**required**
  password: "test123" //**required**
  first_name: "",
  last_name: "",
  email: "",
  bio: "Updated bio -- haha",
  host: "http://localhost:8080" //**required**
  github_username: "ulicenix"
}
```
  </p>
</details>
----

####GET /author/posts?page=1&size=2
- return posts that are visible to the currently authenticated author on page 1 given size 2
- **Basic Auth** is required

<details>
  <summary>Example Request Header</summary>
  <p>
```json
GET /author/posts/?page=1&size=2 HTTP/1.1
Authorization: Basic MTp0ZXN0MTIz

```
  </p>
</details>

<details>
  <summary>Example Response</summary>
  <p>
```json
{
    "count": 37,
    "posts": [
        {
            "id": "a4d287fd-568f-40a1-97b3-abf243bee044",
            "title": "Edited by me and private t ome (markdown)",
            "source": "http://localhost:8000/",
            "origin": "http://localhost:8000/posts/a4d287fd-568f-40a1-97b3-abf243bee044",
            "description": "new",
            "content": "nothing new to me, is markdown now",
            "category": "nothing",
            "author": {
                "id": "7ac13bbe-80c4-4956-b1ab-fdc2f715cf82",
                "displayName": "1",
                "first_name": "Alice",
                "last_name": "WU",
                "email": "alice@Gmail.com",
                "bio": "whxaxes",
                "host": "http://localhost:8000/",
                "github_username": "heykevin"
            },
            "visibility": "PRIVATE",
            "publish_time": "2016-11-04T15:41:16.971392Z",
            "content_type": "text/plain",
            "comments": []
        },
        {
            "id": "13ee5777-87a0-484b-8d7c-6dbaf9f9f027",
            "title": "Markdown Again",
            "source": "http://localhost:8000/",
            "origin": "http://localhost:8000/posts/13ee5777-87a0-484b-8d7c-6dbaf9f9f027",
            "description": "Nothing",
            "content": "Welcome to the cmput404-project wiki!\r\n\r\n//TODO: Table of content\r\n\r\n## Database Design\r\n\r\n## Storyboard\r\n\r\n###Homepage - sign in/up\r\n![Homepage - sign in/up](https://s18.postimg.org/w97zoyytl/IMG_9375.jpg)\r\n\r\n###Profile - edit profile\r\n![](https://s18.postimg.org/gnvq24t6x/IMG_9390.jpg)\r\n\r\n###Post - make/edit a post\r\n![](https://s18.postimg.org/4aivv83ih/IMG_9391.jpg)\r\n\r\n###Post - delete a post\r\n![](https://s18.postimg.org/aphwrwa89/IMG_9395.jpg)\r\n\r\n###Post - add an image to a post\r\n![](https://s18.postimg.org/ni60rtlu1/IMG_9400.jpg)\r\n## API Documentation",
            "category": "Test",
            "author": {
                "id": "7ac13bbe-80c4-4956-b1ab-fdc2f715cf82",
                "displayName": "1",
                "first_name": "Alice",
                "last_name": "WU",
                "email": "alice@Gmail.com",
                "bio": "whxaxes",
                "host": "http://localhost:8000/",
                "github_username": "heykevin"
            },
            "visibility": "FRIENDS",
            "publish_time": "2016-11-04T07:32:01.882090Z",
            "content_type": "text/plain",
            "comments": []
        }
    ],
    "next": "http://localhost:8000/author/posts/?page=2&size=2",
    "query": "posts",
    "size": 10,
    "previous": null
}
```
  </p>
</details>
----

####GET /author/<authorID>
- returns a specific author's profile

<details>
  <summary>Example response</summary>
  <p>
```html
GET /author/7ac13bbe-80c4-4956-b1ab-fdc2f715cf82/ HTTP/1.1
```
  </p>
</details>

<details>
  <summary> Example response </summary>
  <p>
```json
{
    "id": "7ac13bbe-80c4-4956-b1ab-fdc2f715cf82",
    "displayName": "1",
    "first_name": "Alice",
    "last_name": "WU",
    "email": "alice@Gmail.com",
    "bio": "whxaxes",
    "host": "http://localhost:8000/",
    "github_username": "heykevin",
    "friends": [
        {
            "id": "300a0429-eaf3-42eb-b209-670dd55bf4e7",
            "displayName": "4",
            "first_name": "",
            "last_name": "",
            "email": "",
            "bio": "null",
            "host": "http://localhost:8000/",
            "github_username": "ulicenix"
        },
        {
            "id": "5793fa50-c09f-460a-957b-745831c5560f",
            "displayName": "2",
            "first_name": "2",
            "last_name": "",
            "email": "",
            "bio": "heykevin bio.",
            "host": "http://127.0.0.1:8000/",
            "github_username": "heykevin"
        },
        {
            "id": "c7f98bb7-bd11-4859-863b-e86c7490bd13",
            "displayName": "alicewu",
            "first_name": "",
            "last_name": "",
            "email": "",
            "bio": "life is strange",
            "host": "http://127.0.0.1:8000/",
            "github_username": "ulicenix"
        }
    ],
    "request_sent": [],
    "request_received": []
}
```
  </p>
</details>

----

# Friends API
####GET /friends/\<AuthorID\>
- return friends for specific author

<details>
  <summary>Example Request</summary>
  <p>
```html
GET /friends/7ac13bbe-80c4-4956-b1ab-fdc2f715cf82/ HTTP/1.1
```
  </p>
</details>

<details>
  <summary>Example Response</summary>
  <p>
```json
{
    "authors": [
        "300a0429-eaf3-42eb-b209-670dd55bf4e7",
        "5793fa50-c09f-460a-957b-745831c5560f",
        "c7f98bb7-bd11-4859-863b-e86c7490bd13"
    ],
    "query": "friends"
}
```
  </p>
</details>

----

####GET /friends/\<authorid1\>/\<authorid2\>
- return true if both authors are friends

<details>
  <summary>Example Request and Response</summary>
  <p>
```html
GET http://service/friends/<authorid1>/<authorid2>
 where authorid1 = de305d54-75b4-431b-adb2-eb6b9e546013
 where authorid2 = ae345d54-75b4-431b-adb2-fb6b9e547891
```
```json
# Ask if 2 authors are friends
# responds with:
{
    "query": "friends",
    "authors": [
        "80104571-72b5-49d2-a6c1-fa02e28e91cf",
        "725abd17-150c-4496-8d64-98b6c5ebb9f8"
    ],
    "friends": false
}
```
  </p>
</details>
----

####POST /friends/\<AuthorID\>
- send list of people who you think are friends
- return a list of people who are actually friends

<details>
  <summary>Example Request Body and Response</summary>
  <h5>Request</h5>
  <p>
```json
{
    "authors": [
        "92bf6602-aa10-4707-91fd-d181c3c4dad5"
    ],
    "query": "friends"
}
```
  </p>
  <h5>Response</h5>
  <p>
```json
{
	"query":"friends",
 	"author":"9de17f29c12e8f97bcbbd34cc908f1baba40658e",
 	# Array of Author UUIDs who are friends
	"authors": [
	    "de305d54-75b4-431b-adb2-eb6b9e546013",
		"ae345d54-75b4-431b-adb2-fb6b9e547891",
		"..."
  	]
}
```
  </p>
</details>
----

####POST /friendrequest
- Send out a friend request to another author
- Reply to a friend request send from an author
- Delete a friend

<details>
  <summary>Example Request</summary>
  <p>
```json
- send a friend request
{  
   "query":"friendrequest",
   "author":{  
      "id":"80104571-72b5-49d2-a6c1-fa02e28e91cf", #the friend request sender
      "displayName":"kt",
      "host":"http://127.0.0.1:8000/"
   },
   "friend":{  
      "id":"725abd17-150c-4496-8d64-98b6c5ebb9f8", #the friend request receiver
      "displayName":"test",
      "host":"https://api-bloggyblog404.herokuapp.com/admin/web_api/author/add/"
   }
}

- declinet/accept a friend request
{  
   "query":"friendresponse",
   "author":{  
      "id":"92bf6602-aa10-4707-91fd-d181c3c4dad5", #the friend request sender
      "displayName":"aliceonheroku",
      "host":"https://api-bloggyblog404.herokuapp.com/"
   },
   "friend":{  
      "id":"80104571-72b5-49d2-a6c1-fa02e28e91cf", #the friend request receiver
      "displayName":"kt",
      "host":"http://127.0.0.1:8000/"
   },
   "accepted":"true" // false -- decline
}

- unfriend
{  
   "query":"unfriend",
   "author":{  
      "id":"80104571-72b5-49d2-a6c1-fa02e28e91cf", #the friend request sender
      "displayName":"kt",
      "host":"http://127.0.0.1:8000/"
   },
   "friend":{  
      "id":"92bf6602-aa10-4707-91fd-d181c3c4dad5",
      "displayName":"aliceonheroku",
      "host":"https://api-bloggyblog404.herokuapp.com/" #the friend request receiver
   }
}     
```
  </p>
</details>

----

# Authorization API
####POST /login
- Send authentication credentials and receive author

<details>
  <summary>Example Request</summary>
  <p>
```html
POST /login
Authorization: Basic a3Q6a3Q=

```
  </p>
</details>
----

<details>
  <summary>Example Response</summary>
  <p>
```json
{  
   "author":{  
      "id":"80104571-72b5-49d2-a6c1-fa02e28e91cf",
      "displayName":"kt",
      "first_name":"",
      "last_name":"",
      "email":"",
      "bio":null,
      "host":"http://127.0.0.1:8000/",
      "github_username":null,
      "friends":[  
      ],
      "request_sent":[ 
      ],
      "request_received":[  
      ]
   }
}

```
  </p>
</details>
----
