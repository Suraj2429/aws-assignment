const express = require("express");
const axios = require("axios");

const app = express();
const PORT = 3000;

// Change this when deploying
const BACKEND_URL = "http://localhost:5000";

app.get("/", async (req, res) => {
  try {
    const response = await axios.get(`${BACKEND_URL}/api/message`);
    res.send(`
      <h1>Hello Suraj</h1>
      <p>${response.data.message}</p>
    `);
  } catch (error) {
    res.send("<h1>Backend not reachable</h1>");
  }
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Frontend running on port ${PORT}`);
});
