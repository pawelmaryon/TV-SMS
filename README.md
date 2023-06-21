# README

This README would normally document whatever steps are necessary to get the
application up and running.

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
# TV-SMS
Description Of My Approach

In approaching this problem, I have taken the following steps:

Importing Log Data: I have created a VoteImport class with a method import_log_data that reads a file line by line and processes each line to create or update relevant records in the database. I have used regular expressions to extract the necessary data from each line and handled exceptions such as invalid byte sequences and ActiveRecord::RecordInvalid when creating a candidate. This approach allows for efficient and accurate importing of vote data from a file.

Line Count: To calculate the number of lines in the file, I have implemented a method called count_lines in the VoteImport class. This method uses the File.foreach method to iterate over each line in the file and increments a line_count variable. This approach provides an accurate count of the total number of lines in the file.

Routes: In the config/routes.rb file, I have defined the routes for the application using the Rails routing DSL. I have set the root path to the campaigns#index action and defined resources for campaigns, candidates, and votes. Additionally, I have added a custom route post '/import_votes', to: 'campaigns#import_votes' to handle the import of votes from a file.

Models: I have defined several models in the app/models directory. The Vote model belongs to a Candidate and a Campaign, and it validates the presence of the validity attribute. The Campaign model has a many-to-many association with the Candidate model and a one-to-many association with the Vote model. The Candidate model belongs to a Campaign and has a one-to-many association with the Vote model. These models provide a structured and organized way to represent the data and their relationships.

Database Schema: The db/schema.rb file defines the database schema for the application. It includes tables for campaigns, candidates, votes, and vote_counts, each with their respective columns and associations. The schema ensures data integrity and provides a clear representation of the database structure.

In summary, my approach to this problem involves importing vote data from a file, processing each line to create or update relevant records in the database, and counting the number of lines in the file. I have made design decisions based on Rails conventions, such as using models and associations to represent the data and following the routing DSL to define the application's routes. I have also taken into consideration data integrity and error handling by using regular expressions, handling exceptions, and validating the presence of attributes.