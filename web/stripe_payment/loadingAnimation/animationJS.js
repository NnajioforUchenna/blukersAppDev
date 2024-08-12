let counterElement = document.getElementById("counter");
let sliderElement = document.getElementById("slider");

let counter = 0;
let increaseCounter = function () {
  if (counter <= 100) {
    counterElement.innerText = counter + "%";
    sliderElement.style.width = counter + "%";
    counter++;
  } else {
    clearInterval(counterInterval);
  }
};

let counterInterval = setInterval(increaseCounter, 200); // 200ms * 100 = 20 seconds
