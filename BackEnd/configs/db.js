const mongoose = require('mongoose');

mongoose
  .connect('mongodb+srv://msad8961:Op2bCZcajamUvSX7@nodeexpress.wrddd.mongodb.net/task_manager?retryWrites=true&w=majority&appName=NodeExpress', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.error('Could not connect to MongoDB', err));
