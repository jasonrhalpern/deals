# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.where(name: "Restaurants").first_or_create
Category.where(name: "Bars").first_or_create

Plan.where(stripe_plan_token: "intro_monthly", description: "$3.95/month", trial_days: 30, interval: "monthly", active: true).first_or_create
Plan.where(stripe_plan_token: "intro_yearly", description: "$24.95/month", trial_days: 30, interval: "year", active: true).first_or_create

