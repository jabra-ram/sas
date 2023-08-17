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
    const notificationItem = document.createElement("p");
    const hrelement = document.createElement("hr");
    const count = document.getElementById("notification-count");
    count.textContent = count.textContent==""?"1":parseInt(count.textContent)+1;
    notificationItem.classList.add("bold");
    notificationItem.classList.add("m-0");
    notificationItem.classList.add("p-1");
    hrelement.classList.add("m-0");
    notificationItem.textContent = data;
    notificationsContainer.prepend(hrelement);
    notificationsContainer.prepend(notificationItem);
  }
});
