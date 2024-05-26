// importing modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3001;
var server = http.createServer(app);
const Room = require("./models/room");
var io = require("socket.io")(server);

const cors = require("cors");

// middle ware
app.use(express.json());

app.use(cors());

//const DB = "mongodb+srv://rivaan:test123@cluster0.rmhtu.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
const DB = "mongodb://localhost:27017/tic-tac-toe"; //Localhost is used for local development

io.on("connection", (socket) => {
  console.log("_________________Socket connected____________________________");
  console.log("Socket connected, socket.id : ", socket.id);

  socket.on("createRoom", async ({ nickname }) => {
    console.log("createRoom");
    console.log("nickname : ", nickname);
    try {
      // room is created
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();
      console.log(room);
      const roomId = room._id.toString();

      socket.join(roomId);
      // io -> send data to everyone
      // socket -> sending data to yourself
      io.to(roomId).emit("createRoomSuccess", room);
      console.log("Room created successfully!");
    } catch (e) {
      console.log('error', e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room ID.");
        return;
      }
      let room = await Room.findById(roomId);

      if (room.isJoin) {
        let player = {
          nickname,
          socketID: socket.id,
          playerType: "O",
        };
        socket.join(roomId);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit(
          "errorOccurred",
          "The game is in progress, try again later."
        );
      }
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("tap", async ({ index, roomId }) => {
    try {
      let room = await Room.findById(roomId);

      let choice = room.turn.playerType; // x or o
      if (room.turnIndex == 0) {
        room.turn = room.players[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.players[0];
        room.turnIndex = 0;
      }
      room = await room.save();
      io.to(roomId).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find(
        (playerr) => playerr.socketID == winnerSocketId
      );
      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("message", () => {
    console.log("message");

    socket.broadcast.emit("message");
  });
  socket.on("disconnect", () => {
    console.log("Socket disconnected, socket.id : ", socket.id);
    console.log(
      "___________________=Socket disconnected=____________________________"
    );
  });

  socket.on("errorOccurred", (error) => {
    console.log(error);
  });
});

mongoose
  .connect(DB)
  .then(() => {
    console.log("mongoose Connection successful!");
  })
  .catch((e) => {
    console.log("mongoose Connection failed!");
    console.log(e);
  });

server.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on port ${port}`);
  console.log(`http://localhost:${port}`);
});
