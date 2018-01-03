import socket from "./socket"
import { Toy } from "./toy"


export var Mfa = {
  test: function(x) {
    console.log(x)
  },
  // display: function(button) {
  //   button.append('<h3>MFA Joined: mfa list:</h3>')
  // },

  list: function(ul, toys) {
    ul.empty();
    toys.map(x => Toy.show(ul, x))
  }
}



$(function() {
  console.log('mfa document ready')
  let joinButton = $("button.mfa-join")
  let listButton = $(".toys-list button")
  listButton.hide()
  let id = joinButton.data('id')
  let ul = $(".toys-list ul")
  let channel = socket.channel('mfa:' + id, null)

  joinButton.on('click', (e) => {
    console.log('join button clicked')
    console.log(this)


    channel.join()
      .receive("ok", mfa => {
        console.log("Joined MFA topic")
        joinButton.after('<span><h3>Success! You\'ve joined the MFA Channel!</h3></span>')
        listButton.show()

      })
      .receive("error", resp => {
        console.log("Unable to join MFA topic")
      })

  })

  listButton.on('click', (e) => {
    console.log('list button clicked')
    channel.push('mfa:' + id, {module: "Inventory", function: "list_toys"})
      .receive("ok", (resp) => {
        console.log("list of toys = ", resp)
        Mfa.list(ul, resp.data)
        Mfa.test('test')
      })
      .receive("error", (reasons) => console.log("create failed", reasons) )
      .receive("timeout", () => console.log("Networking issue...") )
  })
});
