import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:jsos_helper/models/message.dart';
import 'package:jsos_helper/repositories/message_repository.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/ui/components/loading_indicator.dart';
import 'package:jsos_helper/ui/screens/message_details_screen.dart';

// TODO - add infinite scroll
class MessagesScreen extends StatelessWidget {
  final String title;
  final MessageRepository _messageRepository;
  final StorageRepository storageRepository;

  MessagesScreen({
    Key key,
    @required this.title,
    @required this.storageRepository,
  })  : _messageRepository =
            MessageRepository(storageRepository: storageRepository),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 8.0),
          Expanded(child: _buildMessageList(context)),
        ],
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return FutureBuilder<List<Message>>(
      future: _messageRepository.getAllMessages(),
      builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('You have no messages'),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = snapshot.data[index];
                return _buildMessageCard(context, message);
              },
            );
          }
        } else {
          return LoadingIndicator();
        }
      },
    );
  }

  Widget _buildMessageCard(BuildContext context, Message message) {
    final DateFormat formatterDate = DateFormat("dd.MM.yyyy");
    final DateFormat formatterHours = DateFormat("HH:mm");

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageDetailsScreen(message: message),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.from,
                    overflow: TextOverflow.ellipsis,
                    style: DefaultTextStyle.of(context).style.apply(
                          fontSizeFactor: 1.3,
                          fontWeightDelta: 3,
                        ),
                  ),
                  Text(
                    message.subject,
                    overflow: TextOverflow.ellipsis,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.3),
                  ),
                  Text(
                    message.content,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(formatterDate.format(message.date)),
                    Text(formatterHours.format(message.date)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
