// to undertand how Event Bubbling in JavaScript works
// visit page https://www.freecodecamp.org/news/event-bubbling-in-javascript
export default function triggerEvent(eventName, eventData, bubbles = false) {
  var event = new CustomEvent(eventName, { bubbles: bubbles, detail: eventData });
  dispatchEvent(event);
}
