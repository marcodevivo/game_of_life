import consumer from "./consumer";

document.addEventListener("turbo:load", function () {
  const gameOutput = document.getElementById("game-output");
  if (gameOutput) {
    consumer.subscriptions.create("GameChannel", {
      connected() {
        console.log("Connected to the GameChannel");
      },
      disconnected() {
        console.log("Disconnected from the GameChannel");
      },
      received(data) {
        const text = `Generation ${data.number_of_generation}:\n${data.rows} ${data.cols}\n${data.grid}`;
        gameOutput.innerHTML = `<pre>${text}</pre>`; // Aggiorna il contenuto
      }
    });
  }
});