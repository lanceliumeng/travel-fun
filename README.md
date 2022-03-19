# T2A2 - Marketplace Project :kiss:
## Travel Fun Web Application :oncoming_bus:
![app gif pic](docs/travel-fun.gif)

## Identification of the problem you are trying to solve by building this particular marketplace app. :question:
- I worked as a manager in a travel company three years ago. I found that its business model is more like B2B for traditional travel companies. Most clients rely on a higher-level travel agency's introduction for my previous company. In this case, traditional travel companies cannot bring cheaper travel products to travellers because all travel products need to add commission fees by travel agencies. 

- The another point is that the order management is a little chaotic for my previous company. Sometimes, the operator needs to manually record their order in different excel sheets for various purposes. My last boss also worries about this situation. We have tried to find some programmers for designing an application or website for our company to solve this problem. But due to the high price, this problem has been put on hold again and again until I leave the company. 

- I've been wondering if there is an application that can directly display cheap travel products to guests and allow them to buy. It also can record the purchase data then automatically create analysis charts for the company marketing department. This application may not completely solve all problems, but it can alleviate them.

## Why is it a problem that needs solving? :bulb:
- I found that for traditional travel companies, the B2B business relationship is too fragile, especially after the pandemic,  many higher-level travel agencies closed down, in this situation, traditional travel companies are pretty difficult to show their travel products to guests who are keen to find travel plans. After jumping over the upper-level travel agency, the traditional travel company can bring more favourable product prices to the guests. The last point is that for the company's internal management, the charts and data provided by this website can also allow managers to better understand industry trends. 

- Therefore, the Travel Fun application comes. 

## A link (URL) to your deployed app (i.e. website) :globe_with_meridians:
<a href="https://travel-is-fun.herokuapp.com/" target="blank"> Travel Fun </a>

## A link to your GitHub repository (repo) :computer: 
<a href="https://github.com/lanceliumeng/travel-fun" target="blank"> Github Repo Link </a>

## Description of your marketplace app (website), including: TLDR :full_moon_with_face:

### Purpose :mega:
Travel Fun website tries to provide navigation for people who like to travel, let them know the playable options of the destination, and also provide a platform for the travel company, so that professional itinerary planning can be seen by more clients. At the same time, this website also provides an internal management system for the company, allowing the manager or director to see all travel orders at different cycles, etc.

### Functionality / features :star2:
- #### Feature 01: Users account
Travel Fun website allows users to create an account by email and password, they also need to click google reCAPTCHA to make sure each user account is created by real people. 

- #### Feature 02: Authentication & Authorisation by account roles
- if the user doesn’t want to create an account, that’s ok, you still can visit the website home page, the home page can let users know how many travel products do we have, how many professional trip designers do we have, and you can also find how many active accounts (our traveller and designer community) do we have. At home page, you also can find out popular trips, top-rated trips and the newest trips. 

- when the user wants to explore more things in Travel Fun website, you need to sign up first. After the user signs up, the admin account can based on your requirement, define your account role. Except for the admin account, the role of each newly registered account is client by default setting. 

- Authorisation relates to the user's account role. For the Travel Fun website, there are 3 user’s roles: admin, operator, and client. 
  - For Admin:
Admin has all the permissions of the website, including changing user roles, viewing all order statuses, viewing all user login statuses, all travel product operation statuses, and sales analysis. At the same time, he also has the operation authority of the operator role. The admin can approve the travel product, and only the approved product can be displayed on the client's page. If a travel product needs to be deleted, the admin needs to notify the creator（operator） to delete it, and the admin has no right to do so. This can prevent confusion in the company's operations at some extent.

  - For Operating users:
They can create travel products, upload pictures on the creation page, format the itinerary description through the rich text area to make it easier to read, and can choose travel plan language for different clients who have different cultural backgrounds, also operator can decide the duration and price for the travel product. After creating a new travel product, it needs to wait for the approval of the admin user. And operators can also see which user has purchased their own travel products, which is convenient to communicate with their clients at any time.

  - For client users:
After logging in to the website, they can not only see more details of travel products but also search for travel products according to their own needs. The search function includes allowing search by travel product title, introduction, language and price. And they also can sort based on the price and popularity of travel products from high to low. After purchases, clients can find the purchased products in the travel plan, and they can write reviews and tell us how they feel. The pending review area will notify clients if there is any travel product they forget to leave comments. 

- Since users with different permissions can see different interfaces, this can prevent users from performing unauthorized operations. If the user wants to perform an unauthorized operation by entering the url, he will receive a prompt from the website that the operation is invalid.

- #### Feature 03: create, update, read, delete  & image upload
As I said above, different users' permissions can do different crud operations.
Admin and operators can create travel products, also can update or delete products as needed. And only the product creator has the right to make subsequent updates and deletions. clients can leave a message on the purchased products to make the travel product more valuable.

- #### Feature 04: trackable by magic gem public_activity
include PublicActivity::Model in itinerary , trip and user model, to allow admin role account track operation history, incluse user account create, which operator did what to travel plan etc. 

### Sitemap :scroll:
![sitemap](./docs/sitemap/Travel_Fun_Sitemap.png)

### Screenshots :smiley_cat:

<details>
  <summary>Click Me to expand! - Landing Page</summary>

- #### landing page no log in
  ![landing page](docs/Screenshots/landing_page_no_log_in/0_landing_page_no_log_in.jpeg)
- signup page
  ![signup page](docs/Screenshots/landing_page_no_log_in/1_signup_page.png)
- login page
  ![login page](docs/Screenshots/landing_page_no_log_in/2_login_page.png)

</details>

<details>
    <summary>Click Me to expand! - Client User</summary>

- #### Client account log in
  - #### Clinet user landing page
  ![client user 01](docs/Screenshots/Client_account_login/Clinet_user_landing_page_01.png)
  - #### Client user trip list page
  ![client user 02](docs/Screenshots/Client_account_login/Client_user_trips_page.png)
  - #### Client user travel plan brought trips page
  ![client user 03](docs/Screenshots/Client_account_login/Client_user_travel_plan_brought_trips_page.png)
  - #### Client user travel plan pending review page
  ![client user 04](docs/Screenshots/Client_account_login/Client_user_travel_plan_pending_review_page.png)

</details>

<details>
    <summary>Click Me to expand! - Operator User</summary>

- #### Operator account log in
  - #### Operator user landing page
  ![operator user 01](docs/Screenshots/Operator_account_login/Operator_user_landing_page.png)
  - #### Operator user trip list page
  ![operator user 02](docs/Screenshots/Operator_account_login/Operator_user_trips_page.png)
  - #### Operator user create trip page
  ![operator user 03](docs/Screenshots/Operator_account_login/Operator_user_create_trip_page.png)
  - #### Operator user created travel page
  ![operator user 04](docs/Screenshots/Operator_account_login/Operator_user_created_travels_page.png)
  - #### Operator user my client page
  ![operator user 05](docs/Screenshots/Operator_account_login/Operator_user_my_clients_page.png)

</details>

<details>
    <summary>Click Me to expand! - Admin User</summary>

- #### Admin account log in
  - #### Admin user landing page
  ![admin user 01](docs/Screenshots/Admin_account_log_in/Admin_user_landing_page.png)
  - #### Admin user trip list page
  ![admin user 02](docs/Screenshots/Admin_account_log_in/Admin_user_trips_page.png)
  - #### Admin user trip pending page
  ![admin user 03](docs/Screenshots/Admin_account_log_in/Admin_user_trip_pending_list.png)
  - #### Admin user all orders page
  ![admin user 04](docs/Screenshots/Admin_account_log_in/Admin_user_all_orders_page.png)
  - #### Admin user users community page
  ![admin user 05](docs/Screenshots/Admin_account_log_in/Admin_user_users_community_page.png)
  - #### Admin user operation history page
  ![admin user 06](docs/Screenshots/Admin_account_log_in/Admin_user_operation_page.png)
  - #### Admin user analytics page
  ![admin user 07](docs/Screenshots/Admin_account_log_in/Admin_user_analytics_page.png)
  - #### Admin user create new trip page
  ![admin user 08](docs/Screenshots/Admin_account_log_in/Admin_user_create_new_trip_page.png)
  - #### Admin user created travel page
  ![operator user 09](docs/Screenshots/Admin_account_log_in/Admin_user_created_trips_page.png)
  - #### Admin user my client page
  ![admin user 10](docs/Screenshots/Admin_account_log_in/Admin_user_my_clients_page.png)

</details>

<details>
    <summary>Click Me to expand! - Accounting setting page</summary>

![account setting](docs/Screenshots/accounting_setting_page.png)

</details>

### Target audience :gem:
  - Travel company that want to find a platform which can not only save operator working time and automatically display itinerary to the client, then help them place an order faster, but also help for company management. 
  - People who want to find a suitable travel plan
  
### Tech stack :star:
<details>
    <summary> Tech Stack List:</summary>

- HTML5
- SCSS
- Font Awesome
- Bootstrap
- JavaScript
- jQuery
- Ruby
- Ruby on Rails
- PostgreSQL
- Balsamiq-Wireframes
- Lucidchart
- Heroku 
- Canva
- Postman
- AWS S3
- AWS IAM
  
</details>

## User stories :bookmark_tabs:

#### Users without login can view: 
- the user does not have to be signed in to view popular trips list, top-rated trips list and new trips list
 
#### Users need to log in then can have more authorities   
 - ##### When user account is client role account, then he can:
    - Buy travel plan
    - See what travel plan he bought
    - Write review for their own travel plan 
    - Users can search for trips
 - ##### When user account is operator role account, then he can:
    - Create travel plan, write content and upload image, also can add itinerary for travel plan
    - Edit their own travel plan 
    - Delete travel plan
    - Can see who brought their travel plan
    - Can see analytics for their created travel plan
 - ##### When user account is admin role account, then he can:
    - Admin can do what client role do
    - Admin can do what operator can do
    - Admin can check and approve all travel plans
    - Admin can see all orders
    - Admin can check each registered account status, edit any account roles
    - Admin can check each operation records for travel plan
    - Admin can check analytics for users created, orders created and so on

#### Users can log in and out

## Wireframes :clipboard:
[please find my wireframes in this link](docs/Wireframes/Wireframes-Travel-Fun.bmpr)

## Entity Relationship Diagram (ERD) :pushpin:
![erd](docs/ERD/Travel%20Fun%20ERD.png)