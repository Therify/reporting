require("dotenv/config");
const { faker } = require("@faker-js/faker");
const { Client } = require("pg");
const { get } = require("env-var");

const client = new Client({
  host: "127.0.0.1",
  port: get("POSTGRES_PORT").required().asPortNumber(),
  user: get("POSTGRES_USER").required().asString(),
  password: get("POSTGRES_PASSWORD").required().asString(),
  database: "postgres",
});

const EVENTS = {
  ACCOUNT_CREATED: "Accounts/AccountCreated",
  MEMBER_REGISTERED: "Accounts/MemberRegistered",
  SELF_ASSESSMENT_COMPLETED: "Care/SelfAssessmentCompleted",
  RECOMMENDATION_REQUEST_SUBMITTED: "Care/RecommendationRequestSubmitted",
};

const USERS = {
  TEST_USER_1: faker.string.uuid(),
  TEST_USER_2: faker.string.uuid(),
};

const ACCOUNTS = {
  Therify: faker.string.uuid(),
  WarbergPincus: faker.string.uuid(),
};

async function main() {
  await client.connect();
  for await (const _ of Array.from({ length: 50 })) {
    await client.query(
      "INSERT INTO activities (action, actor_id, target_id, created_at) values ($1, $2, $3, $4)",
      [
        faker.helpers.arrayElement(Object.values(EVENTS)),
        faker.helpers.arrayElement(Object.values(USERS)),
        faker.helpers.arrayElement(Object.values(ACCOUNTS)),
        faker.date.past(),
      ]
    );
  }
}

main()
  .catch(console.error)
  .finally(async () => await client.end());
