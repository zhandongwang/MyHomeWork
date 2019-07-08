abstract class ListItem{

}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String body;
  final String sender;
  MessageItem(this.sender, this.body);
}