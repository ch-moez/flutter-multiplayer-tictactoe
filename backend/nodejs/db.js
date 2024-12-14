// db.js
const mongoose = require('mongoose');

let dbIsConnected = false; // Déclaration de la variable

// Remplacez par votre chaîne de connexion MongoDB
const DB = "mongodb+srv://user_tictactoe:tictactoe@cluster0.xoxw0.mongodb.net/test?retryWrites=true&w=majority";

const connectDB = async () => {
  try {
    await mongoose.connect(DB, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("Connexion à MongoDB réussie !");
  } catch (error) {
    console.log("_____________x____x_____________");
    console.error("Erreur de connexion à MongoDB :", error);
    process.exit(1); // Quitter le processus avec un code d'erreur
  }
};

// Exporter la fonction de connexion et la variable
module.exports = { connectDB, dbIsConnected };