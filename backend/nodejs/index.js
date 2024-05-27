// importing modules
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const path = require("path");
require("dotenv").config();

const app = express();
const port = 3000; //process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require("./models/room");

const cors = require("cors");

// middle ware
app.use(express.json());

app.use(cors());

//Socket io
//https://socket.io/docs/v3/handling-cors/

//var io = require("socket.io")(server);
/* var io = require("socket.io")(server, {
  cors: {
    origin: "*",
  },
}); */
var io = require("socket.io")(server, {
  cors: {
    origin: "http://tic-tac-toe-server.node.how-much-now.com",
    methods: ["GET", "POST"],
  },
});


const DB =
  "mongodb+srv://rivaan:test123@cluster0.rmhtu.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
//const DB = "mongodb://localhost:27017/tic-tac-toe"; //Localhost is used for local development
//const DB = process.env.MONGO_DB; //Localhost is used for local development

const socketIds = [];
const rooms = [];

// Servir les fichiers statiques du dossier public
app.use(express.static(path.join(__dirname, "public")));

app.get("/", function (req, res) {
  res.send("It's works!");
});

app.get("/delete-rooms", function (req, res) {
  deleteAllRooms();
  res.send("All rooms was deleted.");
});

io.on("connection", (socket) => {
  console.log("_________________Socket connected____________________________");
  console.log("Socket connected, socket.id : ", socket.id);

  socketIds.push(socket.id);
  console.log("socketIds add socket.id : ", socketIds);

  //Create Room
  socket.on("createRoom", async ({ nickname }) => {
    console.log("createRoom");
    console.log("nickname : ", nickname);

    if (!nickname) {
      socket.emit("errorOccurred", "Please enter a nickname.");
      console.log("Please enter a nickname.");
      return;
    }

    /* if (socketIds.includes(socket.id)) {
      socket.emit("errorOccurred", "You are already in a room.");
      console.log("You are already in a room.");
      return;
    } */

    rooms.push(nickname);

    console.log("rooms : ", rooms);
    socket.emit("rooms", nickname);

    // socket.emit("createRoomSuccess", nickname);

    // socket.broadcast.emit("createRoomSuccess", nickname);

    try {
      // room is created in db
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

      //io.emit("updateRooms", rooms);
    } catch (e) {
      console.log("Error : ", e);
    }
  });

  socket.on("getRoomList", async () => {
    console.log("getRoomList");
    console.log("rooms", rooms);
    //io.emit("getRoomList", rooms);
    //io.to("roomId").emit("createRoomSuccess", rooms);
    //io.broadcast.emit("rooms", rooms);

    let roomList = await Room.find({}).sort({ _id: -1 });
    console.log("roomList : ", roomList);
    io.emit("getRoomList", roomList);
  });

  //Join Room
  socket.on("joinRoom", async ({ nickname, roomId }) => {
    console.log("joinRoom");
    console.log("nickname : ", nickname);
    console.log("roomId : ", roomId);
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room ID.");
        console.log("Please enter a valid room ID.");
        console.log("joinRoomSuccess. emit to roomId : ", roomId);
        //io.to(roomId).emit("joinRoomSuccess", roomId);
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
        console.log("joinRoomSuccess : ", room);
      } else {
        socket.emit(
          "errorOccurred",
          "The game is in progress, try again later."
        );
        console.log("The game is in progress, try again later.");
      }
    } catch (e) {
      console.log("error", e);
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

    socketIds.splice(socketIds.indexOf(socket.id), 1);
    console.log("socketIds delete socket.id : ", socketIds);
    console.log("socketIds  : ", socketIds);

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
  console.log(`All rooms was deleted.`);
  deleteAllRooms();
});

let deleteAllRooms = async () => {
  await Room.deleteMany({});
};
