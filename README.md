# Reporting

A repo to develop and explore analytics.

# How to run locally

1. Create a `.env` file, using `.env.example` as a guide.
2. Start the server: run `docker compose up` from the project root.
3. Connect to the server with your editor of choice, using the credentials provided in your `.env` file.
4. Create tables as needed by running commands in your editor of choice. Table generation commands are in the `sql/tables` directory.
5. Run the command to generate fake data: `node src/index.js`.

You should now be able to run queries against the database.
