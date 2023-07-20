<br />
<div align="center">
  <h2 align="center" style="font-size:8vw;">Homefay</h2>

  <p align="center">
    A chores management app build using Swift
    <br />
    <a href="https://github.com/agungsptr/node-clean"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/agungsptr/node-clean/stargazers">
      <img src="https://img.shields.io/github/stars/agungsptr/node-clean-ts.svg">
    </a>
    <a href="https://github.com/agungsptr/node-clean/network">
      <img src="https://img.shields.io/github/forks/agungsptr/node-clean-ts.svg?color=blue">
    </a>
    <a href="https://github.com/agungsptr/node-clean/network">
      <img src="https://img.shields.io/github/contributors/agungsptr/node-clean-ts.svg?color=blue">
    </a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#feature">Feature</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#alternative-installation">Alternative Installation</a></li>
      </ul>
    </li>
    <li>
      <a href="#usage">Usage</a>
      <ul>
        <li><a href="#web-services">Web Services</a></li>
        <li><a href="#grpc">gRPC</a></li>
        <li><a href="#unit-test">Unit Test</a></li>
        <li><a href="#coverage-test">Coverage Test</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
    <li><a href="#support-me">Support Me</a></li>
  </ol>
</details>

## About The Project
**This a TypeScript version of Node Clean**, if you want to see the JavaScript version follow this [way](https://github.com/agungsptr/node-clean).


This project aims to be used as a base backend project which implements clean architecture.
I create this project to help me build a backend application faster as a template project.
Feel free to use this project as your base application.
I am very happy if you are helped by using this template.

### Features

* RESTful
* gRPC
* Authentication using JWT
* CRUDS Resources
* Unit Test
* Coverage Test
* Load Test

### Built With

* [![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://www.swift.org)

## Getting Started

Let's start this project...

### Prerequisites

Before you dig into this project it very nice if you understand the clean architecture concept. I recommend you to read about the **Clean Architecture** first.

* Swift
* SwiftUI
* CoreData + CloudKit

### Installation

1. Clone the repo

   ```sh
   git clone https://github.com/agungsptr/node-clean-ts.git
   ```

2. Install Yarn packages

   ```sh
   yarn install
   ```

3. Copy `.env.example` to `.env`

4. Setup `MongoDB` container

   ```sh
   make infra
   ```

5. Seed database

   ```sh
   make seed
   ```

6. Now you can run this project, this project running on port 7000 in your local

   ```sh
   make dev
   ```

## Usage

### Web Services

* Login

```sh
  curl --location --request POST 'localhost:7000/api/auth/login' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "username": "agungsptr",
      "password": "24434"
  }'
```

* Get All Users

```sh
  curl --location --request GET 'localhost:7000/api/users' \
  --header 'Authorization: Bearer <AuthToken>'
```

### Available Make Commands

```sh
# Infrastructure
make infra              # Run only db container
make build              # Build image
make compose-up         # Run all container including db and app
make compose-down       # Stop all containers
make purge              # Delete all images
make auto               # Auto command, to build image and run all containers
make wait-db            # Check db is ready
make wait-app           # Check app is ready

# Application
make start              # Run webservice
make dev                # Run webservice in dev mode with watching mode
make grpc               # Run gRPC
make grpc_client        # Run example gRPC client

# Database
make seed               # Seeding database

# Testing
make test               # Unit testing
make coverage_test      # Coverage testing
make load_test          # Load testing, to testing the app performace
```

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch ( `git checkout -b feature/magic` )
3. Commit your Changes ( `git commit -m 'feature/magic: Add some magic'` )
4. Push to the Branch ( `git push origin feature/magic` )
5. Open a Pull Request

## License

Distributed under the MIT License. See [LICENSE](./LICENSE) for more information.

## Acknowledgments

Resources that help me to build this project.

* [Clean Architecture Node.js - Build a REST API](https://mannhowie.com/clean-architecture-node)
* [Clean Architecture in ExpressJS Applications (NodeJS)](https://merlino.agency/blog/clean-architecture-in-express-js-applications)
* [JavaScript dependency injection in Node – friend or foe?](https://tsh.io/blog/dependency-injection-in-node-js)