class Post_blueprint {
  String display_name;
  String timestamp;
  String post;
  String shared_from;
  String likes;
  String dislikes;
  String comments;

//constructor
  Post_blueprint(
    {
      required this.display_name,
      required this.timestamp,
      required this.post,
      required this.shared_from,
      required this.likes,
      required this.dislikes,
      required this.comments,
      }
        );
}
