document.addEventListener("DOMContentLoaded", function() {
  Announce.init();
});

$(function () {
  window.addEventListener("message", function (event) {
    const { title, msg, time, type, action, setPos } = event.data;

    switch (action) {
      case "sendNotify":
        Notify.trigger(title, msg, time, type);
        break;
      case "sendAnnounce":
        Announce.trigger(title, msg, time, type);
        break;
      case "Util":
        $('.notify .container').css('bottom', setPos + 'px');
        break;
      default:
        break;
    }
  });
});

const Announce = {
  init() {
    this.hideTimeout = null;
    this.el = document.querySelector(".announce");
    this.createElements();
  },
  createElements() {
    this.title = document.createElement("div");
    this.title.className = "title";
    this.divider = document.createElement("div");
    this.divider.className = "divider";
    this.desc = document.createElement("div");
    this.desc.className = "desc";
    this.desc.textContent = "content";
    this.appendElementsToContainer();
  },
  appendElementsToContainer() {
    const container = document.querySelector(".announce .wrapper .container");
    container.appendChild(this.title);
    container.appendChild(this.divider);
    container.appendChild(this.desc);
  },
  trigger(ttl, message, duration, type) {
    clearTimeout(this.hideTimeout);
    this.showAnnouncement(ttl, message, duration, type);
    this.hideTimeout = setTimeout(() => {
      this.el.classList.remove("announce-visible");
    }, duration);
  },
  showAnnouncement(ttl, message, duration, type) {
    this.el.classList.remove("announce-visible");
    setTimeout(() => {
      this.el.classList.add("announce-visible");
      this.processMessage(message, type);
      this.title.textContent = ttl;
    }, 300);
  },
  processMessage(message, type) {
    let newMsg = this.formatMessage(message);
    this.setGlowEffect(type);
    this.desc.innerHTML = newMsg;
  },
  formatMessage(message) {
    const replacements = {
      "~r~": "<span style='color: red'>",
      "~b~": "<span style='color: blue'>",
      "~g~": "<span style='color: green'>",
      "~y~": "<span style='color: yellow'>",
      "~p~": "<span style='color: purple'>",
      "~c~": "<span style='color: grey'>",
      "~m~": "<span style='color: darkgrey'>",
      "~u~": "<span style='color: black'>",
      "~o~": "<span style='color: orange'>",
      "~h~": "<span style='font-weight: bold'>",
      "~n~": "<br>",
      "~w~": "<span style='color: white'>",
      "~s~": "</span>"
    };
    return Object.keys(replacements).reduce((acc, key) => acc.replace(new RegExp(key, "g"), replacements[key]), message);
  },
  setGlowEffect(type) {
    const elements = document.getElementsByClassName('glow');
    for (let i = 0; i < elements.length; i++) {
      elements[i].style.background = type;
      this.divider.style.background = type;
      this.divider.style.boxShadow = '0px 0px 10px 0px ' + type;
    }
  }
};


const Notify = {
  notifications: [],

  trigger(title, message, duration, type) {
    this.removeExcessNotifications();

    const id = `notification-${Math.random().toString(36).slice(2)}`;
    const el = this.createNotificationElement(id, title, message, type);
    this.showNotification(el);

    setTimeout(() => {
      this.hideNotification(el);
      setTimeout(() => {
        this.removeNotification(el);
      }, 500);
    }, duration);

    this.notifications.push(el);
  },

  removeExcessNotifications() {
    if (this.notifications.length >= 6) {
      const removedNotification = this.notifications.shift();
      this.removeNotification(removedNotification);
    }
  },

  createNotificationElement(id, title, message, type) {
    const el = document.createElement("div");
    el.className = "notification";
    el.setAttribute("id", id);

    const divider = this.createAndAppend("div", "divider", el);
    divider.style.background = type;

    const titleEl = this.createAndAppend("div", "title", el);
    titleEl.innerHTML = title;

    const desc = this.createAndAppend("div", "desc", titleEl);
    desc.innerHTML = this.parseMessage(message);

    document.querySelector(".notify .container .wrapper").appendChild(el);
    return el;
  },

  showNotification(el) {
    setTimeout(() => {
      el.classList.add("notification-visible");
    }, 10);
  },

  hideNotification(el) {
    el.classList.remove("notification-visible");
  },

  removeNotification(el) {
    el.remove();
  },

  createAndAppend(tag, className, parent) {
    const el = document.createElement(tag);
    el.className = className;
    if (parent) {
      parent.appendChild(el);
    }
    return el;
  },

  parseMessage(message) {
      const colorMap = {
        "~r~": "red",
        "~b~": "blue",
        "~g~": "green",
        "~y~": "yellow",
        "~p~": "purple",
        "~c~": "grey",
        "~m~": "darkgrey",
        "~u~": "black",
        "~o~": "orange",
        "~h~": "font-weight: bold",
        "~n~": "<br>",
        "~w~": "white",
        "~s~": "white"
      };
    
      let newmsg = message;
      for (const colorCode in colorMap) {
        const regex = new RegExp(colorCode, "g");
        newmsg = newmsg.replace(regex, `<span style="color: ${colorMap[colorCode]}">`);
      }
      newmsg += "</span>";
    
      return newmsg;
    }
}
