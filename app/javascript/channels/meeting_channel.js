import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const meetingElement = document.getElementById('meeting-id')
  if (meetingElement) {
    const meetingId = meetingElement.getAttribute('data-meeting-id')
    consumer.subscriptions.create(
      { channel: "MeetingChannel", meeting_id: meetingId },
      {
        received(data) {
          console.log("Received data:", data)
          // ここでDOMを更新するなど
        }
      }
    )
  }
})
