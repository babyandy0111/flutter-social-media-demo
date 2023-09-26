class NewsFeed {
  String owner;
  String avatarUrl;
  String date;
  String price;
  String content;
  String imageUrl;

  NewsFeed(
      {required this.owner,
      required this.avatarUrl,
      required this.date,
      required this.price,
      required this.content,
      required this.imageUrl});
}

final List<NewsFeed> newsfeed = [
  NewsFeed(
      owner: 'Martin Palmer',
      avatarUrl: 'https://picsum.photos/100/100',
      date: 'Today, 03:24 pm',
      content:'What is the loop of Creation? How is there something from nothng? In spite of the fact that it is impossible to prove that',
      imageUrl:'https://picsum.photos/300/150',
      price:'\$320.00',
      ),
  NewsFeed(
      owner: 'Pearl Myers',
      avatarUrl: 'https://picsum.photos/100/100',
      date: 'Yesterday',
      content:'I am looking for a chilled out roommate for a house on the 17th floor of a XZY appartmet',
      imageUrl: 'https://picsum.photos/300/150',
      price:'\$290.00',
      ),
  NewsFeed(
      owner: 'Gary Rose',
      avatarUrl: 'https://picsum.photos/100/100',
      date: 'Yesterday',
      content:'There is this awesome event happening . Let\'s join it guys',
      imageUrl: 'https://picsum.photos/300/150',
      price:'\$100.00',
      ), 
];
