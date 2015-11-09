[ ![Codeship Status for margonaut/DreamCacher](https://codeship.com/projects/17440400-492e-0133-6ea0-168d58eb1296/status?branch=master)](https://codeship.com/projects/105535) [![Code Climate](https://codeclimate.com/github/margonaut/DreamCacher/badges/gpa.svg)](https://codeclimate.com/github/margonaut/DreamCacher)

# DreamCacher
Dream Journal + Data Visualization

DreamCacher is a data visualization-based dream journal. After running dreams through an AlchemyAPI keyword sentiment analysis, the resulting data is requested at API endpoints through serialized models and used to support a responsive journal timeline and analytics dashboard.

## Ruby version
2.1.5

## Live App Demo
[DreamCacher](https://ancient-peak-7159.herokuapp.com/)

##Storyboard Link
[Trello Board](https://trello.com/b/abphbsgy/dreamcacher)

## ER Diagram
![ER](http://i.imgur.com/JXiDOQX.png)

## Get Started
1. Bundle the gems

  bundle

2. Bootup the database:

  rake db:create

3. Bring in your migrations

  rake db:migrate

4. Add Amazon Web Services keys, AlchemyAPI key, and S3 bucket name to the example.env file. Rename to ".env"

5. Run the test suite

  rake

## Deployment
On a clean Master branch, run:

  ```
  git push heroku master
  ```
