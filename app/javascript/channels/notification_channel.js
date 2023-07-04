import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const notificationsContainer = document.getElementById("notifications-container");
    const notificationItem = document.createElement("div");
    const count = document.getElementById("notification-count");
    count.textContent = parseInt(count.textContent)+1;
    notificationItem.classList.add("notification-item");
    notificationItem.textContent = data;
    notificationsContainer.appendChild(notificationItem);
  }
});
