const express = require('express');
const app = express();
const PORT = 8080;

app.get('/', (req, res) => {
    res.json({ message: 'Welcome to my GitHub Actions Dockerized API' });
});

app.listen(PORT, () => {
    console.log(`Server running on http://0.0.0.0:${PORT}`);
});
