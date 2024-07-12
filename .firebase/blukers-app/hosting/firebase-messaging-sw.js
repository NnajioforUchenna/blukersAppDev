importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyA8inIzoO71nuPDfH0ZED__OppLmbBkiYw",
    authDomain: "blukers-development.firebaseapp.com",
    databaseURL: "https://blukers-development-default-rtdb.firebaseio.com",
    projectId: "blukers-development",
    storageBucket: "blukers-development.appspot.com",
    messagingSenderId: "25989559034",
    appId: "1:25989559034:web:00bcd96fde3b747f64cf43",
    measurementId: "G-6RRZVJSLKK"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});