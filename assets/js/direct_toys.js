import socket from "./socket"
import { Toy } from "./toy"

export var DirectToys = {
  test: function(x) {
    console.log(x)
  },

  list: function(toysList, toys) {
    Toy.list(toysList, toys)
  }
}


$(function() {
  console.log('mfa document ready')
  let joinButton = $("button.mfa-join")
  let listButton = $(".toys-list button")
  let toysList   = $(".toys-list")
  listButton.hide()
  let id = joinButton.data('id')
  let ul = $(".toys-list ul")
  let channel = socket.channel('mfa:' + id, null)

  joinButton.on('click', (e) => {
    console.log('join button clicked')
    channel.join()
      .receive("ok", mfa => {
        console.log("Joined MFA topic")
        joinButton.after('<span><h3>Success! You\'ve joined the MFA Channel!</h3></span>')
        listButton.show()

      })
      .receive("error", resp => console.log("Unable to join MFA topic") )
  })


  listButton.on('click', (e) => {
    console.log('list button clicked')
    $('table').empty();
    channel.push('mfa:' + id, {module: "Inventory", function: "list_toys"})
      .receive("ok", (resp) => {
        console.log("table of toys = ", resp)
        DirectToys.list(toysList, resp.data)
      })
      .receive("error", (reasons) => console.log("create failed", reasons) )
      .receive("timeout", () => console.log("Networking issue...") )
  })
});
