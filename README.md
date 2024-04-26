# Sportpal
Finding a partner to play Tennis, Badminton, or a similar sport in a new place is challenging. Sportpal - an online web platform - connects such users. With a profile and sports activity management system, Sportpal streamlines the process of connecting with fellow sports enthusiasts. 

# What can users do?
At this momemnt:

- Users can sign up, log in and log out of the platform.
- Users can create (put up) an offer (game)
- Users can edit their offer
- Users can delete their offer
- Users can view all offers
- Users can filter offers by parameters like date, sport, and skill level.

In the future:
- Users can request to take (participate in) the offer (game)
- Users (creators of offers/games) can accept or decline an invitation to an offer
- Users can send messages with matched players (offers)
- Users can rate their sports partner's skill level after a game
- Users can create group offer where more than one can join the game

[Click here to view the Conceptual Model](./docs/diagrams/conceptual_model_sportpal.png)

# System Architecture
SportPal operates on a client-server model where the frontend and backend communicate through GraphQL and RESTful APIs. Phoenix framework is the backend, and PostgreSQL is the database for SportPal. The framework implements the server-side Model View Controller (MVC) pattern. 

SportPal doesn't have a separate front end. The front end utilizes the HEEx template engine, which is part of the Phoenix framework. All frontend pages are server-side rendered. Currently, there are only login, signup, and onboarding pages. All the features, although available in the backend, are yet to be exposed to the front end.

[Click here to view the System Architecture](./docs/diagrams/system_architecture_sportpal.png)

SportPal employs GraphQL APIs for fetching and managing all offers. However, less frequently called data in activities like log-in or signup uses RESTful APIs. Changesets are used for data validation and casting. They ensure only clean and intended data is sent to the database. 

# Technologies Used
The following technologies were used to build this project:

- Elixir programming language
- Phoenix framework
- GraphQL API
- PostgreSQL database
- Absinthe GraphQL library
- Heex template (as frontend)


# Getting Started

To set up and run this Phoenix project on your local machine, follow these steps:

1. **Clone the Repository**: Clone the project repository to your local machine using Git.
2. **Install Elixir and Phoenix**: Ensure you have Elixir installed on your machine. Then, install the Phoenix framework. Visit the [Phoenix installation page](https://hexdocs.pm/phoenix/installation.html) for detailed instructions.
3. **Install PostgreSQL**: Install PostgreSQL if it's not already installed on your machine. Check [PostgreSQL's official site](https://www.postgresql.org/download/) for installation guides based on your operating system.
4. **Configure the Database Connection**: Open the `config/dev.exs` file and set up your database connection details:
```
    config :your_app, YourApp.Repo,
    username: "your_username",
    password: "your_password",
    database: "your_app_dev",
    hostname: "localhost",
    show_sensitive_data_on_connection_error: true,
    pool_size: 10
```
5. **Install Dependencies**: Navigate to the project directory in your terminal and run: `mix deps.get`
6. **Create and Migrate the Database**: Set up your database with: `mix ecto.setup`
7. **Start the Phoenix Server**: Launch the Phoenix server: `mix phx.server`
8. **Visit the Application**: Open your web browser and navigate to: `http://localhost:4000`

# Contributing
If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your changes.
3. Make your changes and commit them with descriptive commit messages.
4. Push your changes to your forked repository.
5. Submit a pull request to the original repository.

# ER Diagram
- [Click here to view the ER diagram](./docs/diagrams/erd_sportpal.png)



