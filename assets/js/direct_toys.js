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
  console.log('document ready')

  // direct toys
  //
  let joinButton = $("button.live-join")
  let listButton = $(".toys-list button")
  let toysList   = $(".toys-list")
  listButton.hide()
  let id = joinButton.data('id')
  let ul = $(".toys-list ul")
  let channel = socket.channel('live:' + id, null)

  joinButton.on('click', (e) => {
    console.log('join button clicked')
    channel.join()
      .receive("ok", live => {
        console.log("Joined Live topic")
        joinButton.after('<span><h3>Success! You\'ve joined the Live Channel!</h3></span>')
        listButton.show()

      })
      .receive("error", resp => console.log("Unable to join Live topic") )
  })


  listButton.on('click', (e) => {
    console.log('list button clicked')
    $('table').empty();
    channel.push('live:' + id, {module: "Inventory", function: "list_toys"})
      .receive("ok", (resp) => {
        console.log("table of toys = ", resp)
        DirectToys.list(toysList, resp.data)
      })
      .receive("error", (reasons) => console.log("create failed", reasons) )
      .receive("timeout", () => console.log("Networking issue...") )
  })

  // live update toys
  //
  let channelLive = socket.channel('live:rest', null)
  let liveUpdate = $(".live-toys-data")

  channelLive.join()
    .receive("ok", live => {
      console.log("Joined Live topic")
      joinButton.after('<span><h3>Success! You\'ve joined the Live Channel!</h3></span>')
      listButton.show()

    })
    .receive("error", resp => console.log("Unable to join Live topic") )
  channelLive.push('live:rest', {resource: "toy", op: "list"} )
    .receive("ok", (resp) => {
      console.log("live:rest html = ", resp.data)
      liveUpdate.html(resp.data)
    })
    .receive("error", (reasons) => console.log("create failed", reasons) )
    .receive("timeout", () => console.log("Networking issue...") )

  // red blue
  //
  let channelPaint = socket.channel("live:paint_it", null)
  channelPaint.join("paint_it")
  let liveDiv = $("#live-div")
  liveDiv.empty()

  let textInput = $("#live-text")
  let blueButton = $("#blue-button")
  let redButton = $("#red-button")

  blueButton.click(() => {
    console.log('blueButton click')
    channelPaint.push('live:paint_it', {color: 'blue', text: textInput.val()})
  })

  redButton.click(() => {
    console.log('redButton click')
    channelPaint.push('live:paint_it', {color: 'red', text: textInput.val()})
  })

  channelPaint.on('live_response', payload => {
    console.log('live response')
    liveDiv.empty()
    liveDiv.append(payload.html)
  })

});
