![](https://img.shields.io/badge/Microverse-blueviolet)

# Budget App
> Budget App is a mobile web application where users can manage their expenses and organize them in categories.

![screenshot](https://user-images.githubusercontent.com/61767582/176782109-ba6d5205-a167-4caf-b057-3009f7f24c1f.png)


## Built With

- Rails v.7.0.3
- PostgreSQL v.14.3
- Tailwind CSS for Rails
- Redis
- Sidekiq

## Requirements 
Install:
- [Ruby v.3.1.2](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails v.7.0.3](https://guides.rubyonrails.org/v5.0/getting_started.html#installing-rails)
- [psql (PostgreSQL) v.14.3](https://www.postgresql.org/download/)
- [Redis](https://redis.io/docs/getting-started/installation/)

## Getting Started

To get a local copy follow these simple example steps.  

1. Open the terminal window and clone the repository using this command:  
`git@github.com:leopiresgoss/budget-app.git` 
1. Change the directory:`cd budget-app`
2. Install the project's dependencies by running this command:   
`bundle install`
4. Make sure that PostgreSQL is running perfectly in your computer
6. Run `rails db:create` and then `rails db:migrate` to create and setup the database in PostgreSQL
5. In a separate terminal, run your Redis server, and, open another one to run the Sidekiq
7. Run `./bin/dev` to start the server and run TailwindCSS, you should have three terminals opened: 
   one for the Redis, one for the Sidekiq and the last one for this server
8. [OPTIONAL] To test the application, run `rspec`

## Author
👤 **Leonardo Pires Goss**
- GitHub: [leopiresgoss](https://github.com/leopiresgoss)
- Twitter: [@leonardopgoss](https://twitter.com/leonardopgoss)
- [LinkedIn](https://www.linkedin.com/in/leonardogoss/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/leopiresgoss/budget-app/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- A special thank for @fernandorpm for this amazing [README template](https://github.com/microverseinc/readme-template)
- Thanks [Gregoire Vella](https://www.behance.net/gregoirevella) for this outstanding [template](https://www.behance.net/gallery/19759151/Snapscan-iOs-design-and-branding?tracking_source=)

## 📝 License

This project is [MIT](/LICENSE) licensed.
