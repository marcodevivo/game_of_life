import consumer from "./consumer";

document.addEventListener("DOMContentLoaded", function () {
  const gameOutput = document.getElementById("game-output");
  console.log(gameOutput);
  if (gameOutput) {
    consumer.subscriptions.create("GameChannel", {
      connected() {
        console.log("Connected to the GameOfLifeChannel");
      },
      disconnected() {
        console.log("Disconnected from the GameOfLifeChannel");
      },
      received(data) {
        const text = `Generation ${data.number_of_generation}:\n${data.rows} ${data.cols}\n${data.grid}`;
        gameOutput.innerHTML = `<pre>${text}</pre>`; // Aggiorna il contenuto
      }
    });
  }
});