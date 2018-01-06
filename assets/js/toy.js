import socket from "./socket"

export var Toy = {
  show: function(ul, toy) {
    console.log('toy show: ', toy)
    ul.empty();
    ul
      .append('<li><strong>ID:</strong> ' + toy.id + '</li>')
      .append('<li><strong>Name:</strong> ' + toy.name + '</li>')
      .append('<li><strong>Color:</strong> ' + toy.color + '</li>')
      .append('<li><strong>Age:</strong> ' + toy.age + '</li>');
  },

  list: function(toysList, toys) {
    console.log('toy list: ', toys)
    var $table = $('table')

    var columns = ['ID', 'NAME', 'COLOR', 'AGE']
    this.addHeaders($table, columns)

    $table.append('<tbody></tbody>');
    var $tbody = $('table tbody')
    for (var i = 0, len = toys.length; i < len; i++) {
      this.addRow($tbody, toys[i])
    }
  },

  addHeaders: function($table, columns) {
    $table.append('<thead><tr></tr></thead>');
    var $thead = $('table > thead > tr:first');
    for (var i = 0, len = columns.length; i < len; i++) {
        $thead.append('<th>'+columns[i]+'</th>');
    }
  },

  addRow: function(tbody, toy) {
    tbody.append($("<tr></tr>")
      .append('<td>' + toy.id + '</td>')
      .append('<td>' + toy.name + '</td>')
      .append('<td>' + toy.color + '</td>')
      .append('<td>' + toy.age + '</td>')
    )
  }
}


$(function() {
  let ul = $("ul#show-list")
  if (ul.length) {
    var id = ul.data("id")
    var topic = "toys:" + id

    // Join the topic
    let channel = socket.channel(topic, {})
    channel.join()
      .receive("ok", toy => {
        console.log("Joined topic", topic)
        Toy.show(ul, toy);
      })
      .receive("error", resp => {
        console.log("Unable to join topic", topic)
      })

    channel.on("change", toy => {
      console.log("Change:", toy);
      Toy.show(ul, toy);
    })
  }
});
